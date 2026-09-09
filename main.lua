--========================================================
-- STEAL AN EGG • WINDUI
-- UI TEMPLATE
--========================================================

local WindUI = loadstring(game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
))()

local Window = WindUI:CreateWindow({
    Title = "IZZ HUB",
    Icon = "egg",
    Author = "Steal an Egg",
    Folder = "IZZHub",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
    Resizable = true,
})

--========================================================
-- MAIN TAB
--========================================================

local MainTab = Window:Tab({
    Title = "Main",
    Icon = "house",
})

MainTab:Paragraph({
    Title = "IZZ HUB",
    Desc = "Steal an Egg UI",
})

MainTab:Button({
    Title = "Test Notification",
    Desc = "Test WindUI notification",
    Callback = function()
        WindUI:Notify({
            Title = "IZZ HUB",
            Content = "UI berhasil dijalankan!",
            Duration = 3,
        })
    end
})

--========================================================
-- EGG TAB
--========================================================

local EggTab = Window:Tab({
    Title = "Egg",
    Icon = "egg",
})

EggTab:Section({
    Title = "Egg Controls"
})

EggTab:Toggle({
    Title = "Auto Collect",
    Desc = "Placeholder untuk sistem game milik sendiri",
    Value = false,

    Callback = function(Value)
        print("Auto Collect:", Value)
    end
})

EggTab:Slider({
    Title = "Collect Distance",
    Desc = "Jarak interaksi egg",
    Value = {
        Min = 5,
        Max = 100,
        Default = 25,
    },

    Callback = function(Value)
        print("Distance:", Value)
    end
})

--========================================================
-- PLAYER TAB
--========================================================

local PlayerTab = Window:Tab({
    Title = "Player",
    Icon = "user",
})

PlayerTab:Section({
    Title = "Player Settings"
})

PlayerTab:Slider({
    Title = "WalkSpeed",
    Value = {
        Min = 8,
        Max = 50,
        Default = 16,
    },

    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character

        if character then
            local humanoid = character:FindFirstChildOfClass("Humanoid")

            if humanoid then
                humanoid.WalkSpeed = Value
            end
        end
    end
})

--========================================================
-- SETTINGS
--========================================================

local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "settings",
})

SettingsTab:Button({
    Title = "Destroy UI",
    Callback = function()
        Window:Destroy()
    end
})

print("IZZ HUB loaded successfully")
