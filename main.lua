--[[
    Script: Burgerz Automation Hub
    UI: Urban UI Library (Red Theme)
    Fitur: Aimbot, FOV, Snapline, Smoothing, Body Part
]]

-- 1. Load Urban UI Library
local WIND = loadstring(game:HttpGet("https://raw.githubusercontent.com/vortex-py/Urban-Ui-Library/refs/heads/main/load-ui.lua"))()

-- 2. Buat Window Utama
local Window = WIND:CreateWindow({
    Title = "BURGERZ HUB",
    SubTitle = "Aimbot Edition",
    Size = UDim2.new(0, 520, 0, 350),
    Icon = "rbxassetid://80788381547970",
    FloatIcon = "rbxassetid://80788381547970",
    FloatIconSize = 36
})

-- 3. Buat Tab Aimbot (sesuai gambar kamu)
local MainTab = Window:CreateTab("aimbot")
local AimbotSec = MainTab:AddSection("Aimbot Settings")

-- ==================== KONFIGURASI DEFAULT ====================
getgenv().Aimbot_Enabled = false
getgenv().Aimbot_FOV = 120
getgenv().Aimbot_Smoothing = 0.15
getgenv().Aimbot_BodyPart = "Head"
getgenv().Aimbot_ShowSnapline = true
getgenv().Aimbot_TargetNPC = true

-- ==================== DRAWING (FOV & SNAPLINE) ====================
local hasDrawing = pcall(function() return Drawing.new("Circle") end)
local fovCircle, snapline

if hasDrawing then
    fovCircle = Drawing.new("Circle")
    fovCircle.Thickness = 1
    fovCircle.NumSides = 60
    fovCircle.Radius = getgenv().Aimbot_FOV
    fovCircle.Filled = false
    fovCircle.Color = Color3.fromRGB(255, 50, 50)
    fovCircle.Visible = false
    fovCircle.Transparency = 1

    snapline = Drawing.new("Line")
    snapline.Thickness = 2
    snapline.Color = Color3.fromRGB(255, 50, 50)
    snapline.Visible = false
    snapline.Transparency = 1
else
    warn("Executor tidak support Drawing API. FOV & Snapline tidak akan tampil.")
end

-- ==================== FUNGSI CARI TARGET ====================
local function getClosestTarget()
    local myChar = game.Players.LocalPlayer.Character
    if not myChar or not myChar:FindFirstChild("HumanoidRootPart") then return nil, nil end

    local screenSize = workspace.CurrentCamera.ViewportSize
    local centerX, centerY = screenSize.X / 2, screenSize.Y / 2

    local closestPart = nil
    local shortestDist = getgenv().Aimbot_FOV
    local targetScreenPos = nil

    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj ~= myChar then
            local humanoid = obj:FindFirstChildOfClass("Humanoid")
            if humanoid and humanoid.Health > 0 then
                local part = obj:FindFirstChild(getgenv().Aimbot_BodyPart)
                if not part then part = obj:FindFirstChild("HumanoidRootPart") end
                if not part then continue end

                local screenPos, onScreen = workspace.CurrentCamera:WorldToViewportPoint(part.Position)
                if onScreen then
                    local dist = (Vector2.new(screenPos.X, screenPos.Y) - Vector2.new(centerX, centerY)).Magnitude
                    if dist <= getgenv().Aimbot_FOV and dist < shortestDist then
                        -- Filter target: hanya NPC/Cop/Customer
                        local name = obj.Name:lower()
                        if getgenv().Aimbot_TargetNPC then
                            if name:find("npc") or name:find("cop") or name:find("customer") or name:find("pelanggan") then
                                shortestDist = dist
                                closestPart = part
                                targetScreenPos = Vector2.new(screenPos.X, screenPos.Y)
                            end
                        end
                    end
                end
            end
        end
    end
    return closestPart, targetScreenPos
end

-- ==================== LOOP AIMBOT ====================
game:GetService("RunService").RenderStepped:Connect(function()
    local screenSize = workspace.CurrentCamera.ViewportSize
    local centerX, centerY = screenSize.X / 2, screenSize.Y / 2

    -- Update FOV Circle
    if fovCircle then
        fovCircle.Position = Vector2.new(centerX, centerY)
        fovCircle.Radius = getgenv().Aimbot_FOV
        fovCircle.Visible = getgenv().Aimbot_Enabled
    end

    if not getgenv().Aimbot_Enabled then
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

        local targetCFrame = CFrame.lookAt(workspace.CurrentCamera.CFrame.Position, targetPart.Position)
        workspace.CurrentCamera.CFrame = workspace.CurrentCamera.CFrame:Lerp(targetCFrame, getgenv().Aimbot_Smoothing)
    else
        if snapline then snapline.Visible = false end
    end
end)

-- ==================== UI UNTUK AIMBOT ====================

AimbotSec:AddToggle("Enable Aimbot", false, function(state)
    getgenv().Aimbot_Enabled = state
end)

AimbotSec:AddSlider("FOV Size", 10, 500, 120, function(value)
    getgenv().Aimbot_FOV = value
end)

AimbotSec:AddSlider("Smoothing", 1, 100, 15, function(value)
    getgenv().Aimbot_Smoothing = value / 100 -- Ubah 1-100 jadi 0.01 - 1
end)

AimbotSec:AddDropdown("Body Part", {"Head", "UpperTorso", "HumanoidRootPart", "LowerTorso"}, function(value)
    getgenv().Aimbot_BodyPart = value
end)

AimbotSec:AddToggle("Show Snapline", true, function(state)
    getgenv().Aimbot_ShowSnapline = state
end)

AimbotSec:AddToggle("Target NPC/Cop/Customer", true, function(state)
    getgenv().Aimbot_TargetNPC = state
end)

WIND:Notify({
    Title = "Burgerz Hub",
    Content = "Aimbot Loaded!",
    Duration = 5
})
