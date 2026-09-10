--========================================================--
--                    IZZ HUB UI                          --
--          Premium Roblox Hub UI Template                --
--          Mobile • PC • Tablet • Responsive             --
--========================================================--

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")

--========================================================--
-- CONFIG
--========================================================--

local CONFIG = {
    Name = "IZZ HUB",
    Version = "v1.0.0",

    Background = Color3.fromRGB(7, 7, 10),
    Card = Color3.fromRGB(15, 15, 20),
    Card2 = Color3.fromRGB(20, 20, 26),

    Red = Color3.fromRGB(255, 0, 60),
    Red2 = Color3.fromRGB(255, 23, 68),

    Text = Color3.fromRGB(255, 255, 255),
    Muted = Color3.fromRGB(135, 135, 145),

    Border = Color3.fromRGB(38, 38, 45),
}

--========================================================--
-- CLEAN OLD UI
--========================================================--

local Old = PlayerGui:FindFirstChild("IZZ_HUB")
if Old then
    Old:Destroy()
end

--========================================================--
-- HELPERS
--========================================================--

local function New(class, properties)
    local object = Instance.new(class)

    for property, value in pairs(properties or {}) do
        object[property] = value
    end

    return object
end

local function Corner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius or 8)
    corner.Parent = parent
    return corner
end

local function Stroke(parent, color, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color or CONFIG.Border
    stroke.Transparency = transparency or 0
    stroke.Thickness = 1
    stroke.Parent = parent
    return stroke
end

local function Padding(parent, amount)
    local padding = Instance.new("UIPadding")
    padding.PaddingTop = UDim.new(0, amount)
    padding.PaddingBottom = UDim.new(0, amount)
    padding.PaddingLeft = UDim.new(0, amount)
    padding.PaddingRight = UDim.new(0, amount)
    padding.Parent = parent
    return padding
end

local function Tween(object, duration, properties)
    return TweenService:Create(
        object,
        TweenInfo.new(
            duration,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        properties
    )
end

--========================================================--
-- SCREEN GUI
--========================================================--

local ScreenGui = New("ScreenGui", {
    Name = "IZZ_HUB",
    Parent = PlayerGui,
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
})

--========================================================--
-- MAIN WINDOW
--========================================================--

local Main = New("Frame", {
    Parent = ScreenGui,

    Size = UDim2.fromOffset(760, 480),
    Position = UDim2.new(0.5, -380, 0.5, -240),

    BackgroundColor3 = CONFIG.Background,
    BorderSizePixel = 0,

    ClipsDescendants = true,
})

Corner(Main, 14)
Stroke(Main, CONFIG.Border)

--========================================================--
-- TOP BAR
--========================================================--

local TopBar = New("Frame", {
    Parent = Main,

    Size = UDim2.new(1, 0, 0, 58),

    BackgroundColor3 = CONFIG.Card,
    BorderSizePixel = 0,
})

local Logo = New("TextLabel", {
    Parent = TopBar,

    BackgroundTransparency = 1,

    Position = UDim2.fromOffset(20, 8),
    Size = UDim2.fromOffset(180, 24),

    Font = Enum.Font.GothamBold,
    Text = "IZZ HUB",

    TextColor3 = CONFIG.Text,
    TextSize = 20,

    TextXAlignment = Enum.TextXAlignment.Left,
})

local Version = New("TextLabel", {
    Parent = TopBar,

    BackgroundTransparency = 1,

    Position = UDim2.fromOffset(21, 31),
    Size = UDim2.fromOffset(100, 18),

    Font = Enum.Font.Gotham,
    Text = CONFIG.Version,

    TextColor3 = CONFIG.Muted,
    TextSize = 11,

    TextXAlignment = Enum.TextXAlignment.Left,
})

--========================================================--
-- MINIMIZE BUTTON
--========================================================--

local Minimize = New("TextButton", {
    Parent = TopBar,

    BackgroundColor3 = CONFIG.Card2,

    Position = UDim2.new(1, -46, 0, 13),
    Size = UDim2.fromOffset(32, 32),

    Text = "—",

    Font = Enum.Font.GothamBold,
    TextSize = 18,

    TextColor3 = CONFIG.Text,

    AutoButtonColor = false,
})

Corner(Minimize, 8)

Minimize.MouseEnter:Connect(function()
    Tween(Minimize, 0.15, {
        BackgroundColor3 = CONFIG.Red
    }):Play()
end)

Minimize.MouseLeave:Connect(function()
    Tween(Minimize, 0.15, {
        BackgroundColor3 = CONFIG.Card2
    }):Play()
end)

--========================================================--
-- SIDEBAR
--========================================================--

local Sidebar = New("Frame", {
    Parent = Main,

    Position = UDim2.fromOffset(0, 58),
    Size = UDim2.fromOffset(175, -58),

    BackgroundColor3 = CONFIG.Card,
    BorderSizePixel = 0,
})

Padding(Sidebar, 12)

local SidebarLayout = New("UIListLayout", {
    Parent = Sidebar,

    Padding = UDim.new(0, 6),

    SortOrder = Enum.SortOrder.LayoutOrder,
})

--========================================================--
-- CONTENT
--========================================================--

local Content = New("Frame", {
    Parent = Main,

    Position = UDim2.fromOffset(175, 58),
    Size = UDim2.new(1, -175, 1, -58),

    BackgroundColor3 = CONFIG.Background,
    BorderSizePixel = 0,
})

--========================================================--
-- SCROLLING AREA
--========================================================--

local Scroll = New("ScrollingFrame", {
    Parent = Content,

    Position = UDim2.fromOffset(15, 15),
    Size = UDim2.new(1, -30, 1, -30),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ScrollBarThickness = 3,
    ScrollBarImageColor3 = CONFIG.Red,

    CanvasSize = UDim2.new(0, 0, 0, 0),

    AutomaticCanvasSize = Enum.AutomaticSize.Y,
})

Padding(Scroll, 5)

local Layout = New("UIListLayout", {
    Parent = Scroll,

    Padding = UDim.new(0, 10),

    SortOrder = Enum.SortOrder.LayoutOrder,
})

--========================================================--
-- PAGE SYSTEM
--========================================================--

local Pages = {}
local CurrentPage

local function CreatePage(name)
    local Page = New("Frame", {
        Parent = Scroll,

        Name = name,

        Size = UDim2.new(1, -10, 0, 0),

        BackgroundTransparency = 1,

        Visible = false,

        AutomaticSize = Enum.AutomaticSize.Y,
    })

    local PageLayout = New("UIListLayout", {
        Parent = Page,

        Padding = UDim.new(0, 10),

        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    Pages[name] = Page

    return Page
end

local function ShowPage(name)
    for pageName, page in pairs(Pages) do
        page.Visible = pageName == name
    end

    CurrentPage = name
end

--========================================================--
-- TITLE
--========================================================--

local function AddTitle(page, title, description)

    local Holder = New("Frame", {
        Parent = page,

        Size = UDim2.new(1, 0, 0, 65),

        BackgroundTransparency = 1,
    })

    local Title = New("TextLabel", {
        Parent = Holder,

        BackgroundTransparency = 1,

        Size = UDim2.new(1, 0, 0, 30),

        Font = Enum.Font.GothamBold,
        Text = title,

        TextColor3 = CONFIG.Text,
        TextSize = 24,

        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local Description = New("TextLabel", {
        Parent = Holder,

        BackgroundTransparency = 1,

        Position = UDim2.fromOffset(0, 31),
        Size = UDim2.new(1, 0, 0, 25),

        Font = Enum.Font.Gotham,
        Text = description or "",

        TextColor3 = CONFIG.Muted,
        TextSize = 12,

        TextXAlignment = Enum.TextXAlignment.Left,
    })

end

--========================================================--
-- SECTION
--========================================================--

local function AddSection(page, text)

    local Label = New("TextLabel", {
        Parent = page,

        Size = UDim2.new(1, 0, 0, 24),

        BackgroundTransparency = 1,

        Font = Enum.Font.GothamBold,
        Text = text,

        TextColor3 = CONFIG.Red,
        TextSize = 12,

        TextXAlignment = Enum.TextXAlignment.Left,
    })

    return Label
end

--========================================================--
-- BUTTON
--========================================================--

local function AddButton(page, text, callback)

    local Button = New("TextButton", {
        Parent = page,

        Size = UDim2.new(1, 0, 0, 45),

        BackgroundColor3 = CONFIG.Card,

        Text = text,

        Font = Enum.Font.GothamSemibold,
        TextSize = 13,

        TextColor3 = CONFIG.Text,

        AutoButtonColor = false,
    })

    Corner(Button, 9)
    Stroke(Button, CONFIG.Border)

    Button.MouseEnter:Connect(function()
        Tween(Button, 0.15, {
            BackgroundColor3 = CONFIG.Card2
        }):Play()
    end)

    Button.MouseLeave:Connect(function()
        Tween(Button, 0.15, {
            BackgroundColor3 = CONFIG.Card
        }):Play()
    end)

    Button.MouseButton1Click:Connect(function()
        if callback then
            callback()
        end
    end)

    return Button
end

--========================================================--
-- TOGGLE
--========================================================--

local function AddToggle(page, text, default, callback)

    local Enabled = default or false

    local Holder = New("Frame", {
        Parent = page,

        Size = UDim2.new(1, 0, 0, 50),

        BackgroundColor3 = CONFIG.Card,
        BorderSizePixel = 0,
    })

    Corner(Holder, 9)
    Stroke(Holder, CONFIG.Border)

    local Label = New("TextLabel", {
        Parent = Holder,

        Position = UDim2.fromOffset(14, 0),
        Size = UDim2.new(1, -75, 1, 0),

        BackgroundTransparency = 1,

        Font = Enum.Font.GothamMedium,
        Text = text,

        TextColor3 = CONFIG.Text,
        TextSize = 13,

        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local Toggle = New("TextButton", {
        Parent = Holder,

        Position = UDim2.new(1, -55, 0.5, -12),
        Size = UDim2.fromOffset(42, 24),

        BackgroundColor3 = CONFIG.Card2,

        Text = "",

        AutoButtonColor = false,
    })

    Corner(Toggle, 12)

    local Circle = New("Frame", {
        Parent = Toggle,

        Position = UDim2.fromOffset(3, 3),
        Size = UDim2.fromOffset(18, 18),

        BackgroundColor3 = CONFIG.Muted,
        BorderSizePixel = 0,
    })

    Corner(Circle, 10)

    local function Update()

        if Enabled then

            Tween(Toggle, 0.2, {
                BackgroundColor3 = CONFIG.Red
            }):Play()

            Tween(Circle, 0.2, {
                Position = UDim2.new(1, -21, 0, 3),
                BackgroundColor3 = CONFIG.Text
            }):Play()

        else

            Tween(Toggle, 0.2, {
                BackgroundColor3 = CONFIG.Card2
            }):Play()

            Tween(Circle, 0.2, {
                Position = UDim2.fromOffset(3, 3),
                BackgroundColor3 = CONFIG.Muted
            }):Play()

        end

    end

    Toggle.MouseButton1Click:Connect(function()

        Enabled = not Enabled

        Update()

        if callback then
            callback(Enabled)
        end

    end)

    Update()

    return {
        Set = function(value)
            Enabled = value
            Update()

            if callback then
                callback(Enabled)
            end
        end,

        Get = function()
            return Enabled
        end,
    }

end

--========================================================--
-- DROPDOWN
--========================================================--

local function AddDropdown(page, text, options, callback)

    local Opened = false
    local Selected = options[1] or "Select"

    local Holder = New("Frame", {
        Parent = page,

        Size = UDim2.new(1, 0, 0, 48),

        BackgroundColor3 = CONFIG.Card,

        BorderSizePixel = 0,

        ClipsDescendants = true,
    })

    Corner(Holder, 9)
    Stroke(Holder, CONFIG.Border)

    local Button = New("TextButton", {
        Parent = Holder,

        Size = UDim2.new(1, 0, 0, 48),

        BackgroundTransparency = 1,

        Text = text .. " : " .. Selected,

        Font = Enum.Font.GothamMedium,
        TextSize = 13,

        TextColor3 = CONFIG.Text,

        AutoButtonColor = false,
    })

    Button.TextXAlignment = Enum.TextXAlignment.Left

    Padding(Button, 12)

    local List = New("Frame", {
        Parent = Holder,

        Position = UDim2.fromOffset(0, 48),

        Size = UDim2.new(1, 0, 0, #options * 36),

        BackgroundColor3 = CONFIG.Card2,

        BorderSizePixel = 0,
    })

    local ListLayout = New("UIListLayout", {
        Parent = List,

        SortOrder = Enum.SortOrder.LayoutOrder,
    })

    for _, option in ipairs(options) do

        local Option = New("TextButton", {
            Parent = List,

            Size = UDim2.new(1, 0, 0, 36),

            BackgroundTransparency = 1,

            Text = option,

            Font = Enum.Font.Gotham,
            TextSize = 12,

            TextColor3 = CONFIG.Text,

            AutoButtonColor = false,
        })

        Option.MouseButton1Click:Connect(function()

            Selected = option

            Button.Text = text .. " : " .. Selected

            Opened = false

            Tween(Holder, 0.2, {
                Size = UDim2.new(1, 0, 0, 48)
            }):Play()

            if callback then
                callback(Selected)
            end

        end)

    end

    Button.MouseButton1Click:Connect(function()

        Opened = not Opened

        local Height = Opened
            and (48 + (#options * 36))
            or 48

        Tween(Holder, 0.2, {
            Size = UDim2.new(1, 0, 0, Height)
        }):Play()

    end)

    return Holder
end

--========================================================--
-- PAGES
--========================================================--

local Home = CreatePage("Home")
local Combat = CreatePage("Combat")
local Farm = CreatePage("Farm")
local PlayerPage = CreatePage("Player")
local Teleport = CreatePage("Teleport")
local Settings = CreatePage("Settings")

--========================================================--
-- HOME
--========================================================--

AddTitle(
    Home,
    "Welcome to IZZ HUB",
    "Premium Roblox utility interface"
)

AddSection(Home, "SYSTEM")

AddButton(Home, "Check Status", function()
    print("IZZ HUB: Online")
end)

AddButton(Home, "Test Notification", function()
    print("Notification test")
end)

AddSection(Home, "INFORMATION")

AddButton(Home, "IZZ HUB " .. CONFIG.Version, function()
    print("IZZ HUB version:", CONFIG.Version)
end)

--========================================================--
-- COMBAT
--========================================================--

AddTitle(
    Combat,
    "Combat",
    "Combat-related controls"
)

AddSection(Combat, "FEATURES")

AddToggle(Combat, "Example Toggle", false, function(value)
    print("Example Toggle:", value)
end)

AddButton(Combat, "Example Action", function()
    print("Example action")
end)

--========================================================--
-- FARM
--========================================================--

AddTitle(
    Farm,
    "Farm",
    "Automation controls"
)

AddSection(Farm, "AUTOMATION")

AddToggle(Farm, "Auto Farm", false, function(value)
    print("Auto Farm:", value)
end)

AddToggle(Farm, "Auto Collect", false, function(value)
    print("Auto Collect:", value)
end)

--========================================================--
-- PLAYER
--========================================================--

AddTitle(
    PlayerPage,
    "Player",
    "Player customization"
)

AddSection(PlayerPage, "PLAYER")

AddToggle(PlayerPage, "Example Feature", false, function(value)
    print("Player feature:", value)
end)

AddDropdown(
    PlayerPage,
    "Mode",
    {
        "Default",
        "Fast",
        "Maximum"
    },
    function(value)
        print("Selected:", value)
    end
)

--========================================================--
-- TELEPORT
--========================================================--

AddTitle(
    Teleport,
    "Teleport",
    "Teleport locations"
)

AddSection(Teleport, "LOCATIONS")

AddButton(Teleport, "Location 1", function()
    print("Teleport 1")
end)

AddButton(Teleport, "Location 2", function()
    print("Teleport 2")
end)

AddButton(Teleport, "Location 3", function()
    print("Teleport 3")
end)

--========================================================--
-- SETTINGS
--========================================================--

AddTitle(
    Settings,
    "Settings",
    "IZZ HUB configuration"
)

AddSection(Settings, "INTERFACE")

AddToggle(Settings, "UI Animation", true, function(value)
    print("Animation:", value)
end)

AddToggle(Settings, "Notifications", true, function(value)
    print("Notifications:", value)
end)

--========================================================--
-- SIDEBAR BUTTON SYSTEM
--========================================================--

local TabButtons = {}

local function AddTab(name, icon)

    local Button = New("TextButton", {
        Parent = Sidebar,

        Size = UDim2.new(1, 0, 0, 40),

        BackgroundColor3 = CONFIG.Card,

        Text = "  " .. icon .. "   " .. name,

        Font = Enum.Font.GothamMedium,
        TextSize = 12,

        TextColor3 = CONFIG.Muted,

        TextXAlignment = Enum.TextXAlignment.Left,

        AutoButtonColor = false,
    })

    Corner(Button, 8)

    TabButtons[name] = Button

    Button.MouseButton1Click:Connect(function()

        ShowPage(name)

        for tabName, tab in pairs(TabButtons) do

            Tween(tab, 0.15, {
                BackgroundColor3 =
                    tabName == name
                    and CONFIG.Red
                    or CONFIG.Card,

                TextColor3 =
                    tabName == name
                    and CONFIG.Text
                    or CONFIG.Muted,
            }):Play()

        end

    end)

    return Button
end

AddTab("Home", "◆")
AddTab("Combat", "⚔")
AddTab("Farm", "◈")
AddTab("Player", "●")
AddTab("Teleport", "◇")
AddTab("Settings", "⚙")

--========================================================--
-- SHOW DEFAULT PAGE
--========================================================--

ShowPage("Home")

Tween(TabButtons.Home, 0.15, {
    BackgroundColor3 = CONFIG.Red,
    TextColor3 = CONFIG.Text,
}):Play()

--========================================================--
-- DRAG SYSTEM
--========================================================--

local Dragging = false
local DragStart
local StartPosition

TopBar.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true
        DragStart = input.Position
        StartPosition = Main.Position

    end

end)

UserInputService.InputChanged:Connect(function(input)

    if not Dragging then
        return
    end

    if input.UserInputType ~= Enum.UserInputType.MouseMovement
        and input.UserInputType ~= Enum.UserInputType.Touch then return
    end

    local Delta = input.Position - DragStart

    Main.Position = UDim2.new(
        StartPosition.X.Scale,
        StartPosition.X.Offset + Delta.X,

        StartPosition.Y.Scale,
        StartPosition.Y.Offset + Delta.Y
    )
end)

UserInputService.InputEnded:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = false

    end

end)

--========================================================--
-- MINIMIZE / RESTORE
--========================================================--

local Minimized = false
local LastPosition = Main.Position

local Floating = New("TextButton", {
    Parent = ScreenGui,

    Size = UDim2.fromOffset(52, 52),

    Position = UDim2.new(
        0,
        20,
        0.5,
        -26
    ),

    BackgroundColor3 = CONFIG.Red,

    Text = "IZZ",

    Font = Enum.Font.GothamBold,
    TextSize = 14,

    TextColor3 = CONFIG.Text,

    Visible = false,

    AutoButtonColor = false,
})

Corner(Floating, 16)
Stroke(Floating, CONFIG.Red2)

Minimize.MouseButton1Click:Connect(function()

    if Minimized then
        return
    end

    Minimized = true

    LastPosition = Main.Position

    local HideTween = Tween(
        Main,
        0.3,
        {
            Size = UDim2.fromOffset(0, 0)
        }
    )

    HideTween:Play()

    HideTween.Completed:Connect(function()
        Main.Visible = false
        Floating.Visible = true
    end)

end)

Floating.MouseButton1Click:Connect(function()

    if not Minimized then
        return
    end

    Minimized = false

    Floating.Visible = false
    Main.Visible = true

    Main.Position = LastPosition
    Main.Size = UDim2.fromOffset(0, 0)

    Tween(
        Main,
        0.3,
        {
            Size = UDim2.fromOffset(760, 480)
        }
    ):Play()

end)

--========================================================--
-- OPEN ANIMATION
--========================================================--

Main.Size = UDim2.fromOffset(0, 0)

Tween(
    Main,
    0.45,
    {
        Size = UDim2.fromOffset(760, 480)
    }
):Play()

--========================================================--
-- FINAL
--========================================================--

print("================================")
print("        IZZ HUB UI")
print("        Loaded Successfully")
print("        Version:", CONFIG.Version)
print("================================")
       
