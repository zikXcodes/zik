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
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        if not player then return end
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value
        end
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

local OpenButton = {
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
}

local User = {
    Enabled   = true,
    Anonymous = false,          -- show "Anonymous" instead of real name
    Callback  = function()      -- called when the user clicks the panel
        print("user clicked")
    end,
}

-- Choose a single background. Examples below — uncomment what you want to use.

-- Solid asset
-- local Background = "rbxassetid://123456789"

-- HTTPS image (downloaded on first run)
-- local Background = "https://example.com/bg.png"

-- Looping video
-- local Background = "video:rbxassetid://987654321"

-- Gradient (example)
local Background = WindUI:Gradient({
    ["0"]   = { Color = Color3.fromHex("#1a1a2e"), Transparency = 0 },
    ["100"] = { Color = Color3.fromHex("#16213e"), Transparency = 0 },
}, { Rotation = 90 })

-- If WindUI supports setting these after creation, apply them. Example (only if API supports):
-- Window:SetOpenButton(OpenButton)
-- Window:SetUserPanel(User)
-- Window:SetBackground(Background)
