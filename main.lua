-- =============================================
-- SCRIPT LOADER WIND UI v1.0
-- By: bl_ai for Tuan Bizz
-- Fitur: GUI Modern dengan WindUI Style
-- =============================================

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/bloodball/backups/refs/heads/main/lib"))()
local window = library:CreateWindow("Bizz Loader v1.0")

-- =============================================
-- TAB 1: MAIN
-- =============================================
local tab1 = window:CreateTab("Main")

-- SECTION: Informasi
local section1 = tab1:CreateSection("System Info")

local label1 = section1:CreateLabel("Status: ✅ Online")
local label2 = section1:CreateLabel("User: " .. game.Players.LocalPlayer.Name)
local label3 = section1:CreateLabel("Ping: " .. math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) .. "ms")

-- SECTION: Controls
local section2 = tab1:CreateSection("Quick Controls")

section2:CreateButton("Teleport to Spawn", function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        char.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0)
        print("✅ Teleported to spawn!")
    else
        print("❌ Character not found!")
    end
end)

section2:CreateButton("Respawn Character", function()
    game.Players.LocalPlayer:LoadCharacter()
    print("✅ Respawned!")
end)

section2:CreateButton("Clear Chat", function()
    game:GetService("Chat"):Clear()
    print("✅ Chat cleared!")
end)

-- SECTION: Toggles
local section3 = tab1:CreateSection("Toggles")

local toggle1 = section3:CreateToggle("NoClip (Walk through walls)", false, function(state)
    local char = game.Players.LocalPlayer.Character
    if char then
        for _, part in pairs(char:GetDescendants()) do
            if part:IsA("BasePart") then
                part.CanCollide = not state
            end
        end
        print("🔘 NoClip: " .. (state and "ON" or "OFF"))
    end
end)

local toggle2 = section3:CreateToggle("Infinite Jump", false, function(state)
    local player = game.Players.LocalPlayer
    local char = player.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, state)
        char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, state)
        char.Humanoid.PlatformStand = state
        print("🔘 Infinite Jump: " .. (state and "ON" or "OFF"))
    end
end)

local toggle3 = section3:CreateToggle("Anti-AFK (Keep active)", false, function(state)
    if state then
        local vu = game:GetService("VirtualUser")
        game:GetService("Players").LocalPlayer.Idled:Connect(function()
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
        end)
        print("🔘 Anti-AFK: ON")
    else
        print("🔘 Anti-AFK: OFF (restart to disable)")
    end
end)

-- =============================================
-- TAB 2: ESP / VISUALS
-- =============================================
local tab2 = window:CreateTab("Visuals")

local section4 = tab2:CreateSection("ESP Settings")

local espToggle = section4:CreateToggle("Enable ESP (Players)", false, function(state)
    if state then
        print("🔘 ESP: ON")
        -- ESP loop
        spawn(function()
            while espToggle.Value do
                for _, player in pairs(game.Players:GetPlayers()) do
                    if player ~= game.Players.LocalPlayer then
                        local char = player.Character
                        if char and char:FindFirstChild("Head") then
                            local head = char.Head
                            local highlight = head:FindFirstChild("ESP_Highlight")
                            if not highlight then
                                highlight = Instance.new("Highlight")
                                highlight.Name = "ESP_Highlight"
                                highlight.Parent = head
                                highlight.Adornee = head
                                highlight.FillColor = Color3.new(1, 0, 0)
                                highlight.FillTransparency = 0.5
                                highlight.OutlineColor = Color3.new(1, 1, 1)
                            end
                        end
                    end
                end
                wait(1)
            end
        end)
    else
        -- Hapus semua highlight
        for _, player in pairs(game.Players:GetPlayers()) do
            local char = player.Character
            if char then
                for _, obj in pairs(char:GetDescendants()) do
                    if obj.Name == "ESP_Highlight" then
                        obj:Destroy()
                    end
                end
            end
        end
        print("🔘 ESP: OFF")
    end
end)

section4:CreateSlider("ESP Transparency", 0, 1, 0.5, function(value)
    for _, player in pairs(game.Players:GetPlayers()) do
        local char = player.Character
        if char then
            for _, obj in pairs(char:GetDescendants()) do
                if obj.Name == "ESP_Highlight" and obj:IsA("Highlight") then
                    obj.FillTransparency = value
                end
            end
        end
    end
    print("🎨 ESP Transparency: " .. value)
end)

section4:CreateColorPicker("ESP Color", Color3.new(1, 0, 0), function(color)
    for _, player in pairs(game.Players:GetPlayers()) do
        local char = player.Character
        if char then
            for _, obj in pairs(char:GetDescendants()) do
                if obj.Name == "ESP_Highlight" and obj:IsA("Highlight") then
                    obj.FillColor = color
                end
            end
        end
    end
    print("🎨 ESP Color changed!")
end)

-- SECTION: Player List
local section5 = tab2:CreateSection("Player List")

local playerList = section5:CreateLabel("Players: ")
game.Players.PlayerAdded:Connect(function()
    local count = #game.Players:GetPlayers()
    playerList:SetText("Players: " .. count)
end)
game.Players.PlayerRemoved:Connect(function()
    local count = #game.Players:GetPlayers()
    playerList:SetText("Players: " .. count)
end)

-- =============================================
-- TAB 3: MISC / UTILITIES
-- =============================================
local tab3 = window:CreateTab("Misc")

local section6 = tab3:CreateSection("Walk / Fly Speed")

section6:CreateSlider("Walk Speed", 0, 100, 16, function(value)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.WalkSpeed = value
        print("🏃 Walk Speed: " .. value)
    end
end)

section6:CreateSlider("Jump Power", 0, 100, 50, function(value)
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("Humanoid") then
        char.Humanoid.JumpPower = value
        print("💪 Jump Power: " .. value)
    end
end)

-- SECTION: Teleport
local section7 = tab3:CreateSection("Teleport to Player")

local playerDropdown = section7:CreateDropdown("Select Player", game.Players:GetPlayers(), function(selected)
    local target = game.Players:FindFirstChild(selected)
    if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
            print("✅ Teleported to " .. selected)
        end
    else
        print("❌ Target not found or not loaded!")
    end
end)

-- SECTION: Tools
local section8 = tab3:CreateSection("Tools")

section8:CreateButton("Get All Tools", function()
    local player = game.Players.LocalPlayer
    local backpack = player.Backpack
    for _, tool in pairs(backpack:GetChildren()) do
        tool.Parent = player.Character
        wait(0.1)
    end
    print("✅ All tools equipped!")
end)

section8:CreateButton("Infinite Yield (CMD)", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
    print("✅ Infinite Yield loaded!")
end)

-- SECTION: Credits
local section9 = tab3:CreateSection("Credits")
section9:CreateLabel("🔥 Made by bl_ai for Tuan Bizz")
section9:CreateLabel("⚡ Version: 1.0")
section9:CreateLabel("😈 WindUI Style Loader")

-- =============================================
-- TAB 4: SCRIPT EXECUTOR
-- =============================================
local tab4 = window:CreateTab("Executor")

local section10 = tab4:CreateSection("Execute Custom Script")

local textbox = section10:CreateTextbox("Paste your script here...", function(text)
    -- Store script for execution
    _G.customScript = text
    print("📝 Script saved! Click Execute to run.")
end)

section10:CreateButton("Execute Script", function()
    if _G.customScript and #_G.customScript > 0 then
        local success, err = pcall(loadstring(_G.customScript))
        if success then
            print("✅ Script executed successfully!")
        else
            print("❌ Error: " .. tostring(err))
        end
    else
        print("❌ No script to execute!")
    end
end)

section10:CreateButton("Clear Script", function()
    _G.customScript = ""
    textbox:SetText("")
    print("🧹 Script cleared!")
end)

-- =============================================
-- NOTIFICATIONS
-- =============================================
window:CreateNotification({
    Title = "Bizz Loader",
    Text = "✅ Loader berhasil diaktifkan!",
    Duration = 3,
    Type = "info"
})

print("===========================================")
print("🔥 BIZZ LOADER v1.0 LOADED SUCCESSFULLY!")
print("👤 User: " .. game.Players.LocalPlayer.Name)
print("📌 Open GUI with: toggle key")
print("===========================================")

-- =============================================
-- KEYBIND: Toggle GUI (Default: Insert)
-- =============================================
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.Insert then
        window:ToggleVisibility()
    end
end)

-- =============================================
-- CLEANUP FUNCTION
-- =============================================
local function cleanup()
    -- Destroy all highlights
    for _, player in pairs(game.Players:GetPlayers()) do
        local char = player.Character
        if char then
            for _, obj in pairs(char:GetDescendants()) do
                if obj.Name == "ESP_Highlight" then
                    obj:Destroy()
                end
            end
        end
    end
    print("🧹 Cleaned up ESP highlights!")
end

-- Auto cleanup when player leaves
game.Players.LocalPlayer:GetPropertyChangedSignal("Character"):Connect(function()
    if not game.Players.LocalPlayer.Character then
        cleanup()
    end
end)

-- =============================================
-- TAB 5: AUTO FARM & GRIND
-- =============================================
local tab5 = window:CreateTab("Auto Farm")

local section11 = tab5:CreateSection("Auto Farm Settings")

local autoFarmToggle = section11:CreateToggle("Enable Auto Farm", false, function(state)
    if state then
        print("🌾 Auto Farm: ON")
        spawn(function()
            while autoFarmToggle.Value do
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    -- Cari item terdekat
                    local nearestItem = nil
                    local nearestDist = math.huge
                    
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Tool") and v.Parent ~= char then
                            local handle = v:FindFirstChild("Handle")
                            if handle then
                                local dist = (handle.Position - char.HumanoidRootPart.Position).Magnitude
                                if dist < nearestDist and dist < 50 then
                                    nearestDist = dist
                                    nearestItem = v
                                end
                            end
                        end
                    end
                    
                    if nearestItem then
                        local handle = nearestItem:FindFirstChild("Handle")
                        if handle then
                            char.HumanoidRootPart.CFrame = handle.CFrame + Vector3.new(0, 2, 0)
                            wait(0.3)
                            
                            -- Coba klik ClickDetector
                            local detector = nearestItem:FindFirstChild("ClickDetector") or 
                                           nearestItem.Parent:FindFirstChild("ClickDetector")
                            if detector then
                                fireclickdetector(detector)
                            end
                        end
                    end
                end
                wait(1)
            end
        end)
    else
        print("🌾 Auto Farm: OFF")
    end
end)

section11:CreateSlider("Farm Range", 10, 100, 50, function(value)
    _G.farmRange = value
    print("📏 Farm Range: " .. value)
end)

local autoCollectToggle = section11:CreateToggle("Auto Collect Drops", false, function(state)
    if state then
        print("📦 Auto Collect: ON")
        spawn(function()
            while autoCollectToggle.Value do
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("BasePart") and v.Name:lower():find("drop") or v.Name:lower():find("item") then
                            if (v.Position - char.HumanoidRootPart.Position).Magnitude < 20 then
                                char.HumanoidRootPart.CFrame = v.CFrame + Vector3.new(0, 2, 0)
                                wait(0.2)
                            end
                        end
                    end
                end
                wait(0.5)
            end
        end)
    else
        print("📦 Auto Collect: OFF")
    end
end)

-- =============================================
-- TAB 6: COMBAT
-- =============================================
local tab6 = window:CreateTab("Combat")

local section12 = tab6:CreateSection("Auto Combat")

local autoCombatToggle = section12:CreateToggle("Auto Attack Mobs", false, function(state)
    if state then
        print("⚔️ Auto Combat: ON")
        spawn(function()
            while autoCombatToggle.Value do
                local char = game.Players.LocalPlayer.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    -- Cari mob terdekat
                    local nearestMob = nil
                    local nearestDist = math.huge
                    
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                            if v ~= char and v:FindFirstChild("HumanoidRootPart") then
                                local dist = (v.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
                                if dist < nearestDist and dist < 30 then
                                    nearestDist = dist
                                    nearestMob = v
                                end
                            end
                        end
                    end
                    
                    if nearestMob then
                        local hrp = nearestMob:FindFirstChild("HumanoidRootPart")
                        if hrp then
                            char.HumanoidRootPart.CFrame = hrp.CFrame + Vector3.new(0, 0, 3)
                            wait(0.2)
                            -- Simulasi attack (gunakan tool atau melee)
                            local tool = char:FindFirstChildWhichIsA("Tool")
                            if tool then
                                tool:Activate()
                            end
                        end
                    end
                end
                wait(0.5)
            end
        end)
    else
        print("⚔️ Auto Combat: OFF")
    end
end)

section12:CreateSlider("Combat Range", 5, 50, 20, function(value)
    _G.combatRange = value
    print("⚔️ Combat Range: " .. value)
end)

-- SECTION: Kill Aura
local section13 = tab6:CreateSection("Kill Aura")

local killAuraToggle = section13:CreateToggle("Kill Aura (Insta Kill)", false, function(state)
    if state then
        print("💀 Kill Aura: ON")
        spawn(function()
            while killAuraToggle.Value do
                local char = game.Players.LocalPlayer.Character
                if char then
                    for _, v in pairs(workspace:GetDescendants()) do
                        if v:IsA("Model") and v:FindFirstChild("Humanoid") then
                            if v ~= char and v:FindFirstChild("HumanoidRootPart") then
                                local dist = (v.HumanoidRootPart.Position - char.HumanoidRootPart.Position).Magnitude
                                if dist < 15 then
                                    v.Humanoid.Health = 0
                                end
                            end
                        end
                    end
                end
                wait(0.2)
            end
        end)
    else
        print("💀 Kill Aura: OFF")
    end
end)

-- =============================================
-- TAB 7: TELEPORT & WAYPOINTS
-- =============================================
local tab7 = window:CreateTab("Teleports")

local section14 = tab7:CreateSection("Saved Locations")

-- Save locations
local locations = {}
local locationList = {}

local function saveLocation(name, pos)
    locations[name] = pos
    table.insert(locationList, name)
    print("📍 Location saved: " .. name)
end

section14:CreateTextbox("Location Name", function(text)
    _G.tempLocationName = text
end)

section14:CreateButton("Save Current Location", function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChild("HumanoidRootPart") then
        local pos = char.HumanoidRootPart.Position
        if _G.tempLocationName and #_G.tempLocationName > 0 then
            saveLocation(_G.tempLocationName, pos)
            -- Update dropdown
            local newDropdown = section14:CreateDropdown("Select Location", locationList, function(selected)
                local pos = locations[selected]
                if pos then
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
                        char.HumanoidRootPart.CFrame = CFrame.new(pos)
                        print("📍 Teleported to: " .. selected)
                    end
                end
            end)
        end
    else
        print("❌ Character not found!")
    end
end)

section14:CreateButton("Clear All Locations", function()
    locations = {}
    locationList = {}
    print("🧹 All locations cleared!")
end)

-- SECTION: Quick Teleports
local section15 = tab7:CreateSection("Quick Teleports")

local quickTeleports = {
    {"Spawn", CFrame.new(0, 5, 0)},
    {"Sky", CFrame.new(0, 500, 0)},
    {"Underground", CFrame.new(0, -50, 0)},
    {"Center", CFrame.new(0, 0, 0)}
}

for _, teleport in pairs(quickTeleports) do
    section15:CreateButton("Teleport to " .. teleport[1], function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = teleport[2]
            print("📍 Teleported to " .. teleport[1])
        end
    end)
end

-- =============================================
-- TAB 8: SETTINGS
-- =============================================
local tab8 = window:CreateTab("Settings")

local section16 = tab8:CreateSection("UI Settings")

section16:CreateButton("Change Theme (Light/Dark)", function()
    if window.Theme == "Dark" then
        window:SetTheme("Light")
        print("🎨 Theme: Light")
    else
        window:SetTheme("Dark")
        print("🎨 Theme: Dark")
    end
end)

section16:CreateSlider("UI Transparency", 0, 1, 0.9, function(value)
    window:SetTransparency(value)
    print("🎨 UI Transparency: " .. value)
end)

-- SECTION: Keybinds
local section17 = tab8:CreateSection("Keybinds")

section17:CreateButton("Change Toggle Key (Default: Insert)", function()
    print("⌨️ Press any key to set as new toggle key...")
    local UserInputService = game:GetService("UserInputService")
    local keyConnection
    keyConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed then
            local key = input.KeyCode.Name
            print("⌨️ New toggle key set to: " .. key)
            -- Update keybind
            window.ToggleKey = Enum.KeyCode[key]
            keyConnection:Disconnect()
        end
    end)
end)

-- SECTION: About
local section18 = tab8:CreateSection("About")

section18:CreateLabel("📦 Bizz Loader v1.0")
section18:CreateLabel("👨‍💻 Developed by bl_ai")
section18:CreateLabel("🎯 For Tuan Bizz")
section18:CreateLabel("📅 Created: 2026")
section18:CreateLabel("⚡ WindUI Framework")

-- =============================================
-- TAB 9: CONSOLE / LOGS
-- =============================================
local tab9 = window:CreateTab("Console")

local section19 = tab9:CreateSection("Console Output")

local consoleLog = section19:CreateLabel("Console ready...")

-- Override print function
local oldPrint = print
print = function(...)
    local args = {...}
    local message = table.concat(args, " ")
    consoleLog:SetText(message)
    oldPrint(...)
end

section19:CreateButton("Clear Console", function()
    consoleLog:SetText("Console cleared...")
    print("🧹 Console cleared!")
end)

-- =============================================
-- AUTO EXECUTE
-- =============================================
spawn(function()
    wait(2)
    print("🔄 Auto-execute features loaded!")
end)

-- =============================================
-- ERROR HANDLING
-- =============================================
local function handleError(err)
    print("❌ Error: " .. tostring(err))
    window:CreateNotification({
        Title = "Error",
        Text = "An error occurred: " .. tostring(err),
        Duration = 3,
        Type = "error"
    })
end

-- Global error handler
xpcall(function()
    -- Main script execution
end, handleError)

-- =============================================
-- END OF SCRIPT - FULL VERSION
-- =============================================
