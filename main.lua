--[[
    Script: Universal Aimbot (Camera Lock)
    UI: Urban UI Library (Red Theme)
    Fitur: Aimbot, FOV, Snapline, Smoothing, Body Part, Team Check, Visible Check, Keybind
]]

-- 1. Load Urban UI Library
local WIND = loadstring(game:HttpGet("https://raw.githubusercontent.com/vortex-py/Urban-Ui-Library/refs/heads/main/load-ui.lua"))()

-- 2. Load Tema Merah (Crimson Red)
local success, theme = pcall(function()
    return loadstring(game:HttpGet("https://raw.githubusercontent.com/vortex-py/Urban-Ui-Library/refs/heads/main/v4.0/load-ui/urban-ui/theme/red.lua"))()
end)

-- 3. Buat Window Utama
local Window = WIND:CreateWindow({
    Title = "UNIVERSAL AIMBOT",
    SubTitle = "Crimson Edition",
    Size = UDim2.new(0, 520, 0, 480),
    Icon = "rbxassetid://80788381547970", -- Ganti dengan ID icon merah jika ada
    FloatIcon = "rbxassetid://80788381547970",
    FloatIconSize = 36,
    Theme = "Red" -- Memaksa tema merah
})

-- 4. Buat Tabs
local MainTab = Window:CreateTab("Aimbot")
local VisualTab = Window:CreateTab("Visual")

-- ==================== KONFIGURASI DEFAULT ====================
getgenv().Aimbot_Enabled = false
getgenv().Aimbot_FOV = 120
getgenv().Aimbot_Smoothing = 0.15
getgenv().Aimbot_BodyPart = "Head"
getgenv().Aimbot_ShowSnapline = true
getgenv().Aimbot_TargetNPC = true
getgenv().Aimbot_TargetPlayers = false
getgenv().Aimbot_TeamCheck = true
getgenv().Aimbot_VisibleCheck = false
getgenv().Aimbot_Keybind = Enum.KeyCode.RightAlt

-- ==================== DRAWING API (FOV & SNAPLINE) ====================
local hasDrawing = pcall(function() return Drawing.new("Circle") end)
local fovCircle, snapline

if hasDrawing then
    fovCircle = Drawing.new("Circle")
    fovCircle.Thickness = 1
    fovCircle.NumSides = 60
    fovCircle.Radius = getgenv().Aimbot_FOV
    fovCircle.Filled = false
    fovCircle.Color = Color3.fromRGB(220, 20, 60) -- Crimson Red
    fovCircle.Visible = false
    fovCircle.Transparency = 1

    snapline = Drawing.new("Line")
    snapline.Thickness = 2
    snapline.Color = Color3.fromRGB(220, 20, 60) -- Crimson Red
    snapline.Visible = false
    snapline.Transparency = 1
else
    WIND:Notify({ Title = "Error", Content = "Executor tidak support Drawing API!", Duration = 5 })
end

-- ==================== SERVICES & VARIABEL ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

local isKeyHeld = false

-- ==================== FUNGSI UTILITY ====================
local function isVisible(targetPart)
    if not getgenv().Aimbot_VisibleCheck then return true end
    local rayParams = RaycastParams.new()
    rayParams.FilterDescendantsInstances = {LocalPlayer.Character, Camera}
    rayParams.FilterType = Enum.RaycastFilterType.Exclude
    local direction = (targetPart.Position - Camera.CFrame.Position).Unit * 1000
    local ray = Workspace:Raycast(Camera.CFrame.Position, direction, rayParams)
    if ray and ray.Instance then
        return ray.Instance:IsDescendantOf(targetPart.Parent)
    end
    return true
end

local function isTeammate(player)
    if not getgenv().Aimbot_TeamCheck then return false end
    local myTeam = LocalPlayer.Team
    if myTeam and player.Team == myTeam then return true end
    return false
end

-- ==================== FUNGSI CARI TARGET ====================
local function getClosestTarget()
    local myChar = LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil, nil end

    local screenSize = Camera.ViewportSize
    local centerX, centerY = screenSize.X / 2, screenSize.Y / 2

    local closestPart = nil
    local shortestDist = getgenv().Aimbot_FOV
    local targetScreenPos = nil

    for _, obj in ipairs(Workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= myChar then
            local humanoid = obj:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local part = obj:FindFirstChild(getgenv().Aimbot_BodyPart)
                if not part then part = obj:FindFirstChild("HumanoidRootPart") end
                if not part then continue end

                local screenPos, onScreen = Camera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(centerX, centerY)).Magnitude
                    if dist <= getgenv().Aimbot_FOV and dist < shortestDist then
                        local isPlayer = Players:GetPlayerFromCharacter(obj)
                        local isValid = false

                        if isPlayer then
                            if getgenv().Aimbot_TargetPlayers and not isTeammate(isPlayer) then
                                isValid = true
                            end
                        else
                            if getgenv().Aimbot_TargetNPC then
                                isValid = true
                            end
                        end

                        if isValid and isVisible(part) then
                            shortestDist = dist
                            closestPart = part
                            targetScreenPos = Vector2.new(screenPos.X, screenPos.Y)
                        end
                    end
                end
            end
        end
    end
    return closestPart, targetScreenPos
end

-- ==================== LOGIKA KEYBIND ====================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == getgenv().Aimbot_Keybind then
        isKeyHeld = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode == getgenv().Aimbot_Keybind then
        isKeyHeld = false
    end
end)

-- ==================== LOOP AIMBOT (IMPROVED) ====================
-- Menggunakan BindToRenderStep dengan prioritas tinggi agar camera lock bekerja mulus
RunService:BindToRenderStep("UniversalAimbot", Enum.RenderPriority.Camera.Value + 1, function()
    local screenSize = Camera.ViewportSize
    local centerX, centerY = screenSize.X / 2, screenSize.Y / 2

    -- Update FOV Circle
    if fovCircle then
        fovCircle.Position = Vector2.new(centerX, centerY)
        fovCircle.Radius = getgenv().Aimbot_FOV
        fovCircle.Visible = getgenv().Aimbot_Enabled
    end

    -- Jika Aimbot mati atau keybind tidak ditekan, matikan snapline dan return
    if not getgenv().Aimbot_Enabled or not isKeyHeld then
        if snapline then snapline.Visible = false end
        return
    end

    local targetPart, targetScreenPos = getClosestTarget()

    if targetPart then
        -- Update Snapline
        if snapline and getgenv().Aimbot_ShowSnapline then
            snapline.From = Vector2.new(centerX, centerY)
            snapline.To = targetScreenPos
            snapline.Visible = true
        elseif snapline then
            snapline.Visible = false
        end

        -- Camera Lock (Smooth)
        local targetCFrame = CFrame.lookAt(Camera.CFrame.Position, targetPart.Position)
        Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, getgenv().Aimbot_Smoothing)
    else
        if snapline then snapline.Visible = false end
    end
end)

-- ==================== UI: TAB AIMBOT ====================
MainTab:AddToggle("Enable Aimbot", false, function(state)
    getgenv().Aimbot_Enabled = state
end)

MainTab:AddSlider("FOV Size", 10, 500, 120, function(value)
    getgenv().Aimbot_FOV = value
end)

MainTab:AddSlider("Smoothing", 1, 100, 15, function(value)
    getgenv().Aimbot_Smoothing = value / 100 -- Ubah 1-100 jadi 0.01 - 1
end)

MainTab:AddDropdown("Body Part", {"Head", "UpperTorso", "HumanoidRootPart", "LowerTorso"}, function(value)
    getgenv().Aimbot_BodyPart = value
end)

MainTab:AddToggle("Target NPC", true, function(state)
    getgenv().Aimbot_TargetNPC = state
end)

MainTab:AddToggle("Target Players", false, function(state)
    getgenv().Aimbot_TargetPlayers = state
end)

MainTab:AddToggle("Team Check", true, function(state)
    getgenv().Aimbot_TeamCheck = state
end)

MainTab:AddToggle("Visible Check", false, function(state)
    getgenv().Aimbot_VisibleCheck = state
end)

-- ==================== UI: TAB VISUAL ====================
VisualTab:AddToggle("Show Snapline", true, function(state)
    getgenv().Aimbot_ShowSnapline = state
end)

-- Notifikasi
WIND:Notify({
    Title = "Universal Aimbot",
    Content = "Script berhasil dimuat! Tekan Right Alt untuk mengunci target.",
    Duration = 5
})
