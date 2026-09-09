--========================================================--
--                    IZZ HUB UI                          --
--       Responsive / Mobile / PC / Tablet               --
--       Minimize / Restore / Drag / Search              --
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

    Red = Color3.fromRGB(255, 0, 55),
    Red2 = Color3.fromRGB(180, 0, 35),

    Background = Color3.fromRGB(5, 5, 9),
    Sidebar = Color3.fromRGB(9, 9, 14),
    Card = Color3.fromRGB(13, 13, 19),

    Text = Color3.fromRGB(255, 255, 255),
    Muted = Color3.fromRGB(145, 145, 155),

    Tween = 0.25,
}

--========================================================--
-- CLEAN OLD GUI
--========================================================--

pcall(function()
    PlayerGui:FindFirstChild(CONFIG.Name):Destroy()
end)

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
    local c = New("UICorner", {
        CornerRadius = UDim.new(0, radius or 10)
    })

    c.Parent = parent

    return c
end

local function Stroke(parent, color, thickness, transparency)
    local s = New("UIStroke", {
        Color = color or CONFIG.Red,
        Thickness = thickness or 1,
        Transparency = transparency or 0,
    })

    s.Parent = parent

    return s
end

local function Tween(object, time, properties)
    local tween = TweenService:Create(
        object,
        TweenInfo.new(
            time or CONFIG.Tween,
            Enum.EasingStyle.Quint,
            Enum.EasingDirection.Out
        ),
        properties
    )

    tween:Play()

    return tween
end

--========================================================--
-- SCREEN GUI
--========================================================--

local ScreenGui = New("ScreenGui", {
    Name = CONFIG.Name,
    Parent = PlayerGui,

    ResetOnSpawn = false,
    IgnoreGuiInset = true,

    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
})

--========================================================--
-- MAIN WINDOW
--========================================================--

local MainFrame = New("Frame", {
    Name = "MainFrame",
    Parent = ScreenGui,

    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),

    Size = UDim2.fromOffset(920, 570),

    BackgroundColor3 = CONFIG.Background,
    BorderSizePixel = 0,

    ClipsDescendants = true,
})

Corner(MainFrame, 16)
Stroke(MainFrame, CONFIG.Red, 1.5, 0.25)

--========================================================--
-- SCALE
--========================================================--

local UIScale = New("UIScale", {
    Parent = MainFrame,
})

local function UpdateScale()
    local camera = workspace.CurrentCamera

    if not camera then
        return
    end

    local viewport = camera.ViewportSize

    local width = viewport.X
    local height = viewport.Y

    local scale = 1

    if width < 500 then
        scale = math.min(width / 390, height / 700)
    elseif width < 800 then
        scale = 0.82
    elseif width < 1100 then
        scale = 0.92
    else
        scale = 1
    end

    UIScale.Scale = math.clamp(scale, 0.65, 1)
end

UpdateScale()

workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(UpdateScale)

--========================================================--
-- RED GLOW
--========================================================--

local Glow = New("ImageLabel", {
    Name = "Glow",

    Parent = MainFrame,

    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.fromScale(0.5, 0.5),

    Size = UDim2.new(1, 100, 1, 100),

    BackgroundTransparency = 1,

    Image = "rbxassetid://5028857084",

    ImageColor3 = CONFIG.Red,
    ImageTransparency = 0.88,

    ZIndex = 0,
})

--========================================================--
-- SIDEBAR
--========================================================--

local Sidebar = New("Frame", {
    Name = "Sidebar",
    Parent = MainFrame,

    Size = UDim2.new(0, 230, 1, 0),

    BackgroundColor3 = CONFIG.Sidebar,
    BorderSizePixel = 0,

    ZIndex = 5,
})

--========================================================--
-- LOGO
--========================================================--

local Logo = New("TextLabel", {
    Parent = Sidebar,

    BackgroundTransparency = 1,

    Position = UDim2.fromOffset(25, 20),

    Size = UDim2.new(1, -40, 0, 45),

    Text = "♛  IZZ HUB",

    TextColor3 = CONFIG.Text,

    Font = Enum.Font.GothamBold,

    TextSize = 22,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 10,
})

local LogoAccent = New("TextLabel", {
    Parent = Sidebar,

    BackgroundTransparency = 1,

    Position = UDim2.fromOffset(58, 48),

    Size = UDim2.new(1, -70, 0, 18),

    Text = "Better • Faster • Stronger",

    TextColor3 = CONFIG.Muted,

    Font = Enum.Font.Gotham,

    TextSize = 9,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 10,
})

--========================================================--
-- SIDEBAR CONTAINER
--========================================================--

local TabContainer = New("Frame", {
    Parent = Sidebar,

    BackgroundTransparency = 1,

    Position = UDim2.fromOffset(15, 90),

    Size = UDim2.new(1, -30, 1, -170),

    ZIndex = 10,
})

local TabLayout = New("UIListLayout", {
    Parent = TabContainer,

    Padding = UDim.new(0, 5),

    SortOrder = Enum.SortOrder.LayoutOrder,
})

--========================================================--
-- SIDEBAR TABS
--========================================================--

local Tabs = {
    {"⌂", "Home"},
    {"ϟ", "Scripts"},
    {"♙", "Local Player"},
    {"⌖", "Teleport"},
    {"⚙", "Misc"},
    {"☷", "Settings"},
}

local TabButtons = {}

--========================================================--
-- CONTENT
--========================================================--

local Content = New("Frame", {
    Parent = MainFrame,

    Position = UDim2.fromOffset(230, 0),

    Size = UDim2.new(1, -230, 1, 0),

    BackgroundTransparency = 1,

    ZIndex = 5,
})

--========================================================--
-- TOP BAR
--========================================================--

local Header = New("Frame", {
    Parent = Content,

    Position = UDim2.fromOffset(20, 20),

    Size = UDim2.new(1, -40, 0, 55),

    BackgroundTransparency = 1,

    ZIndex = 10,
})

local Title = New("TextLabel", {
    Parent = Header,

    BackgroundTransparency = 1,

    Size = UDim2.new(0.5, 0, 1, 0),

    Text = "⌂  Home",

    TextColor3 = CONFIG.Text,

    Font = Enum.Font.GothamBold,

    TextSize = 20,

    TextXAlignment = Enum.TextXAlignment.Left,

    ZIndex = 10,
})

local SearchBox = New("TextBox", {
    Parent = Header,

    AnchorPoint = Vector2.new(1, 0.5),

    Position = UDim2.new(1, -50, 0.5, 0),

    Size = UDim2.fromOffset(190, 38),

    BackgroundColor3 = CONFIG.Card,

    BorderSizePixel = 0,

    PlaceholderText = "⌕  Cari script...",

    PlaceholderColor3 = CONFIG.Muted,

    Text = "",

    TextColor3 = CONFIG.Text,

    Font = Enum.Font.Gotham,

    TextSize = 12,

    ClearTextOnFocus = false,

    ZIndex = 10,
})

Corner(SearchBox, 10)
Stroke(SearchBox, Color3.fromRGB(40, 40, 50), 1, 0.2)

--========================================================--
-- MINIMIZE BUTTON
--========================================================--

local MinimizeButton = New("TextButton", {
    Parent = Header,

    AnchorPoint = Vector2.new(1, 0.5),

    Position = UDim2.new(1, 0, 0.5, 0),

    Size = UDim2.fromOffset(40, 38),

    BackgroundColor3 = CONFIG.Card,

    BorderSizePixel = 0,

    Text = "—",

    TextColor3 = CONFIG.Text,

    Font = Enum.Font.GothamBold,

    TextSize = 18,

    AutoButtonColor = false,

    ZIndex = 20,
})

Corner(MinimizeButton, 10)
Stroke(MinimizeButton, CONFIG.Red, 1, 0.35)

--========================================================--
-- CONTENT SCROLL
--========================================================--

local Scroll = New("ScrollingFrame", {
    Parent = Content,

    Position = UDim2.fromOffset(20, 85),

    Size = UDim2.new(1, -40, 1, -105),

    BackgroundTransparency = 1,

    BorderSizePixel = 0,

    ScrollBarThickness = 3,

    ScrollBarImageColor3 = CONFIG.Red,

    CanvasSize = UDim2.new(0, 0, 0, 0),

    AutomaticCanvasSize = Enum.AutomaticSize.Y,

    ZIndex = 8,
})

local List = New("UIListLayout", {
    Parent = Scroll,

    Padding = UDim.new(0, 8),

    SortOrder = Enum.SortOrder.LayoutOrder,
})

--========================================================--
-- CREATE SCRIPT ITEM
--========================================================--

local ScriptItems = {}

local function CreateScript(name, description, icon, callback)

    local Card = New("Frame", {
        Parent = Scroll,

        Size = UDim2.new(1, -5, 0, 55),

        BackgroundColor3 = CONFIG.Card,

        BorderSizePixel = 0,

        ZIndex = 10,
    })

    Corner(Card, 10)
    Stroke(Card, Color3.fromRGB(35, 35, 45), 1, 0.3)

    local Icon = New("TextLabel", {
        Parent = Card,

        Position = UDim2.fromOffset(12, 8),

        Size = UDim2.fromOffset(38, 38),

        BackgroundColor3 = Color3.fromRGB(35, 7, 15),

        Text = icon,

        TextColor3 = CONFIG.Red,

        Font = Enum.Font.GothamBold,

        TextSize = 17,

        ZIndex = 12,
    })

    Corner(Icon, 9)

    local Name = New("TextLabel", {
        Parent = Card,

        Position = UDim2.fromOffset(60, 7),

        Size = UDim2.new(1, -125, 0, 20),

        BackgroundTransparency = 1,

        Text = name,

        TextColor3 = CONFIG.Text,

        Font = Enum.Font.GothamSemibold,

        TextSize = 14,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 12,
    })

    local Description = New("TextLabel", {
        Parent = Card,

        Position = UDim2.fromOffset(60, 28),

        Size = UDim2.new(1, -125, 0, 18),

        BackgroundTransparency = 1,

        Text = description,

        TextColor3 = CONFIG.Muted,

        Font = Enum.Font.Gotham,

        TextSize = 10,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 12,
    })

    local Button = New("TextButton", {
        Parent = Card,

        AnchorPoint = Vector2.new(1, 0.5),

        Position = UDim2.new(1, -10, 0.5, 0),

        Size = UDim2.fromOffset(35, 35),

        BackgroundTransparency = 1,

        Text = "›",

        TextColor3 = CONFIG.Red,

        Font = Enum.Font.GothamBold,

        TextSize = 28,

        AutoButtonColor = false,

        ZIndex = 15,
    })

    Button.MouseButton1Click:Connect(function()

        if callback then
            callback()
        end

    end)

    Button.MouseEnter:Connect(function()
        Tween(Button, 0.15, {
            TextColor3 = Color3.new(1,1,1)
        })
    end)

    Button.MouseLeave:Connect(function()
        Tween(Button, 0.15, {
            TextColor3 = CONFIG.Red
        })
    end)

    table.insert(ScriptItems, {
        Frame = Card,
        Name = name,
        Description = description,
    })

    return Card
end

--========================================================--
-- DEMO FEATURES
--========================================================--

CreateScript(
    "Hitbox Modifier",
    "Ubah ukuran hitbox karakter.",
    "◎",
    function()
        print("Hitbox Modifier")
    end
)

CreateScript(
    "Infinite Jump",
    "Melompat tanpa batas.",
    "ϟ",
    function()
        print("Infinite Jump")
    end
)

CreateScript(
    "Speed",
    "Ubah movement speed.",
    "➤",
    function()
        print("Speed")
    end
)

CreateScript(
    "Anti Blind",
    "Kurangkan efek visual.",
    "◉",
    function()
        print("Anti Blind")
    end
)

CreateScript(
    "ESP",
    "Paparkan pemain melalui dinding.",
    "◈",
    function()
        print("ESP")
    end
)

CreateScript(
    "Fly",
    "Aktifkan movement fly.",
    "✈",
    function()
        print("Fly")
    end
)

--========================================================--
-- TOGGLE CREATOR
--========================================================--

local function CreateToggle(parent, text, default, callback)

    local Holder = New("Frame", {
        Parent = parent,

        Size = UDim2.new(1, -5, 0, 55),

        BackgroundColor3 = CONFIG.Card,

        BorderSizePixel = 0,
    })

    Corner(Holder, 10)
    Stroke(Holder, Color3.fromRGB(35,35,45), 1, 0.3)

    local Label = New("TextLabel", {
        Parent = Holder,

        Position = UDim2.fromOffset(15, 0),

        Size = UDim2.new(1, -80, 1, 0),

        BackgroundTransparency = 1,

        Text = text,

        TextColor3 = CONFIG.Text,

        Font = Enum.Font.GothamSemibold,

        TextSize = 13,

        TextXAlignment = Enum.TextXAlignment.Left,
    })

    local Toggle = New("TextButton", {
        Parent = Holder,

        AnchorPoint = Vector2.new(1, 0.5),

        Position = UDim2.new(1, -15, 0.5, 0),

        Size = UDim2.fromOffset(45, 24),

        BackgroundColor3 = Color3.fromRGB(35,35,42),

        Text = "",

        AutoButtonColor = false,
    })

    Corner(Toggle, 20)

    local Circle = New("Frame", {
        Parent = Toggle,

        Position = UDim2.fromOffset(3, 3),

        Size = UDim2.fromOffset(18,18),

        BackgroundColor3 = Color3.fromRGB(210,210,215),
    })

    Corner(Circle, 20)

    local enabled = default == true

    local function Update()

        if enabled then

            Tween(Toggle, 0.2, {
                BackgroundColor3 = CONFIG.Red
            })

            Tween(Circle, 0.2, {
                Position = UDim2.new(1, -21, 0, 3)
            })

        else

            Tween(Toggle, 0.2, {
                BackgroundColor3 = Color3.fromRGB(35,35,42)
            })

            Tween(Circle, 0.2, {
                Position = UDim2.fromOffset(3,3)
            })

        end

        if callback then
            callback(enabled)
        end

    end

    Toggle.MouseButton1Click:Connect(function()

        enabled = not enabled

        Update()

    end)

    Update()

    return Holder
end

--========================================================--
-- NOTIFICATION
--========================================================--

local NotificationHolder = New("Frame", {
    Parent = ScreenGui,

    AnchorPoint = Vector2.new(1,1),

    Position = UDim2.new(1,-20,1,-20),

    Size = UDim2.fromOffset(300,120),

    BackgroundTransparency = 1,

    ZIndex = 100,
})

local function Notify(title, text)

    local Notification = New("Frame", {
        Parent = NotificationHolder,

        AnchorPoint = Vector2.new(1,1),

        Position = UDim2.new(1,0,1,0),

        Size = UDim2.fromOffset(280,65),

        BackgroundColor3 = CONFIG.Card,

        BorderSizePixel = 0,

        ZIndex = 100,
    })

    Corner(Notification,12)
    Stroke(Notification,CONFIG.Red,1,0.3)

    local Dot = New("Frame", {
        Parent = Notification,

        Position = UDim2.fromOffset(12,15),

        Size = UDim2.fromOffset(8,8),

        BackgroundColor3 = CONFIG.Red,

        ZIndex = 102,
    })

    Corner(Dot,20)

    New("TextLabel", {
        Parent = Notification,

        Position = UDim2.fromOffset(30,9),

        Size = UDim2.new(1,-40,0,20),

        BackgroundTransparency = 1,

        Text = title,

        TextColor3 = CONFIG.Text,

        Font = Enum.Font.GothamBold,

        TextSize = 13,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 102,
    })

    New("TextLabel", {
        Parent = Notification,

        Position = UDim2.fromOffset(30,30),

        Size = UDim2.new(1,-40,0,22),

        BackgroundTransparency = 1,

        Text = text,

        TextColor3 = CONFIG.Muted,

        Font = Enum.Font.Gotham,

        TextSize = 10,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 102,
    })

    Notification.Position = UDim2.new(1,300,1,0)

    Tween(Notification,0.4,{
        Position = UDim2.new(1,0,1,0)
    })

    task.delay(3,function()

        Tween(Notification,0.3,{
            Position = UDim2.new(1,300,1,0)
        })

        task.wait(0.35)

        Notification:Destroy()

    end)

end

--========================================================--
-- FLOATING MINIMIZE BUTTON
--========================================================--

local FloatingButton = New("TextButton", {
    Parent = ScreenGui,

    AnchorPoint = Vector2.new(1,1),

    Position = UDim2.new(1,-25,1,-25),

    Size = UDim2.fromOffset(60,60),

    BackgroundColor3 = Color3.fromRGB(8,8,12),

    BorderSizePixel = 0,

    Text = "♛",

    TextColor3 = CONFIG.Red,

    Font = Enum.Font.GothamBold,

    TextSize = 25,

    Visible = false,

    AutoButtonColor = false,

    ZIndex = 200,
})

Corner(FloatingButton,18)
Stroke(FloatingButton,CONFIG.Red,2,0.1)

--========================================================--
-- FLOATING BUTTON GLOW
--========================================================--

local FloatingGlow = New("ImageLabel", {
    Parent = FloatingButton,

    AnchorPoint = Vector2.new(0.5,0.5),

    Position = UDim2.fromScale(0.5,0.5),

    Size = UDim2.new(1,40,1,40),

    BackgroundTransparency = 1,

    Image = "rbxassetid://5028857084",

    ImageColor3 = CONFIG.Red,

    ImageTransparency = 0.75,

    ZIndex = 199,
})

--========================================================--
-- MINIMIZE STATE
--========================================================--

local Minimized = false
local LastPosition = MainFrame.Position

local function Minimize()

    if Minimized then
        return
    end

    Minimized = true

    LastPosition = MainFrame.Position

    Tween(MainFrame,0.35,{
        Size = UDim2.fromOffset(920,570),
        BackgroundTransparency = 1,
    })

    task.wait(0.2)

    MainFrame.Visible = false
    FloatingButton.Visible = true

    FloatingButton.Size = UDim2.fromOffset(0,0)

    Tween(FloatingButton,0.3,{
        Size = UDim2.fromOffset(60,60)
    })

end

local function Restore()

    if not Minimized then
        return
    end

    Minimized = false

    Tween(FloatingButton,0.2,{
        Size = UDim2.fromOffset(0,0)
    })

    task.wait(0.2)

    FloatingButton.Visible = false

    MainFrame.Visible = true

    MainFrame.Size = UDim2.fromOffset(0,0)
    MainFrame.BackgroundTransparency = 1

    Tween(MainFrame,0.35,{
        Size = UDim2.fromOffset(920,570),
        BackgroundTransparency = 0,
    })

    MainFrame.Position = LastPosition

end

MinimizeButton.MouseButton1Click:Connect(Minimize)

FloatingButton.MouseButton1Click:Connect(Restore)

--========================================================--
-- DRAG SYSTEM
--========================================================--

local Dragging = false
local DragStart
local StartPosition

Header.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        Dragging = true

        DragStart = input.Position
        StartPosition = MainFrame.Position

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then
                Dragging = false
            end

        end)

    end

end)

--========================================================--
-- CONTINUE DRAG SYSTEM
--========================================================--

UserInputService.InputChanged:Connect(function(input)

    if not Dragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then

        local Delta = input.Position - DragStart

        MainFrame.Position = UDim2.new(
            StartPosition.X.Scale,
            StartPosition.X.Offset + Delta.X,

            StartPosition.Y.Scale,
            StartPosition.Y.Offset + Delta.Y
        )

    end

end)

--========================================================--
-- TAB SYSTEM
--========================================================--

local function SetTab(name, icon)

    Title.Text = icon .. "  " .. name

    for _, data in ipairs(TabButtons) do

        if data.Name == name then

            Tween(data.Button, 0.2, {
                BackgroundColor3 = Color3.fromRGB(100, 5, 20)
            })

        else

            Tween(data.Button, 0.2, {
                BackgroundColor3 = CONFIG.Sidebar
            })

        end

    end

end

--========================================================--
-- CREATE SIDEBAR BUTTONS
--========================================================--

for index, data in ipairs(Tabs) do

    local icon = data[1]
    local name = data[2]

    local Button = New("TextButton", {
        Parent = TabContainer,

        Size = UDim2.new(1, 0, 0, 45),

        BackgroundColor3 = CONFIG.Sidebar,

        BorderSizePixel = 0,

        Text = "",

        AutoButtonColor = false,

        LayoutOrder = index,

        ZIndex = 20,
    })

    Corner(Button, 10)

    local Icon = New("TextLabel", {
        Parent = Button,

        Position = UDim2.fromOffset(15, 0),

        Size = UDim2.fromOffset(25, 45),

        BackgroundTransparency = 1,

        Text = icon,

        TextColor3 = CONFIG.Text,

        Font = Enum.Font.GothamBold,

        TextSize = 17,

        ZIndex = 21,
    })

    local Label = New("TextLabel", {
        Parent = Button,

        Position = UDim2.fromOffset(50, 0),

        Size = UDim2.new(1, -60, 1, 0),

        BackgroundTransparency = 1,

        Text = name,

        TextColor3 = CONFIG.Text,

        Font = Enum.Font.GothamMedium,

        TextSize = 13,

        TextXAlignment = Enum.TextXAlignment.Left,

        ZIndex = 21,
    })

    table.insert(TabButtons, {
        Name = name,
        Button = Button
    })

    Button.MouseButton1Click:Connect(function()

        SetTab(name, icon)

        Notify(
            "IZZ HUB",
            name .. " dibuka."
        )

    end)

    Button.MouseEnter:Connect(function()

        Tween(Button, 0.15, {
            BackgroundColor3 = Color3.fromRGB(25, 25, 32)
        })

    end)

    Button.MouseLeave:Connect(function()

        if name ~= string.gsub(Title.Text, "^[^%s]+%s+", "") then

            Tween(Button, 0.15, {
                BackgroundColor3 = CONFIG.Sidebar
            })

        end

    end)

end

--========================================================--
-- SIDEBAR STATUS
--========================================================--

local Status = New("TextLabel", {
    Parent = Sidebar,

    Position = UDim2.new(0, 25, 1, -65),

    Size = UDim2.new(1, -40, 0, 45),

    BackgroundTransparency = 1,

    Text = "●  Loader Ready\n    v2.0.0",

    TextColor3 = CONFIG.Muted,

    Font = Enum.Font.Gotham,

    TextSize = 10,

    TextXAlignment = Enum.TextXAlignment.Left,

    TextYAlignment = Enum.TextYAlignment.Center,

    ZIndex = 20,
})

--========================================================--
-- SEARCH SYSTEM
--========================================================--

SearchBox:GetPropertyChangedSignal("Text"):Connect(function()

    local query = string.lower(SearchBox.Text)

    for _, item in ipairs(ScriptItems) do

        local found =
            query == ""
            or string.find(
                string.lower(item.Name),
                query,
                1,
                true
            )

        item.Frame.Visible = found

    end

end)

--========================================================--
-- RESPONSIVE LAYOUT
--========================================================--

local function UpdateLayout()

    local camera = workspace.CurrentCamera

    if not camera then
        return
    end

    local width = camera.ViewportSize.X

    -- MOBILE
    if width < 600 then

        Sidebar.Size = UDim2.new(0, 150, 1, 0)

        Content.Position = UDim2.fromOffset(150, 0)

        Content.Size = UDim2.new(1, -150, 1, 0)

        SearchBox.Visible = false

        Title.TextSize = 16

        Logo.TextSize = 17

        LogoAccent.Visible = false

        for _, data in ipairs(TabButtons) do

            data.Button.Size =
                UDim2.new(1, 0, 0, 40)

        end

    -- TABLET / PC
    else

        Sidebar.Size = UDim2.new(0, 230, 1, 0)

        Content.Position = UDim2.fromOffset(230, 0)

        Content.Size = UDim2.new(1, -230, 1, 0)

        SearchBox.Visible = true

        Title.TextSize = 20

        Logo.TextSize = 22

        LogoAccent.Visible = true

        for _, data in ipairs(TabButtons) do

            data.Button.Size =
                UDim2.new(1, 0, 0, 45)

        end

    end

end

UpdateLayout()

workspace.CurrentCamera:GetPropertyChangedSignal(
    "ViewportSize"
):Connect(UpdateLayout)

--========================================================--
-- FLOATING BUTTON DRAG
--========================================================--

local FloatingDragging = false
local FloatingDragStart
local FloatingStartPosition

FloatingButton.InputBegan:Connect(function(input)

    if input.UserInputType == Enum.UserInputType.MouseButton1
    or input.UserInputType == Enum.UserInputType.Touch then

        FloatingDragging = true

        FloatingDragStart = input.Position
        FloatingStartPosition = FloatingButton.Position

        input.Changed:Connect(function()

            if input.UserInputState == Enum.UserInputState.End then

                FloatingDragging = false

            end

        end)

    end

end)

UserInputService.InputChanged:Connect(function(input)

    if not FloatingDragging then
        return
    end

    if input.UserInputType == Enum.UserInputType.MouseMovement
    or input.UserInputType == Enum.UserInputType.Touch then

        local Delta =
            input.Position - FloatingDragStart

        FloatingButton.Position = UDim2.new(

            FloatingStartPosition.X.Scale,

            FloatingStartPosition.X.Offset + Delta.X,

            FloatingStartPosition.Y.Scale,

            FloatingStartPosition.Y.Offset + Delta.Y

        )

    end

end)

--========================================================--
-- FLOATING BUTTON HOVER
--========================================================--

FloatingButton.MouseEnter:Connect(function()

    Tween(FloatingButton, 0.2, {
        BackgroundColor3 = Color3.fromRGB(25, 5, 12)
    })

    Tween(FloatingButton, 0.2, {
        Size = UDim2.fromOffset(66, 66)
    })

end)

FloatingButton.MouseLeave:Connect(function()

    Tween(FloatingButton, 0.2, {
        BackgroundColor3 = Color3.fromRGB(8, 8, 12)
    })

    Tween(FloatingButton, 0.2, {
        Size = UDim2.fromOffset(60, 60)
    })

end)

--========================================================--
-- MINIMIZE BUTTON HOVER
--========================================================--

MinimizeButton.MouseEnter:Connect(function()

    Tween(MinimizeButton, 0.15, {
        BackgroundColor3 = Color3.fromRGB(40, 5, 12)
    })

end)

MinimizeButton.MouseLeave:Connect(function()

    Tween(MinimizeButton, 0.15, {
        BackgroundColor3 = CONFIG.Card
    })

end)

--========================================================--
-- MINIMIZE
--========================================================--

local Minimized = false
local LastPosition = MainFrame.Position

local function Minimize()

    if Minimized then
        return
    end

    Minimized = true

    LastPosition = MainFrame.Position

    -- shrink animation
    Tween(MainFrame, 0.25, {
        Size = UDim2.fromOffset(700, 430),
        BackgroundTransparency = 1
    })

    task.wait(0.18)

    MainFrame.Visible = false

    FloatingButton.Visible = true

    FloatingButton.Size =
        UDim2.fromOffset(0, 0)

    Tween(FloatingButton, 0.35, {
        Size = UDim2.fromOffset(60, 60)
    })

end

--========================================================--
-- RESTORE
--========================================================--

local function Restore()

    if not Minimized then
        return
    end

    Minimized = false

    Tween(FloatingButton, 0.2, {
        Size = UDim2.fromOffset(0, 0)
    })

    task.wait(0.18)

    FloatingButton.Visible = false

    MainFrame.Visible = true

    MainFrame.Position = LastPosition

    MainFrame.Size =
        UDim2.fromOffset(700, 430)

    MainFrame.BackgroundTransparency = 1

    Tween(MainFrame, 0.35, {
        Size = UDim2.fromOffset(920, 570),

        BackgroundTransparency = 0
    })

end

--========================================================--
-- BUTTON CONNECTION
--========================================================--

MinimizeButton.MouseButton1Click:Connect(function()

    Minimize()

end)

FloatingButton.MouseButton1Click:Connect(function()

    Restore()

end)

--========================================================--
-- INITIAL TAB
--========================================================--

SetTab("Home", "⌂")

--========================================================--
-- OPEN ANIMATION
--========================================================--

MainFrame.Size =
    UDim2.fromOffset(0, 0)

MainFrame.BackgroundTransparency = 1

Tween(MainFrame, 0.45, {

    Size = UDim2.fromOffset(920, 570),

    BackgroundTransparency = 0

})

--========================================================--
-- LOADER NOTIFICATION
--========================================================--

task.wait(0.45)

Notify(
    "IZZ HUB",
    "Loader Ready • v2.0.0"
)

--========================================================--
-- DONE
--========================================================--
