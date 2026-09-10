local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Zik",
    Icon = "",
    Theme = "Crimson",
    Folder = "MyHub",
})

local Tab = Window:Tab({
    Title = "Main",
    Icon = "home",
})

-- Toggle
Tab:Toggle({
    Title = "Enable Feature",
    Value = false,
    Callback = function(state)
        print("Feature enabled:", state)
    end,
})

Tab:Space()

-- Button
Tab:Button({
    Title = "Run Action",
    Icon = "play",
    Callback = function()
        print("Button clicked")
    end,
})

Tab:Space()

-- Slider
Tab:Slider({
    Title = "Walk Speed",
    Step = 1,
    Value = {
        Min = 16,
        Max = 100,
        Default = 16,
    },
    Callback = function(value)
        game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
    end,
})

Tab:Space()

-- Dropdown
Tab:Dropdown({
    Title = "Select Team",
    Values = { "Red", "Blue", "Green" },
    Value = 1,
    Callback = function(selectedValue)
        print("Team selected:", selectedValue)
    end,
})

WindUI:Notify({
    Title = "Hub Loaded",
    Content = "Welcome! My Hub is ready.",
    Icon = "solar:bell-bold",
    Duration = 5,
})

OpenButton = {
    Title         = "Open Hub",
    CornerRadius  = UDim.new(1, 0),
    StrokeThickness = 3,
    Enabled       = true,
    Draggable     = true,
    OnlyMobile    = false,
    Scale         = 0.5,
    Color         = ColorSequence.new(
        Color3.fromHex("#30FF6A"),
        Color3.fromHex("#e7ff2f")
    ),
},

User = {
    Enabled   = true,
    Anonymous = false,          -- show "Anonymous" instead of real name
    Callback  = function()      -- called when the user clicks the panel
        print("user clicked")
    end,
},

-- Solid asset
Background = "rbxassetid://123456789",

-- HTTPS image (downloaded on first run)
Background = "https://example.com/bg.png",

-- Looping video
Background = "video:rbxassetid://987654321",

-- Gradient
Background = WindUI:Gradient({
    ["0"]   = { Color = Color3.fromHex("#1a1a2e"), Transparency = 0 },
    ["100"] = { Color = Color3.fromHex("#16213e"), Transparency = 0 },
}, { Rotation = 90 }),
