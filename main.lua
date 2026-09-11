-- =====================
-- ZIK BURGERZ CHEAT - MACLIB VERSION WITH AUTO AIMLOCK
-- =====================

local MacLib = loadstring(game:HttpGet("https://raw.githubusercontent.com/Macacos/MacLib/main/Library.lua"))()

local Window = MacLib:CreateWindow({
    Title = "Zik Burgerz Cheat",
    Subtitle = "🍔 Advanced Game Utility",
    TabPadding = 8,
    ContentPadding = 8
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
    AutoFarmType = "burger",
    
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
    
    -- Auto Aimlock Settings
    AutoAimlockEnabled = false,
    AutoAimlockRange = 100,
    AutoAimlockTargets = { npc = true, cop = true, customer = true },
    AutoAimlockSmoothness = 0.1,
    AutoAimlockPrediction = false,
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
    if not pos1 or not pos2 then return math.huge end
    return (pos1 - pos2).Magnitude
end

local function notify(title, content, duration)
    duration = duration or 3
    print("[" .. title .. "] " .. content)
end

-- Auto Aimlock Variables
local AimlockTarget = nil
local AimlockConnection = nil

local function findNearestTarget()
    local hrp = getHRP()
    if not hrp then return nil end
    
    local nearest = nil
    local nearestDist = math.huge
    
    for _, model in pairs(workspace:GetDescendants()) do
        if not getgenv().ZikSettings.AutoAimlockTargets then break end
        
        if model:IsA("Model") and model ~= LocalPlayer.Character and model.Parent then
            local name = model.Name:lower()
            local isTarget = false
            
            if getgenv().ZikSettings.AutoAimlockTargets.npc and name:find("npc") then
                isTarget = true
            end
            if getgenv().ZikSettings.AutoAimlockTargets.cop and name:find("cop") then
                isTarget = true
            end
            if getgenv().ZikSettings.AutoAimlockTargets.customer and (name:find("customer") or name:find("cust")) then
                isTarget = true
            end
            
            if isTarget then
                local targetHRP = model:FindFirstChild("HumanoidRootPart")
                local humanoid = findHumanoid(model)
                
                if targetHRP and humanoid and humanoid.Health > 0 then
                    local distance = getDistance(targetHRP.Position, hrp.Position)
                    if distance <= getgenv().ZikSettings.AutoAimlockRange and distance < nearestDist then
                        nearestDist = distance
                        nearest = model
                    end
                end
            end
        end
    end
    
    return nearest
end

local function updateAimlock()
    if not getgenv().ZikSettings.AutoAimlockEnabled then
        AimlockTarget = nil
        return
    end
    
    AimlockTarget = findNearestTarget()
    
    if AimlockTarget then
        local targetHRP = AimlockTarget:FindFirstChild("HumanoidRootPart")
        if targetHRP then
            local targetPos = targetHRP.Position
            
            -- Prediction system (optional)
            if getgenv().ZikSettings.AutoAimlockPrediction then
                local humanoid = findHumanoid(AimlockTarget)
                if humanoid and humanoid.MoveVector.Magnitude > 0 then
                    targetPos = targetPos + (humanoid.MoveVector * 2)
                end
            end
            
            -- Smooth aimlock
            local smoothness = getgenv().ZikSettings.AutoAimlockSmoothness
            local newCFrame = CFrame.lookAt(Camera.CFrame.Position, targetPos)
            Camera.CFrame = Camera.CFrame:Lerp(newCFrame, smoothness)
        end
    end
end

-- =====================
-- MAIN TAB
-- =====================
local Tab1 = Window:CreateTab("Main", "house")

Tab1:Section("Main Settings")

Tab1:Label("Welcome to Zik Burgerz Cheat")

Tab1:Paragraph({
    Title = "Status",
    Content = "Script loaded and ready! 🚀"
})

Tab1:Slider({
    Name = "Walk Speed",
    Flag = "WalkSpeed",
    Value = 16,
    Min = 16,
    Max = 150,
    Callback = function(Value)
        getgenv().ZikSettings.WalkSpeed = Value
        local hrp = getHRP()
        if hrp and hrp.Parent then
            local humanoid = hrp.Parent:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.WalkSpeed = Value
            end
        end
    end
})

Tab1:Slider({
    Name = "Jump Power",
    Flag = "JumpPower",
    Value = 50,
    Min = 50,
    Max = 200,
    Callback = function(Value)
        local hrp = getHRP()
        if hrp and hrp.Parent then
            local humanoid = hrp.Parent:FindFirstChildOfClass("Humanoid")
            if humanoid then
                humanoid.JumpPower = Value
            end
        end
    end
})

local infiniteJumpEnabled = false
Tab1:Button({
    Name = "Toggle Infinite Jump",
    Callback = function()
        if infiniteJumpEnabled then
            notify("Infinite Jump", "Already enabled", 2)
            return
        end
        infiniteJumpEnabled = true
        UserInputService.InputBegan:Connect(function(input, gameProcessed)
            if gameProcessed then return end
            if input.KeyCode == Enum.KeyCode.Space then
                if LocalPlayer.Character then
                    local humanoid = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
                    if humanoid then
                        humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                    end
                end
            end
        end)
        notify("Infinite Jump", "Enabled! Press SPACE to jump", 3)
    end
})

-- =====================
-- AUTO COOK TAB
-- =====================
local Tab2 = Window:CreateTab("Auto Cook", "flame")

Tab2:Section("Auto Cook Settings")

Tab2:Toggle({
    Name = "Enable Auto Cook",
    Flag = "AutoCook",
    Callback = function(Value)
        getgenv().ZikSettings.AutoCook = Value
        if Value then
            spawn(function()
                while getgenv().ZikSettings.AutoCook do
                    local hrp = getHRP()
                    if not hrp then
                        wait(0.1)
                        continue
                    end

                    local success, err = pcall(function()
                        for _, obj in pairs(workspace:GetDescendants()) do
                            if not getgenv().ZikSettings.AutoCook then break end
                            
                            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Parent then
                                local name = obj.Name:lower()
                                if name:find("raw") or name:find("uncook") or name:find("patty") or name:find("meat") then
                                    local pos
                                    if obj:IsA("BasePart") then
                                        pos = obj.Position
                                    else
                                        local part = obj:FindFirstChildWhichIsA("BasePart")
                                        if part then pos = part.Position end
                                    end
                                    
                                    if pos and getDistance(pos, hrp.Position) < 50 then
                                        hrp.CFrame = CFrame.new(pos + Vector3.new(0, 3, 0))
                                        wait(0.2)
                                        
                                        if obj:IsA("BasePart") then
                                            local char = LocalPlayer.Character
                                            if char then
                                                local playerPart = char:FindFirstChildWhichIsA("BasePart")
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
                        end
                    end)
                    
                    if not success then warn("AutoCook Error:", err) end
                    wait(getgenv().ZikSettings.AutoCookSpeed)
                end
            end)
            notify("Auto Cook", "Enabled ✓", 3)
        else
            notify("Auto Cook", "Disabled ✗", 3)
        end
    end
})

Tab2:Slider({
    Name = "Cook Speed",
    Flag = "CookSpeed",
    Value = 0.5,
    Min = 0.2,
    Max = 2,
    Callback = function(Value)
        getgenv().ZikSettings.AutoCookSpeed = Value
    end
})

Tab2:Paragraph({
    Title = "Info",
    Content = "Auto Cook akan mengumpulkan dan memasak makanan secara otomatis"
})

-- =====================
-- KILL AURA TAB
-- =====================
local Tab3 = Window:CreateTab("Kill Aura", "zap")

Tab3:Section("Kill Aura Settings")

Tab3:Toggle({
    Name = "Enable Kill Aura",
    Flag = "KillAura",
    Callback = function(Value)
        getgenv().ZikSettings.KillAura = Value
        if Value then
            spawn(function()
                while getgenv().ZikSettings.KillAura do
                    local hrp = getHRP()
                    if not hrp or not hrp.Parent then
                        wait(0.2)
                        continue
                    end

                    local success, err = pcall(function()
                        for _, model in pairs(workspace:GetDescendants()) do
                            if not getgenv().ZikSettings.KillAura then break end
                            
                            if model:IsA("Model") and model ~= LocalPlayer.Character and model.Parent then
                                local name = model.Name:lower()
                                local isTarget = false
                                
                                if getgenv().ZikSettings.KillAuraTargets.npc and name:find("npc") then
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
                end
            end)
            notify("Kill Aura", "Enabled ✓", 3)
        else
            notify("Kill Aura", "Disabled ✗", 3)
        end
    end
})

Tab3:Slider({
    Name = "Aura Range",
    Flag = "AuraRange",
    Value = 30,
    Min = 10,
    Max = 200,
    Callback = function(Value)
        getgenv().ZikSettings.KillAuraRange = Value
    end
})

Tab3:Section("Target Settings")

Tab3:Toggle({
    Name = "Target NPC",
    Flag = "TargetNPC",
    Value = true,
    Callback = function(Value)
        getgenv().ZikSettings.KillAuraTargets.npc = Value
    end
})

Tab3:Toggle({
    Name = "Target Cops",
    Flag = "TargetCops",
    Value = true,
    Callback = function(Value)
        getgenv().ZikSettings.KillAuraTargets.cop = Value
    end
})

Tab3:Toggle({
    Name = "Target Customers",
    Flag = "TargetCustomers",
    Value = true,
    Callback = function(Value)
        getgenv().ZikSettings.KillAuraTargets.customer = Value
    end
})

Tab3:Paragraph({
    Title = "Warning",
    Content = "Kill Aura dapat menyerang karakter lain di permainan"
})

-- =====================
-- AUTO AIMLOCK TAB (NEW)
-- =====================
local Tab4 = Window:CreateTab("Auto Aimlock", "scope")

Tab4:Section("Auto Aimlock Settings")

Tab4:Toggle({
    Name = "Enable Auto Aimlock",
    Flag = "AutoAimlock",
    Callback = function(Value)
        getgenv().ZikSettings.AutoAimlockEnabled = Value
        
        if Value then
            if AimlockConnection then
                AimlockConnection:Disconnect()
            end
            AimlockConnection = RunService.RenderStepped:Connect(updateAimlock)
            notify("Auto Aimlock", "Enabled ✓", 3)
        else
            if AimlockConnection then
                AimlockConnection:Disconnect()
                AimlockConnection = nil
            end
            AimlockTarget = nil
            notify("Auto Aimlock", "Disabled ✗", 3)
        end
    end
})

Tab4:Slider({
    Name = "Aimlock Range",
    Flag = "AimlockRange",
    Value = 100,
    Min = 10,
    Max = 500,
    Callback = function(Value)
        getgenv().ZikSettings.AutoAimlockRange = Value
    end
})

Tab4:Slider({
    Name = "Aimlock Smoothness",
    Flag = "AimlockSmooth",
    Value = 0.1,
    Min = 0.01,
    Max = 1,
    Callback = function(Value)
        getgenv().ZikSettings.AutoAimlockSmoothness = Value
    end
})

Tab4:Section("Target Settings")

Tab4:Toggle({
    Name = "Target NPC",
    Flag = "AimlockNPC",
    Value = true,
    Callback = function(Value)
        getgenv().ZikSettings.AutoAimlockTargets.npc = Value
    end
})

Tab4:Toggle({
    Name = "Target Cops",
    Flag = "AimlockCops",
    Value = true,
    Callback = function(Value)
        getgenv().ZikSettings.AutoAimlockTargets.cop = Value
    end
})

Tab4:Toggle({
    Name = "Target Customers",
    Flag = "AimlockCustomers",
    Value = true,
    Callback = function(Value)
        getgenv().ZikSettings.AutoAimlockTargets.customer = Value
    end
})

Tab4:Section("Advanced")

Tab4:Toggle({
    Name = "Prediction System",
    Flag = "AimlockPrediction",
    Callback = function(Value)
        getgenv().ZikSettings.AutoAimlockPrediction = Value
    end
})

Tab4:Paragraph({
    Title = "Info",
    Content = "Auto Aimlock akan secara otomatis mengarahkan kamera ke target terdekat"
})

-- =====================
-- TELEPORT TAB
-- =====================
local Tab5 = Window:CreateTab("Teleport", "pin")

Tab5:Section("Teleport Options")

Tab5:Button({
    Name = "Teleport to Spawn",
    Callback = function()
        local hrp = getHRP()
        if hrp then
            pcall(function()
                hrp.CFrame = CFrame.new(0, 10, 0)
                notify("Teleport", "Teleported to Spawn ✓", 2)
            end)
        end
    end
})

Tab5:Button({
    Name = "Teleport to Nearest NPC",
    Callback = function()
        local hrp = getHRP()
        if not hrp then return end
        
        local nearest = nil
        local nearestDist = math.huge
        
        for _, model in pairs(workspace:GetDescendants()) do
            if model:IsA("Model") and model ~= LocalPlayer.Character and model.Parent then
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
                notify("Teleport", "Teleported to NPC ✓", 2)
            end)
        end
    end
})

Tab5:Button({
    Name = "Teleport to Nearest Food",
    Callback = function()
        local hrp = getHRP()
        if not hrp then return end
        
        local nearest = nil
        local nearestDist = math.huge
        
        for _, obj in pairs(workspace:GetDescendants()) do
            if (obj:IsA("BasePart") or obj:IsA("Model")) and obj.Parent then
                local name = obj.Name:lower()
                if name:find("burger") or name:find("patty") or name:find("food") or name:find("raw") then
                    local pos
                    if obj:IsA("BasePart") then
                        pos = obj.Position
                    else
                        local part = obj:FindFirstChildWhichIsA("BasePart")
                        if part then pos = part.Position end
                    end
                    
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
                notify("Teleport", "Teleported to Food ✓", 2)
            end)
        end
    end
})

-- =====================
-- MISC TAB
-- =====================
local Tab6 = Window:CreateTab("Misc", "sliders")

Tab6:Section("Utilities")

Tab6:Toggle({
    Name = "No Clip",
    Flag = "NoClip",
    Callback = function(Value)
        local char = LocalPlayer.Character
        if not char then return end
        
        if Value then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = false
                end
            end
            notify("No Clip", "Enabled ✓", 2)
        else
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = true
                end
            end
            notify("No Clip", "Disabled ✗", 2)
        end
    end
})

Tab6:Button({
    Name = "Refresh Character",
    Callback = function()
        if LocalPlayer.Character then
            LocalPlayer.Character:Destroy()
        end
        notify("Character", "Refreshed ✓", 2)
    end
})

Tab6:Button({
    Name = "Reset Camera",
    Callback = function()
        local camera = workspace.CurrentCamera
        local hrp = getHRP()
        if hrp then
            camera.CFrame = hrp.CFrame + hrp.CFrame.LookVector * 10
        end
        notify("Camera", "Reset ✓", 2)
    end
})

Tab6:Section("Script Info")

Tab6:Paragraph({
    Title = "Version",
    Content = "Zik Burgerz Cheat v2.0 MacLib Edition"
})

Tab6:Paragraph({
    Title = "Developer",
    Content = "zikXcodes"
})

Tab6:Paragraph({
    Title = "Game ID",
    Content = "99817148924004"
})

-- =====================
-- NOTIFICATION
-- =====================
notify("Hub Loaded", "Welcome to Zik Burgerz Cheat! 🍔", 5)

-- =====================
-- LOAD COMPLETE
-- =====================
print("✓ Zik Burgerz Cheat Script Loaded Successfully!")
print("✓ Version: 2.0 (MacLib Edition with Auto Aimlock)")
print("✓ Game ID: 99817148924004")
