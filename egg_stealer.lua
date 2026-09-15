-- =====================
-- EGG STEALER SCRIPT - OBSIDIAN LOADER
-- =====================

local ObsidianLoader = loadstring(game:HttpGet("https://raw.githubusercontent.com/ObsidianLoader/ObsidianLoader/main/Source.lua"))()

-- =====================
-- SERVICES & VARIABLES
-- =====================
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

-- Prevent duplicate UI
if getgenv().EggStealerLoaded then
    warn("Egg Stealer already loaded!")
    return
end
getgenv().EggStealerLoaded = true

-- Global settings
getgenv().EggStealerSettings = {
    AutoStealEnabled = false,
    StealRange = 50,
    StealSpeed = 0.5,
    TargetEggType = "all", -- "all", "golden", "diamond", "legendary"
    TeleportToEgg = false,
    AutoCollectEnabled = false,
    StealDelay = 0.2,
}

-- =====================
-- UTILITY FUNCTIONS
-- =====================
local function getHRP()
    if not LocalPlayer or not LocalPlayer.Character then return nil end
    return LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
end

local function getDistance(pos1, pos2)
    if not pos1 or not pos2 then return math.huge end
    return (pos1 - pos2).Magnitude
end

local function notify(title, content, duration)
    duration = duration or 3
    print("[" .. title .. "] " .. content)
end

local function findEggs()
    local eggs = {}
    local hrp = getHRP()
    if not hrp then return eggs end
    
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BasePart") or obj:IsA("Model") then
            local name = obj.Name:lower()
            
            -- Check if object matches egg criteria
            if name:find("egg") or name:find("golden") or name:find("diamond") or name:find("legendary") then
                local pos
                if obj:IsA("BasePart") then
                    pos = obj.Position
                else
                    local part = obj:FindFirstChildWhichIsA("BasePart")
                    if part then pos = part.Position end
                end
                
                if pos then
                    local distance = getDistance(pos, hrp.Position)
                    if distance <= getgenv().EggStealerSettings.StealRange then
                        table.insert(eggs, {
                            Object = obj,
                            Position = pos,
                            Distance = distance,
                            Name = obj.Name
                        })
                    end
                end
            end
        end
    end
    
    -- Sort by distance
    table.sort(eggs, function(a, b) return a.Distance < b.Distance end)
    return eggs
end

local function stealEgg(eggObject)
    local hrp = getHRP()
    if not hrp or not eggObject then return false end
    
    local eggPos = nil
    if eggObject:IsA("BasePart") then
        eggPos = eggObject.Position
    else
        local part = eggObject:FindFirstChildWhichIsA("BasePart")
        if part then eggPos = part.Position end
    end
    
    if not eggPos then return false end
    
    local success, err = pcall(function()
        -- Teleport to egg if enabled
        if getgenv().EggStealerSettings.TeleportToEgg then
            hrp.CFrame = CFrame.new(eggPos + Vector3.new(0, 3, 0))
            wait(0.1)
        else
            -- Move towards egg
            local direction = (eggPos - hrp.Position).Unit
            hrp.CFrame = hrp.CFrame + direction * 2
        end
        
        -- Try to grab/interact with egg
        if eggObject:IsA("BasePart") then
            local char = LocalPlayer.Character
            if char then
                local playerPart = char:FindFirstChildWhichIsA("BasePart")
                if playerPart then
                    pcall(function()
                        firetouchinterest(eggObject, playerPart, 0)
                        wait(0.05)
                        firetouchinterest(eggObject, playerPart, 1)
                    end)
                end
            end
        end
        
        -- Fire RemoteEvent if exists
        local remotes = eggObject:FindFirstChildOfClass("RemoteEvent")
        if not remotes then
            remotes = eggObject.Parent:FindFirstChildOfClass("RemoteEvent")
        end
        
        if remotes then
            pcall(function()
                remotes:FireServer()
            end)
        end
        
        return true
    end)
    
    if not success then
        warn("Steal Error:", err)
        return false
    end
    
    return true
end

-- =====================
-- AUTO STEAL FUNCTION
-- =====================
local function startAutoSteal()
    if not getgenv().EggStealerSettings.AutoStealEnabled then
        return
    end
    
    spawn(function()
        while getgenv().EggStealerSettings.AutoStealEnabled do
            local hrp = getHRP()
            if not hrp then
                wait(0.1)
                continue
            end
            
            local eggs = findEggs()
            
            if #eggs > 0 then
                local egg = eggs[1]
                if stealEgg(egg.Object) then
                    notify("Egg Stealer", "Stole: " .. egg.Name, 2)
                end
            end
            
            wait(getgenv().EggStealerSettings.StealDelay)
        end
    end)
end

-- =====================
-- CREATE WINDOW (Once only)
-- =====================
if not getgenv().EggStealerWindow then
    local Window = ObsidianLoader:CreateWindow({
        Name = "Egg Stealer",
        Size = UDim2.new(0, 500, 0, 600),
        HasClose = true,
        ContentPadding = true,
    })
    
    getgenv().EggStealerWindow = Window
    
    -- =====================
    -- MAIN TAB
    -- =====================
    local MainTab = Window:CreateTab("Main", "home")
    
    MainTab:AddLabel("Egg Stealer v1.0")
    MainTab:AddDivider()
    
    MainTab:AddToggle({
        Name = "Enable Auto Steal",
        Default = false,
        Callback = function(value)
            getgenv().EggStealerSettings.AutoStealEnabled = value
            if value then
                startAutoSteal()
                notify("Auto Steal", "Enabled ✓", 3)
            else
                notify("Auto Steal", "Disabled ✗", 3)
            end
        end
    })
    
    MainTab:AddSlider({
        Name = "Steal Range",
        Min = 10,
        Max = 200,
        Default = 50,
        Callback = function(value)
            getgenv().EggStealerSettings.StealRange = value
        end
    })
    
    MainTab:AddSlider({
        Name = "Steal Speed",
        Min = 0.1,
        Max = 2,
        Default = 0.5,
        Callback = function(value)
            getgenv().EggStealerSettings.StealSpeed = value
            getgenv().EggStealerSettings.StealDelay = 1 / value
        end
    })
    
    MainTab:AddToggle({
        Name = "Teleport to Egg",
        Default = false,
        Callback = function(value)
            getgenv().EggStealerSettings.TeleportToEgg = value
        end
    })
    
    -- =====================
    -- EGG TYPES TAB
    -- =====================
    local TypesTab = Window:CreateTab("Egg Types", "egg")
    
    TypesTab:AddLabel("Select Egg Types")
    TypesTab:AddDivider()
    
    TypesTab:AddToggle({
        Name = "Normal Eggs",
        Default = true,
        Callback = function(value)
            getgenv().EggStealerSettings.TargetNormal = value
        end
    })
    
    TypesTab:AddToggle({
        Name = "Golden Eggs",
        Default = true,
        Callback = function(value)
            getgenv().EggStealerSettings.TargetGolden = value
        end
    })
    
    TypesTab:AddToggle({
        Name = "Diamond Eggs",
        Default = true,
        Callback = function(value)
            getgenv().EggStealerSettings.TargetDiamond = value
        end
    })
    
    TypesTab:AddToggle({
        Name = "Legendary Eggs",
        Default = true,
        Callback = function(value)
            getgenv().EggStealerSettings.TargetLegendary = value
        end
    })
    
    -- =====================
    -- FUNCTIONS TAB
    -- =====================
    local FunctionsTab = Window:CreateTab("Functions", "settings")
    
    FunctionsTab:AddLabel("Manual Controls")
    FunctionsTab:AddDivider()
    
    FunctionsTab:AddButton({
        Name = "Steal Nearest Egg",
        Callback = function()
            local eggs = findEggs()
            if #eggs > 0 then
                if stealEgg(eggs[1].Object) then
                    notify("Steal Egg", "Stole: " .. eggs[1].Name, 2)
                else
                    notify("Steal Egg", "Failed to steal", 2)
                end
            else
                notify("Steal Egg", "No eggs found", 2)
            end
        end
    })
    
    FunctionsTab:AddButton({
        Name = "Teleport to Nearest Egg",
        Callback = function()
            local eggs = findEggs()
            if #eggs > 0 then
                local hrp = getHRP()
                if hrp then
                    hrp.CFrame = CFrame.new(eggs[1].Position + Vector3.new(0, 3, 0))
                    notify("Teleport", "Teleported to egg!", 2)
                end
            else
                notify("Teleport", "No eggs found", 2)
            end
        end
    })
    
    FunctionsTab:AddButton({
        Name = "Find All Eggs",
        Callback = function()
            local eggs = findEggs()
            print("=== EGGS FOUND ===")
            for i, egg in pairs(eggs) do
                print(i .. ". " .. egg.Name .. " - Distance: " .. math.floor(egg.Distance) .. " studs")
            end
            notify("Find Eggs", "Found " .. #eggs .. " eggs", 3)
        end
    })
    
    FunctionsTab:AddDivider()
    FunctionsTab:AddLabel("Made by zikXcodes")
end

-- =====================
-- NOTIFICATION
-- =====================
notify("Egg Stealer", "Script loaded successfully! 🥚", 5)

-- =====================
-- PREVENT RELOADING
-- =====================
print("✓ Egg Stealer Script Loaded!")
print("✓ UI Window Created (No Duplication)")
print("✓ Ready to steal eggs!")
