--[[
    Script: Universal Aimbot
    UI: WindUI Library (Crimson Red Theme)
    Fitur: Aimbot, FOV, Snapline, Smoothing, Body Part, Team Check, Visible Check, Keybind
]]

-- 1. Load WindUI Library
local WindUI = loadstring(game:HttpGet("https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"))()

-- 2. Set Tema Crimson Red
WindUI:SetTheme("Crimson")

-- 3. Buat Window Utama
local Window = WindUI:CreateWindow({
    Title = "Universal Aimbot",
    SubTitle = "Crimson Edition",
    Icon = "rbxassetid://80788381547970",
    Size = UDim2.new(0, 520, 0, 480),
    Transparent = true,
    Theme = "Crimson"
})

-- 4. Buat Tab
local MainTab = Window:Tab({ Title = "Aimbot", Icon = "crosshair" })
local VisualTab = Window:Tab({ Title = "Visual", Icon = "eye" })

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
getgenv().Aimbot_AutoShoot = false
getgenv().Aimbot_Keybind = Enum.KeyCode.RightAlt -- Default: Right Alt

-- ==================== DRAWING API ====================
local hasDrawing = pcall(function() return Drawing.new("Circle") end)
local fovCircle, snapline

if hasDrawing then
    fovCircle = Drawing.new("Circle")
    fovCircle.Thickness = 1
    fovCircle.NumSides = 60
    fovCircle.Radius = getgenv().Aimbot_FOV
    fovCircle.Filled = false
    fovCircle.Color = Color3.fromRGB(220, 20, 60) -- Crimson
    fovCircle.Visible = false
    fovCircle.Transparency = 1

    snapline = Drawing.new("Line")
    snapline.Thickness = 2
    snapline.Color = Color3.fromRGB(220, 20, 60)
    snapline.Visible = false
    snapline.Transparency = 1
else
    WindUI:Notify({ Title = "Error", Content = "Executor tidak support Drawing API!", Duration = 5 })
end

-- ==================== FUNGSI UTILITY ====================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")
local Camera = Workspace.CurrentCamera
local LocalPlayer = Players.LocalPlayer

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
local UserInputService = game:GetService("UserInputService")
local isKeyHeld = false

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

-- ==================== LOOP AIMBOT ====================
RunService.RenderStepped:Connect(function()
    local screenSize = Camera.ViewportSize
    local centerX, centerY = screenSize.X / 2, screenSize.Y / 2

    if fovCircle then
        fovCircle.Position = Vector2.new(centerX, centerY)
        fovCircle.Radius = getgenv().Aimbot_FOV
        fovCircle.Visible = getgenv().Aimbot_Enabled
    end

    if not getgenv().Aimbot_Enabled or not isKeyHeld then
        if snapline then snapline.Visible = false end
        return
    end

    local targetPart, targetScreenPos = getClosestTarget()

    if targetPart then
        if snapline and getgenv().Aimbot_ShowSnapline then
            snapline.From = Vector2.new(centerX, centerY)
            snapline.To = targetScreenPos
            snapline.Visible = true
        elseif snapline then
            snapline.Visible = false
        end

        local targetCFrame = CFrame.lookAt(Camera.CFrame.Position, targetPart.Position)
        Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, getgenv().Aimbot_Smoothing)

        if getgenv().Aimbot_AutoShoot then
            -- Simulasi klik kiri (mungkin tidak berfungsi di semua executor/game)
            pcall(function()
                local mouse = LocalPlayer:GetMouse()
                if mouse and mouse.Target then
                    mouse1click()
                end
            end)
        end
    else
        if snapline then snapline.Visible = false end
    end
end)

-- ==================== UI: TAB AIMBOT ====================
MainTab:Section({ Title = "Aimbot Settings" })

MainTab:Toggle({
    Title = "Enable Aimbot",
    Desc = "Aktifkan fitur Aimbot",
    Value = false,
    Callback = function(state)
        getgenv().Aimbot_Enabled = state
    end
})

MainTab:Keybind({
    Title = "Aimbot Keybind",
    Desc = "Tombol untuk mengunci target",
    Value = getgenv().Aimbot_Keybind,
    Callback = function(key)
        getgenv().Aimbot_Keybind = key
    end
})

MainTab:Slider({
    Title = "FOV Size",
    Desc = "Radius area kuncian",
    Value = { Min = 10, Max = 500, Default = 120 },
    Callback = function(value)
        getgenv().Aimbot_FOV = value
    end
})

MainTab:Slider({
    Title = "Smoothing",
    Desc = "1 = Instan, 100 = Lambat/Natural",
    Value = { Min = 1, Max = 100, Default = 15 },
    Callback = function(value)
        getgenv().Aimbot_Smoothing = value / 100
    end
})

MainTab:Dropdown({
    Title = "Body Part",
    Desc = "Bagian tubuh yang dikunci",
    Values = { "Head", "UpperTorso", "HumanoidRootPart", "LowerTorso" },
    Default = "Head",
    Callback = function(value)
        getgenv().Aimbot_BodyPart = value
    end
})

MainTab:Section({ Title = "Target Filter" })

MainTab:Toggle({
    Title = "Target NPC",
    Desc = "Kunci ke NPC",
    Value = true,
    Callback = function(state)
        getgenv().Aimbot_TargetNPC = state
    end
})

MainTab:Toggle({
    Title = "Target Players",
    Desc = "Kunci ke pemain lain",
    Value = false,
    Callback = function(state)
        getgenv().Aimbot_TargetPlayers = state
    end
})

MainTab:Toggle({
    Title = "Team Check",
    Desc = "Jangan kunci ke rekan setim",
    Value = true,
    Callback = function(state)
        getgenv().Aimbot_TeamCheck = state
    end
})

MainTab:Toggle({
    Title = "Visible Check",
    Desc = "Hanya kunci yang terlihat (tidak tembus tembok)",
    Value = false,
    Callback = function(state)
        getgenv().Aimbot_VisibleCheck = state
    end
})

-- ==================== UI: TAB VISUAL ====================
VisualTab:Section({ Title = "Visual Settings" })

VisualTab:Toggle({
    Title = "Show Snapline",
    Desc = "Tampilkan garis ke target",
    Value = true,
    Callback = function(state)
        getgenv().Aimbot_ShowSnapline = state
    end
})

VisualTab:Toggle({
    Title = "Auto Shoot",
    Desc = "Otomatis klik kiri saat target terkunci (tidak semua game support)",
    Value = false,
    Callback = function(state)
        getgenv().Aimbot_AutoShoot = state
    end
})

-- Notifikasi
WindUI:Notify({
    Title = "Universal Aimbot",
    Content = "Script berhasil dimuat!",
    Duration = 5
})
