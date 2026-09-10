local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Zik Burgerz Cheat",
    Icon = "🍔",
    Theme = "Crimson",
    Folder = "ZikHub",
})

-- =====================
-- SERVICES & VARIABLES
-- =====================
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local workspace = game:GetService("Workspace")
local UserInputService = game:GetService("UserInputService")

-- Global settings
getgenv().ZikSettings = getgenv().ZikSettings or {
    -- Auto Cook Settings
    AutoCook = false,
    AutoCookSpeed = 0.5,
    
    -- Kill Aura Settings
    KillAura = false,
    KillAuraRange = 30,
    KillAuraTargets = { npc = true, cop = true, customer = true },
    
    -- Auto Farm Settings
    AutoFarm = false,
    AutoFarmType = "burger", -- burger, money, xp
    
    -- ESP Settings
    ESPEnabled = false,
    ESPRange = 100,
    
    -- Speed Settings
    WalkSpeed = 16,
    SprintSpeed = 50,
    IsSprinting = false,
    
    -- Teleport Settings
    TeleportToFood = false,
    TeleportToGrill = false,
}

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
    return (pos1 - pos2).Magnitude
end

local function notify(title, content, duration)
    duration = duration or 3
    WindUI:Notify({
        Title = title,
        Content = content,
        Icon = "solar:bell-bold",
        Duration = duration,
    })
end

-- =====================
-- MAIN TAB
-- =====================
local Tab = Window:Tab({
    Title = "Main",
    Icon = "home",
})

Tab:Label({ Title = "Welcome", Content = "Burgerz Cheat by Zik" })

Tab:Space()

Tab:Slider({
    Title = "Walk Speed",
    Step = 1,
    Value = {
        Min = 16,
        Max = 150,
        Default = 16,
    },
    Callback = function(value)
        getgenv().ZikSettings.WalkSpeed = value
        local hrp = getHRP()
        if hrp and hrp.Parent:FindFirstChildOfClass("Humanoid") then
            hrp.Parent:FindFirstChildOfClass("Humanoid").WalkSpeed = value
        end
    end,
})

Tab:Slider({
    Title = "Jump Power",
    Step = 1,
    Value = {
        Min = 50,
        Max = 200,
        Default = 50,
    },
    Callback = function(value)
        local hrp = getHRP()
        if hrp and hrp.Parent:FindFirstChildOfClass("Humanoid") then
            hrp.Parent:FindFirstChildOfClass("Humanoid").JumpPower = value
        end
    end,
})

Tab:Space()

Tab:Button({
    Title = "Infinite Jump",
    Icon = "jump",
    Callback = function()
        local jumped = false
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.Space then
                local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                if humanoid then
                    humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end
        end)
        notify("Infinite Jump", "Enabled! Press SPACE to jump", 3)
    end,
})

Tab:Label({ Title = "Status", Content = "Script loaded and ready!" })

-- =====================
-- AUTO COOK TAB
-- =====================
local AutoTab = Window:Tab({ Title = "Auto Cook", Icon = "fire" })

AutoTab:Toggle({
    Title = "Enable Auto Cook",
    Value = false,
    Callback = function(state)
        getgenv().ZikSettings.AutoCook = state
        if state then
            spawn(function()
                while getgenv().ZikSettings.AutoCook do
                    local hrp = getHRP()
                    if not hrp then
                        wait(0.1)
                        goto continue
                    end

                    local success, err = pcall(function()
                        -- Search for raw food items
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if not getgenv().ZikSettings.AutoCook then break end
                            
                            if obj:IsA("BasePart") or obj:IsA("Model") then
                                local name = obj.Name:lower()
                                if name:find("raw") or name:find("uncook") or name:find("patty") or name:find("meat") then
                                    local pos = obj:IsA("BasePart") and obj.Position or obj:FindFirstChildWhichIsA("BasePart") and obj:FindFirstChildWhichIsA("BasePart").Position
                                    
                                    if pos and getDistance(pos, hrp.Position) < 50 then
                                        -- Teleport to item
                                        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
                                        wait(0.2)
                                        
                                        -- Try to pick up
                                        if obj:IsA("BasePart") then
                                            local playerPart = LocalPlayer.Character:FindFirstChildWhichIsA("BasePart")
                                            if playerPart then
                                                pcall(function()
                                                    firetouchinterest(obj, playerPart, 0)
                                                    wait(0.1)
                                                    firetouchinterest(obj, playerPart, 1)
                                                end)
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end)
                    
                    if not success then warn("AutoCook Error:", err) end
                    wait(getgenv().ZikSettings.AutoCookSpeed)
                    
                    ::continue::
                end
            end)
            notify("Auto Cook", "Enabled ✓", 3)
        else
            notify("Auto Cook", "Disabled ✗", 3)
        end
    end,
})

AutoTab:Slider({
    Title = "Cook Speed",
    Step = 0.1,
    Value = { Min = 0.2, Max = 2, Default = 0.5 },
    Callback = function(val) 
        getgenv().ZikSettings.AutoCookSpeed = val 
    end,
})

AutoTab:Space()

AutoTab:Label({ Title = "Info", Content = "Auto Cook akan mengumpulkan dan memasak makanan" })

-- =====================
-- KILL AURA TAB
-- =====================
local AuraTab = Window:Tab({ Title = "Kill Aura", Icon = "zap" })

AuraTab:Toggle({
    Title = "Enable Kill Aura",
    Value = false,
    Callback = function(state)
        getgenv().ZikSettings.KillAura = state
        if state then
            spawn(function()
                while getgenv().ZikSettings.KillAura do
                    local hrp = getHRP()
                    if not hrp or not hrp.Parent then
                        wait(0.2)
                        goto continue_aura
                    end

                    local success, err = pcall(function()
                        for _, model in pairs(workspace:GetDescendants()) do
                            if not getgenv().ZikSettings.KillAura then break end
                            
                            if model:IsA("Model") and model ~= LocalPlayer.Character then
                                local name = model.Name:lower()
                                local isTarget = false
                                
                                -- Check target types
                                if getgenv().ZikSettings.KillAuraTargets.npc and (name:find("npc") or name:find("npc")) then
                                    isTarget = true
                                end
                                if getgenv().ZikSettings.KillAuraTargets.cop and name:find("cop") then
                                    isTarget = true
                                end
                                if getgenv().ZikSettings.KillAuraTargets.customer and (name:find("customer") or name:find("cust")) then
                                    isTarget = true
                                end
                                
                                if isTarget then
                                    local targetHRP = model:FindFirstChild("HumanoidRootPart")
                                    local humanoid = findHumanoid(model)
                                    
                                    if targetHRP and humanoid and humanoid.Health > 0 then
                                        local distance = getDistance(targetHRP.Position, hrp.Position)
                                        if distance <= getgenv().ZikSettings.KillAuraRange then
                                            pcall(function()
                                                humanoid.Health = 0
                                            end)
                                        end
                                    end
                                end
                            end
                        end
                    end)
                    
                    if not success then warn("KillAura Error:", err) end
                    wait(0.15)
                    
                    ::continue_aura::
                end
            end)
            notify("Kill Aura", "Enabled ✓", 3)
        else
            notify("Kill Aura", "Disabled ✗", 3)
        end
    end,
})

AuraTab:Slider({
    Title = "Aura Range",
    Step = 5,
    Value = { Min = 10, Max = 200, Default = 30 },
    Callback = function(val) 
        getgenv().ZikSettings.KillAuraRange = val 
    end,
})

AuraTab:Space()

AuraTab:Checkbox({
    Title = "Target NPC",
    Value = getgenv().ZikSettings.KillAuraTargets.npc,
    Callback = function(v) getgenv().ZikSettings.KillAuraTargets.npc = v end,
})

AuraTab:Checkbox({
    Title = "Target Cops",
    Value = getgenv().ZikSettings.KillAuraTargets.cop,
    Callback = function(v) getgenv().ZikSettings.KillAuraTargets.cop = v end,
})

AuraTab:Checkbox({
    Title = "Target Customers",
    Value = getgenv().ZikSettings.KillAuraTargets.customer,
    Callback = function(v) getgenv().ZikSettings.KillAuraTargets.customer = v end,
})

AuraTab:Space()

AuraTab:Label({ Title = "Warning", Content = "Kill Aura dapat menyerang karakter lain" })

-- =====================
-- TELEPORT TAB
-- =====================
local TeleportTab = Window:Tab({ Title = "Teleport", Icon = "pin" })

TeleportTab:Button({
    Title = "Teleport to Spawn",
    Icon = "home",
    Callback = function()
        local hrp = getHRP()
        if hrp then
            pcall(function()
                hrp.CFrame = CFrame.new(0, 10, 0)
                notify("Teleport", "Teleported to Spawn", 2)
            end)
        end
    end,
})

TeleportTab:Button({
    Title = "Teleport to Nearest NPC",
    Icon = "user",
    Callback = function()
        local hrp = getHRP()
        if not hrp then return end
        
        local nearest = nil
        local nearestDist = math.huge
        
        for _, model in pairs(workspace:GetDescendants()) do
            if model:IsA("Model") and model ~= LocalPlayer.Character then
                local name = model.Name:lower()
                if name:find("npc") or name:find("customer") then
                    local targetHRP = model:FindFirstChild("HumanoidRootPart")
                    if targetHRP then
                        local dist = getDistance(targetHRP.Position, hrp.Position)
                        if dist < nearestDist then
                            nearestDist = dist
                            nearest = targetHRP
                        end
                    end
                end
            end
        end
        
        if nearest then
            pcall(function()
                hrp.CFrame = CFrame.new(nearest.Position + Vector3.new(0, 3, 0))
                notify("Teleport", "Teleported to NPC", 2)
            end)
        end
    end,
})

TeleportTab:Button({
    Title = "Teleport to Nearest Food",
    Icon = "apple",
    Callback = function()
        local hrp = getHRP()
        if not hrp then return end
        
        local nearest = nil
        local nearestDist = math.huge
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if obj:IsA("BasePart") or obj:IsA("Model") then
                local name = obj.Name:lower()
                if name:find("burger") or name:find("patty") or name:find("food") or name:find("raw") then
                    local pos = obj:IsA("BasePart") and obj.Position or obj:FindFirstChildWhichIsA("BasePart") and obj:FindFirstChildWhichIsA("BasePart").Position
                    if pos then
                        local dist = getDistance(pos, hrp.Position)
                        if dist < nearestDist then
                            nearestDist = dist
                            nearest = pos
                        end
                    end
                end
            end
        end
        
        if nearest then
            pcall(function()
                hrp.CFrame = CFrame.new(nearest + Vector3.new(0, 3, 0))
                notify("Teleport", "Teleported to Food", 2)
            end)
        end
    end,
})

-- =====================
-- MISC TAB
-- =====================
local MiscTab = Window:Tab({ Title = "Misc", Icon = "settings" })

MiscTab:Toggle({
    Title = "No Clip",
    Value = false,
    Callback = function(state)
        local char = LocalPlayer.Character
        if not char then return end
        
        if state then
            for _, part in pairs(char:FindFirstChildOfClass("Humanoid").Parent:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
            notify("No Clip", "Enabled ✓", 2)
        else
            for _, part in pairs(char:FindFirstChildOfClass("Humanoid").Parent:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
            notify("No Clip", "Disabled ✗", 2)
        end
    end,
})

MiscTab:Space()

MiscTab:Button({
    Title = "Refresh Character",
    Icon = "refresh",
    Callback = function()
        if LocalPlayer.Character then
            LocalPlayer.Character:Destroy()
        end
        notify("Character", "Refreshed", 2)
    end,
})

MiscTab:Button({
    Title = "Reset Camera",
    Icon = "eye",
    Callback = function()
        local camera = workspace.CurrentCamera
        local hrp = getHRP()
        if hrp then
            camera.CFrame = hrp.CFrame + hrp.CFrame.LookVector * 10
        end
        notify("Camera", "Reset", 2)
    end,
})

MiscTab:Space()

MiscTab:Label({ Title = "Script Info", Content = "Zik Burgerz Cheat v1.0" })
MiscTab:Label({ Title = "Developer", Content = "zikXcodes" })

-- =====================
-- NOTIFICATION
-- =====================
notify("Hub Loaded", "Welcome to Zik Burgerz Cheat! 🍔", 5)

-- =====================
-- LOAD COMPLETE
-- =====================
print("✓ Zik Burgerz Cheat Script Loaded Successfully!")
print("✓ Game ID: 99817148924004")
