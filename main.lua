local MugiHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/4MugiHub/MugiHub/refs/heads/main/Mugi"))()

local Window = MugiHub.Library:CreateWindow({
    "Nova Hub",
    "A short tagline",
    105,
    UDim2.fromOffset(480, 275),
    Enum.KeyCode.RightControl,
    "hub",
})

local Tab = Window:AddTab({"Main", "home"})
local Section = Tab:AddSection("General")

Section:AddToggle({
    "Example Toggle",
    false,
    function(value) print("Toggle is now:", value) end
})

Section:AddConfigManager({})

MugiHub.Library:SetNotification({Type = "success", Content = "Loaded!", Delay = 3})
