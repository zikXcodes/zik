-- =============================================
-- BIZZ LOADER v2.0 - WINDUI NATIVE
-- By: bl_ai for Tuan Bizz
-- Library: WindUI (Official)
-- =============================================

-- LOAD WINDUI LIBRARY
local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

-- CREATE WINDOW
local Window = WindUI:CreateWindow({
    Title = "Bizz Loader v2.0",
    Icon = "solar:folder-2-bold-duotone",
    Author = "by bl_ai for Tuan Bizz",
    Folder = "BizzLoader",
    Size = UDim2.fromOffset(600, 480),
    MinSize = Vector2.new(550, 400),
    MaxSize = Vector2.new(800, 600),
    ToggleKey = Enum.KeyCode.Insert,
    Theme = "Dark",
    Resizable = true,
    SideBarWidth = 180,
    HideSearchBar = false,
    ScrollBarEnabled = true,
})

-- =============================================
-- TAB 1: MAIN
-- =============================================
local MainTab = Window:Tab({
    Title = "Main",
    Icon = "solar:home-2-bold",
    IconColor = Color3.fromHex("#257AF7"),
    IconShape = "Square",
    Border = true,
})

-- Section: System Info
local InfoSection = MainTab:Section({
    Title = "System Info",
})

InfoSection:Paragraph({
    Title = "Status: ✅ Online",
    Desc = "User: " .. game.Players.LocalPlayer.Name,
})

InfoSection:Paragraph({
    Title = "Ping: " .. math.floor(game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()) .. " ms",
    Desc = "Players: " .. #game.Players:GetPlayers(),
})

-- Section: Quick Controls
local ControlsSection = MainTab:Section({
    Title = "Quick Controls",
})

ControlsSection:Button({
    Title = "Teleport to Spawn",
    Icon = "solar:map-point-bold",
    Color = Color3.fromHex("#10C550"),
    Justify = "Center",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            char.HumanoidRootPart.CFrame = CFrame.new(0, 5, 0)
            WindUI:Notify({ Title = "Teleport", Content = "Teleported to spawn!", Icon = "check", Duration = 2 })
        else
            WindUI:Notify({ Title = "Error", Content = "Character not found!", Icon = "x", Duration = 2 })
        end
    end,
})

ControlsSection:Button({
    Title = "Respawn Character",
    Icon = "solar:refresh-bold",
    Color = Color3.fromHex("#ECA201"),
    Justify = "Center",
    Callback = function()
        game.Players.LocalPlayer:LoadCharacter()
        WindUI:Notify({ Title = "Respawn", Content = "Character respawned!", Icon = "check", Duration = 2 })
    end,
})

ControlsSection:Button({
    Title = "Clear Chat",
    Icon = "solar:eraser-bold",
    Color = Color3.fromHex("#EF4F1D"),
    Justify = "Center",
    Callback = function()
        game:GetService("Chat"):Clear()
        WindUI:Notify({ Title = "Chat", Content = "Chat cleared!", Icon = "check", Duration = 2 })
    end,
})

-- Section: Toggles
local TogglesSection = MainTab:Section({
    Title = "Toggles",
})

TogglesSection:Toggle({
    Title = "NoClip",
    Desc = "Walk through walls",
    Icon = "solar:square-transfer-horizontal-bold",
    Value = false,
    Callback = function(state)
        local char = game.Players.LocalPlayer.Character
        if char then
            for _, part in pairs(char:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = not state
                end
            end
            WindUI:Notify({ Title = "NoClip", Content = state and "ON" or "OFF", Duration = 1 })
        end
    end,
})

TogglesSection:Toggle({
    Title = "Infinite Jump",
    Desc = "Jump without limits",
    Icon = "solar:arrow-up-bold",
    Value = false,
    Callback = function(state)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, state)
            char.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, state)
            char.Humanoid.PlatformStand = state
            WindUI:Notify({ Title = "Infinite Jump", Content = state and "ON" or "OFF", Duration = 1 })
        end
    end,
})

TogglesSection:Toggle({
    Title = "Anti-AFK",
    Desc = "Prevent being kicked for idle",
    Icon = "solar:shield-check-bold",
    Value = false,
    Callback = function(state)
        if state then
            local vu = game:GetService("VirtualUser")
            game:GetService("Players").LocalPlayer.Idled:Connect(function()
                vu:CaptureController()
                vu:ClickButton2(Vector2.new())
            end)
            WindUI:Notify({ Title = "Anti-AFK", Content = "ON", Duration = 1 })
        else
            WindUI:Notify({ Title = "Anti-AFK", Content = "OFF (restart to disable)", Duration = 2 })
        end
    end,
})

-- =============================================
-- TAB 2: VISUALS
-- =============================================
local VisualsTab = Window:Tab({
    Title = "Visuals",
    Icon = "solar:eye-bold",
    IconColor = Color3.fromHex("#7775F2"),
    IconShape = "Square",
    Border = true,
})

local EspSection = VisualsTab:Section({
    Title = "ESP Settings",
})

local espEnabled = false
local espConnections = {}

EspSection:Toggle({
    Title = "Enable ESP",
    Desc = "Highlight other players",
    Icon = "solar:eye-bold",
    Value = false,
    Callback = function(state)
        espEnabled = state
        if state then
            WindUI:Notify({ Title = "ESP", Content = "ON", Duration = 1 })
            -- ESP Loop
            spawn(function()
                while espEnabled do
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
                    wait(0.5)
                end
            end)
        else
            -- Remove all highlights
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
            WindUI:Notify({ Title = "ESP", Content = "OFF", Duration = 1 })
        end
    end,
})

EspSection:Slider({
    Title = "ESP Transparency",
    Step = 0.05,
    IsTooltip = true,
    Value = { Min = 0, Max = 1, Default = 0.5 },
    Callback = function(value)
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
    end,
})

EspSection:Colorpicker({
    Title = "ESP Color",
    Default = Color3.new(1, 0, 0),
    Callback = function(color)
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
    end,
})

-- Section: Player List
local PlayerListSection = VisualsTab:Section({
    Title = "Player List",
})

local playerCountLabel = PlayerListSection:Paragraph({
    Title = "Players: " .. #game.Players:GetPlayers(),
    Desc = "Online players in server",
})

game.Players.PlayerAdded:Connect(function()
    playerCountLabel:SetTitle("Players: " .. #game.Players:GetPlayers())
end)
game.Players.PlayerRemoved:Connect(function()
    playerCountLabel:SetTitle("Players: " .. #game.Players:GetPlayers())
end)

-- =============================================
-- TAB 3: MISC
-- =============================================
local MiscTab = Window:Tab({
    Title = "Misc",
    Icon = "solar:folder-with-files-bold",
    IconColor = Color3.fromHex("#ECA201"),
    IconShape = "Square",
    Border = true,
})

-- Section: Walk / Fly Speed
local SpeedSection = MiscTab:Section({
    Title = "Walk / Jump Speed",
})

SpeedSection:Slider({
    Title = "Walk Speed",
    Step = 1,
    IsTooltip = true,
    Value = { Min = 0, Max = 100, Default = 16 },
    Callback = function(value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.WalkSpeed = value
        end
    end,
})

SpeedSection:Slider({
    Title = "Jump Power",
    Step = 1,
    IsTooltip = true,
    Value = { Min = 0, Max = 100, Default = 50 },
    Callback = function(value)
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("Humanoid") then
            char.Humanoid.JumpPower = value
        end
    end,
})

-- Section: Teleport to Player
local TeleportSection = MiscTab:Section({
    Title = "Teleport to Player",
})

TeleportSection:Dropdown({
    Title = "Select Player",
    Values = game.Players:GetPlayers(),
    Value = nil,
    Callback = function(selected)
        local target = game.Players:FindFirstChild(selected)
        if target and target.Character and target.Character:FindFirstChild("HumanoidRootPart") then
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = target.Character.HumanoidRootPart.CFrame + Vector3.new(0, 3, 0)
                WindUI:Notify({ Title = "Teleport", Content = "Teleported to " .. selected, Duration = 2 })
            end
        else
            WindUI:Notify({ Title = "Error", Content = "Target not found!", Duration = 2 })
        end
    end,
})

-- Section: Tools
local ToolsSection = MiscTab:Section({
    Title = "Tools",
})

ToolsSection:Button({
    Title = "Get All Tools",
    Icon = "solar:folder-with-files-bold",
    Color = Color3.fromHex("#10C550"),
    Justify = "Center",
    Callback = function()
        local player = game.Players.LocalPlayer
        local backpack = player.Backpack
        for _, tool in pairs(backpack:GetChildren()) do
            tool.Parent = player.Character
            wait(0.1)
        end
        WindUI:Notify({ Title = "Tools", Content = "All tools equipped!", Duration = 2 })
    end,
})

ToolsSection:Button({
    Title = "Infinite Yield (CMD)",
    Icon = "solar:terminal-bold",
    Color = Color3.fromHex("#7775F2"),
    Justify = "Center",
    Callback = function()
        loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
        WindUI:Notify({ Title = "CMD", Content = "Infinite Yield loaded!", Duration = 2 })
    end,
})

-- Section: Credits
local CreditsSection = MiscTab:Section({
    Title = "Credits",
})

CreditsSection:Paragraph({
    Title = "🔥 Made by bl_ai for Tuan Bizz",
    Desc = "⚡ Version: 2.0\n😈 WindUI Native Loader",
})

-- =============================================
-- TAB 4: EXECUTOR
-- =============================================
local ExecutorTab = Window:Tab({
    Title = "Executor",
    Icon = "solar:code-bold",
    IconColor = Color3.fromHex("#EF4F1D"),
    IconShape = "Square",
    Border = true,
})

local ExecutorSection = ExecutorTab:Section({
    Title = "Execute Custom Script",
})

local scriptInput = ExecutorSection:Input({
    Title = "Script",
    Type = "Textarea",
    Placeholder = "Paste your script here...",
    Callback = function(text)
        _G.customScript = text
    end,
})

ExecutorSection:Button({
    Title = "Execute Script",
    Icon = "solar:play-bold",
    Color = Color3.fromHex("#10C550"),
    Justify = "Center",
    Callback = function()
        if _G.customScript and #_G.customScript > 0 then
            local success, err = pcall(loadstring(_G.customScript))
            if success then
                WindUI:Notify({ Title = "Executor", Content = "Script executed successfully!", Duration = 2 })
            else
                WindUI:Notify({ Title = "Error", Content = tostring(err), Duration = 3 })
            end
        else
            WindUI:Notify({ Title = "Error", Content = "No script to execute!", Duration = 2 })
        end
    end,
})

ExecutorSection:Button({
    Title = "Clear Script",
    Icon = "solar:eraser-bold",
    Color = Color3.fromHex("#EF4F1D"),
    Justify = "Center",
    Callback = function()
        _G.customScript = ""
        scriptInput:Set("")
        WindUI:Notify({ Title = "Executor", Content = "Script cleared!", Duration = 2 })
    end,
})

-- =============================================
-- AUTO FARM TAB
-- =============================================
local FarmTab = Window:Tab({
    Title = "Auto Farm",
    Icon = "solar:leaf-bold",
    IconColor = Color3.fromHex("#10C550"),
    IconShape = "Square",
    Border = true,
})

local FarmSection = FarmTab:Section({
    Title = "Auto Farm Settings",
})

local autoFarmActive = false

FarmSection:Toggle({
    Title = "Enable Auto Farm",
    Desc = "Auto collect items nearby",
    Icon = "solar:leaf-bold",
    Value = false,
    Callback = function(state)
        autoFarmActive = state
        if state then
            WindUI:Notify({ Title = "Auto Farm", Content = "ON", Duration = 1 })
            spawn(function()
                while autoFarmActive do
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
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
                                local detector = nearestItem:FindFirstChild("ClickDetector") or nearestItem.Parent:FindFirstChild("ClickDetector")
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
            WindUI:Notify({ Title = "Auto Farm", Content = "OFF", Duration = 1 })
        end
    end,
})

FarmSection:Slider({
    Title = "Farm Range",
    Step = 1,
    IsTooltip = true,
    Value = { Min = 10, Max = 100, Default = 50 },
    Callback = function(value)
        _G.farmRange = value
    end,
})

-- =============================================
-- COMBAT TAB
-- =============================================
local CombatTab = Window:Tab({
    Title = "Combat",
    Icon = "solar:sword-bold",
    IconColor = Color3.fromHex("#EF4F1D"),
    IconShape = "Square",
    Border = true,
})

local CombatSection = CombatTab:Section({
    Title = "Auto Combat",
})

local autoCombatActive = false

CombatSection:Toggle({
    Title = "Auto Attack Mobs",
    Desc = "Automatically attack nearby enemies",
    Icon = "solar:sword-bold",
    Value = false,
    Callback = function(state)
        autoCombatActive = state
        if state then
            WindUI:Notify({ Title = "Auto Combat", Content = "ON", Duration = 1 })
            spawn(function()
                while autoCombatActive do
                    local char = game.Players.LocalPlayer.Character
                    if char and char:FindFirstChild("HumanoidRootPart") then
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
            WindUI:Notify({ Title = "Auto Combat", Content = "OFF", Duration = 1 })
        end
    end,
})

CombatSection:Slider({
    Title = "Combat Range",
    Step = 1,
    IsTooltip = true,
    Value = { Min = 5, Max = 50, Default = 20 },
    Callback = function(value)
        _G.combatRange = value
    end,
})

-- Section: Kill Aura
local KillAuraSection = CombatTab:Section({
    Title = "Kill Aura",
})

local killAuraActive = false

KillAuraSection:Toggle({
    Title = "Kill Aura",
    Desc = "Instantly kill nearby enemies",
    Icon = "solar:skull-bold",
    Value = false,
    Callback = function(state)
        killAuraActive = state
        if state then
            WindUI:Notify({ Title = "Kill Aura", Content = "ON", Duration = 1 })
            spawn(function()
                while killAuraActive do
                    local char = game.Players.LocalPlayer.Character
                    if char then
                        for _, v in pairs(workspace:GetDescendants()) do
                            if                             if v:IsA("Model") and v:FindFirstChild("Humanoid") then
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
            WindUI:Notify({ Title = "Kill Aura", Content = "OFF", Duration = 1 })
        end
    end,
})

-- =============================================
-- TELEPORTS TAB
-- =============================================
local TeleportsTab = Window:Tab({
    Title = "Teleports",
    Icon = "solar:map-point-bold",
    IconColor = Color3.fromHex("#257AF7"),
    IconShape = "Square",
    Border = true,
})

local LocationsSection = TeleportsTab:Section({
    Title = "Saved Locations",
})

local locations = {}
local locationList = {}

local function saveLocation(name, pos)
    locations[name] = pos
    table.insert(locationList, name)
    WindUI:Notify({ Title = "Location", Content = "Saved: " .. name, Duration = 2 })
end

local locationNameInput = LocationsSection:Input({
    Title = "Location Name",
    Placeholder = "Enter name...",
    Callback = function(text)
        _G.tempLocationName = text
    end,
})

LocationsSection:Button({
    Title = "Save Current Location",
    Icon = "solar:save-bold",
    Color = Color3.fromHex("#10C550"),
    Justify = "Center",
    Callback = function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local pos = char.HumanoidRootPart.Position
            if _G.tempLocationName and #_G.tempLocationName > 0 then
                saveLocation(_G.tempLocationName, pos)
                -- Refresh dropdown
                local newDropdown = LocationsSection:Dropdown({
                    Title = "Select Location",
                    Values = locationList,
                    Value = nil,
                    Callback = function(selected)
                        local pos = locations[selected]
                        if pos then
                            local char = game.Players.LocalPlayer.Character
                            if char and char:FindFirstChild("HumanoidRootPart") then
                                char.HumanoidRootPart.CFrame = CFrame.new(pos)
                                WindUI:Notify({ Title = "Teleport", Content = "Teleported to " .. selected, Duration = 2 })
                            end
                        end
                    end,
                })
            end
        else
            WindUI:Notify({ Title = "Error", Content = "Character not found!", Duration = 2 })
        end
    end,
})

LocationsSection:Button({
    Title = "Clear All Locations",
    Icon = "solar:trash-bold",
    Color = Color3.fromHex("#EF4F1D"),
    Justify = "Center",
    Callback = function()
        locations = {}
        locationList = {}
        WindUI:Notify({ Title = "Locations", Content = "All locations cleared!", Duration = 2 })
    end,
})

-- Section: Quick Teleports
local QuickTeleportSection = TeleportsTab:Section({
    Title = "Quick Teleports",
})

local quickTeleports = {
    {"Spawn", CFrame.new(0, 5, 0)},
    {"Sky", CFrame.new(0, 500, 0)},
    {"Underground", CFrame.new(0, -50, 0)},
    {"Center", CFrame.new(0, 0, 0)},
}

for _, teleport in pairs(quickTeleports) do
    QuickTeleportSection:Button({
        Title = "Teleport to " .. teleport[1],
        Icon = "solar:map-pin-bold",
        Color = Color3.fromHex("#7775F2"),
        Justify = "Center",
        Callback = function()
            local char = game.Players.LocalPlayer.Character
            if char and char:FindFirstChild("HumanoidRootPart") then
                char.HumanoidRootPart.CFrame = teleport[2]
                WindUI:Notify({ Title = "Teleport", Content = "Teleported to " .. teleport[1], Duration = 2 })
            end
        end,
    })
end

-- =============================================
-- SETTINGS TAB
-- =============================================
local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "solar:settings-bold",
    IconColor = Color3.fromHex("#83889E"),
    IconShape = "Square",
    Border = true,
})

local UISection = SettingsTab:Section({
    Title = "UI Settings",
})

UISection:Button({
    Title = "Change Theme (Light/Dark)",
    Icon = "solar:palette-bold",
    Color = Color3.fromHex("#7775F2"),
    Justify = "Center",
    Callback = function()
        if Window.Theme == "Dark" then
            Window:SetTheme("Light")
            WindUI:Notify({ Title = "Theme", Content = "Light theme applied", Duration = 2 })
        else
            Window:SetTheme("Dark")
            WindUI:Notify({ Title = "Theme", Content = "Dark theme applied", Duration = 2 })
        end
    end,
})

UISection:Slider({
    Title = "UI Transparency",
    Step = 0.05,
    IsTooltip = true,
    Value = { Min = 0, Max = 1, Default = 0.9 },
    Callback = function(value)
        Window:SetTransparency(value)
    end,
})

-- Section: Keybinds
local KeybindSection = SettingsTab:Section({
    Title = "Keybinds",
})

KeybindSection:Keybind({
    Title = "Toggle GUI Key",
    Desc = "Current: Insert",
    Value = "Insert",
    Callback = function(key)
        Window:SetToggleKey(Enum.KeyCode[key])
        WindUI:Notify({ Title = "Keybind", Content = "Toggle key set to: " .. key, Duration = 2 })
    end,
})

-- Section: About
local AboutSection = SettingsTab:Section({
    Title = "About",
})

AboutSection:Paragraph({
    Title = "📦 Bizz Loader v2.0",
    Desc = "👨‍💻 Developed by bl_ai\n🎯 For Tuan Bizz\n📅 Created: 2026\n⚡ WindUI Native Framework",
})

-- =============================================
-- NOTIFICATIONS
-- =============================================
WindUI:Notify({
    Title = "Bizz Loader",
    Content = "✅ Loader berhasil diaktifkan!",
    Icon = "solar:check-circle-bold",
    Duration = 3,
})

print("===========================================")
print("🔥 BIZZ LOADER v2.0 LOADED SUCCESSFULLY!")
print("👤 User: " .. game.Players.LocalPlayer.Name)
print("📌 Open GUI with: Insert key")
print("===========================================")

-- =============================================
-- END OF SCRIPT
-- =============================================
