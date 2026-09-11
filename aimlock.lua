-- =====================
-- MACLIB AIMLOCK LOADER
-- =====================
local MacLib
local success, err = pcall(function()
    MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Saucyboy/MacLib/main/Library.lua"))()
end)

if not success or not MacLib then
    warn("Failed to load MacLib: " .. tostring(err))
    return
end

local Window = MacLib:CreateWindow({
    Name = "Zik Aimlock Pro",
    Subtitle = "Advanced Targeting System",
    Size = UDim2.new(0, 500, 0, 400),
    Transparency = 0.2,
    Color = Color3.new(1, 0, 0), -- Red theme
})

-- =====================
-- SERVICES & VARIABLES
-- =====================
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

-- Aimlock settings
getgenv().AimlockSettings = getgenv().AimlockSettings or {
    AimlockEnabled = false,
    TargetType = "player", -- player, npc, all
    MaxDistance = 100,
    LockType = "head", -- head, torso, hrp
    Smoothness = 0.5,
    OnlyWhenAiming = true,
    AimKey = Enum.KeyCode.E,
    ShowFOV = true,
    FOVSize = 50,
}

local SelectedTarget = nil
local IsAiming = false
local Connection = nil

-- =====================
-- UTILITY FUNCTIONS
-- =====================
local function findHumanoid(model)
    if not model then return nil end
    for _, v in pairs(model:GetDescendants()) do
        if v and v:IsA("Humanoid") then
            return v
        end
    end
    return nil
end

local function getHRP()
    if not LocalPlayer or not LocalPlayer.Character then return nil end
    return LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
end

local function getDistance(pos1, pos2)
    if not pos1 or not pos2 then return math.huge end
    return (pos1 - pos2).Magnitude
end

local function notify(title, message)
    if MacLib then
        MacLib:Notify(title, message, 3)
    end
end

local function getTargetPart(target)
    if not target then return nil end
    
    local lockType = getgenv().AimlockSettings.LockType
    
    if lockType == "head" then
        return target:FindFirstChild("Head")
    elseif lockType == "torso" then
        return target:FindFirstChild("Torso") or target:FindFirstChild("UpperTorso")
    else
        return target:FindFirstChild("HumanoidRootPart")
    end
end

local function isValidTarget(model)
    if not model or not model.Parent then return false end
    if model == LocalPlayer.Character then return false end
    
    local humanoid = findHumanoid(model)
    if not humanoid or humanoid.Health <= 0 then return false end
    
    local targetType = getgenv().AimlockSettings.TargetType
    local name = model.Name:lower()
    
    if targetType == "player" then
        return Players:FindFirstChild(model.Name) ~= nil
    elseif targetType == "npc" then
        return name:find("npc") or name:find("customer") or name:find("cop")
    else -- all
        return true
    end
end

local function findNearestTarget()
    local hrp = getHRP()
    if not hrp then return nil end
    
    local nearest = nil
    local nearestDist = getgenv().AimlockSettings.MaxDistance
    
    for _, model in pairs(workspace:GetDescendants()) do
        if model:IsA("Model") and isValidTarget(model) then
            local targetHRP = model:FindFirstChild("HumanoidRootPart")
            if targetHRP then
                local dist = getDistance(targetHRP.Position, hrp.Position)
                
                -- Check if in FOV
                if getgenv().AimlockSettings.ShowFOV then
                    local screenPos = Camera:WorldToScreenPoint(targetHRP.Position)
                    local mousePos = UserInputService:GetMouseLocation()
                    local distance = (Vector2.new(screenPos.X, screenPos.Y) - mousePos).Magnitude
                    
                    if distance > getgenv().AimlockSettings.FOVSize then
                        continue
                    end
                end
                
                if dist < nearestDist then
                    nearestDist = dist
                    nearest = model
                end
            end
        end
    end
    
    return nearest
end

local function updateAimlock()
    if not getgenv().AimlockSettings.AimlockEnabled then return end
    if not IsAiming and getgenv().AimlockSettings.OnlyWhenAiming then return end
    
    local target = SelectedTarget or findNearestTarget()
    if not target then
        SelectedTarget = nil
        return
    end
    
    SelectedTarget = target
    local targetPart = getTargetPart(target)
    
    if targetPart then
        local smoothness = getgenv().AimlockSettings.Smoothness
        local targetCFrame = CFrame.new(Camera.CFrame.Position, targetPart.Position)
        Camera.CFrame = Camera.CFrame:Lerp(targetCFrame, smoothness)
    end
end

local function drawFOV()
    if not getgenv().AimlockSettings.ShowFOV or not getgenv().AimlockSettings.AimlockEnabled then return end
    
    local fovSize = getgenv().AimlockSettings.FOVSize
    local mousePos = UserInputService:GetMouseLocation()
    
    -- Simple FOV visualization (dapat ditingkatkan dengan drawing library)
end

-- =====================
-- AIMLOCK TAB
-- =====================
local AimlockTab = Window:CreateTab("Aimlock")

AimlockTab:CreateLabel("Aimlock Settings", true)

AimlockTab:CreateToggle({
    Name = "Enable Aimlock",
    Default = false,
    Callback = function(state)
        getgenv().AimlockSettings.AimlockEnabled = state
        if state then
            notify("Aimlock", "✓ Enabled")
            
            -- Start aimlock loop
            if Connection then
                Connection:Disconnect()
            end
            Connection = RunService.RenderStepped:Connect(function()
                updateAimlock()
            end)
        else
            notify("Aimlock", "✗ Disabled")
            if Connection then
                Connection:Disconnect()
                Connection = nil
            end
        end
    end,
})

AimlockTab:CreateDropdown({
    Name = "Target Type",
    Options = {"player", "npc", "all"},
    Default = "player",
    Callback = function(value)
        getgenv().AimlockSettings.TargetType = value
        SelectedTarget = nil
    end,
})

AimlockTab:CreateDropdown({
    Name = "Lock Part",
    Options = {"head", "torso", "hrp"},
    Default = "head",
    Callback = function(value)
        getgenv().AimlockSettings.LockType = value
    end,
})

AimlockTab:CreateSlider({
    Name = "Max Distance",
    Min = 10,
    Max = 500,
    Default = 100,
    Increment = 10,
    Callback = function(value)
        getgenv().AimlockSettings.MaxDistance = value
    end,
})

AimlockTab:CreateSlider({
    Name = "Smoothness",
    Min = 0.1,
    Max = 1,
    Default = 0.5,
    Increment = 0.1,
    Callback = function(value)
        getgenv().AimlockSettings.Smoothness = value
    end,
})

AimlockTab:CreateToggle({
    Name = "Only When Aiming",
    Default = true,
    Callback = function(state)
        getgenv().AimlockSettings.OnlyWhenAiming = state
    end,
})

AimlockTab:CreateToggle({
    Name = "Show FOV",
    Default = true,
    Callback = function(state)
        getgenv().AimlockSettings.ShowFOV = state
    end,
})

AimlockTab:CreateSlider({
    Name = "FOV Size",
    Min = 10,
    Max = 500,
    Default = 50,
    Increment = 10,
    Callback = function(value)
        getgenv().AimlockSettings.FOVSize = value
    end,
})

AimlockTab:CreateLabel("Press E to hold aim", false)
AimlockTab:CreateLabel("Release to deselect target", false)

-- =====================
-- ADVANCED TAB
-- =====================
local AdvancedTab = Window:CreateTab("Advanced")

AdvancedTab:CreateLabel("Advanced Options", true)

AdvancedTab:CreateButton({
    Name = "Lock Nearest Target",
    Callback = function()
        local target = findNearestTarget()
        if target then
            SelectedTarget = target
            notify("Aimlock", "Target locked!")
        else
            notify("Aimlock", "No target found!")
        end
    end,
})

AdvancedTab:CreateButton({
    Name = "Clear Target",
    Callback = function()
        SelectedTarget = nil
        notify("Aimlock", "Target cleared!")
    end,
})

AdvancedTab:CreateLabel("Developer: zikXcodes", false)
AdvancedTab:CreateLabel("Aimlock Pro v1.0", false)

-- =====================
-- INPUT HANDLING
-- =====================
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    if input.KeyCode == getgenv().AimlockSettings.AimKey then
        IsAiming = true
    end
end)

UserInputService.InputEnded:Connect(function(input, gameProcessed)
    if input.KeyCode == getgenv().AimlockSettings.AimKey then
        IsAiming = false
        SelectedTarget = nil
    end
end)

-- =====================
-- CLEANUP
-- =====================
game:BindToClose(function()
    if Connection then
        Connection:Disconnect()
    end
end)

-- =====================
-- STARTUP
-- =====================
notify("Aimlock Pro", "Script loaded! Press E to aim 🎯")
print("✓ MacLib Aimlock Script Loaded Successfully!")
print("✓ Game: Burgerz")
