local MugiHub = loadstring(game:HttpGet("https://raw.githubusercontent.com/4MugiHub/MugiHub/refs/heads/main/Mugi"))()

local Window = MugiHub.Library:CreateWindow({
    "Nova Hub",
    "WELCOME",
    105,
    UDim2.fromOffset(480, 275),
    Enum.KeyCode.RightControl,
    "hub",
})

local Tab = Window:AddTab({"Main", "home"})
local Section = Tab:AddSection("General")



local Tab = Window:addTab({"Misc", "rocket"})

MugiHub.Library:SetNotification({Type = "success", Content = "Loaded!", Delay = 3})
