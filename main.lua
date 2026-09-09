--[[
    ============================================================
    MODERN GUI LIBRARY - Lua (Roblox LocalScript)
    ============================================================
    Ciri-ciri:
    - Tampilan moden (dark theme, corner radius, gradient, shadow)
    - Responsif (auto scale ikut saiz skrin)
    - Toggle button untuk buka/tutup menu
    - Butang Minimize (kecilkan jadi bar kecil)
    - Butang Close (tutup terus GUI)
    - Draggable (boleh drag window & toggle button)

    Cara pakai:
    1. Letak script ni dalam StarterPlayerScripts sebagai LocalScript
    2. Run. Toggle button (bulat) akan muncul di skrin.
    3. Klik toggle button untuk buka/tutup menu utama.
    ============================================================
]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ============================================================
-- KONFIGURASI WARNA & TEMA
-- ============================================================
local Theme = {
    Background  = Color3.fromRGB(24, 24, 28),
    Header      = Color3.fromRGB(32, 32, 38),
    Accent      = Color3.fromRGB(88, 101, 242),   -- biru/ungu moden
    AccentHover = Color3.fromRGB(108, 121, 255),
    TextMain    = Color3.fromRGB(235, 235, 240),
    TextSub     = Color3.fromRGB(160, 160, 170),
    Danger      = Color3.fromRGB(237, 66, 69),
    DangerHover = Color3.fromRGB(255, 90, 93),
    Stroke      = Color3.fromRGB(50, 50, 58),
}

-- ============================================================
-- UTIL
-- ============================================================
local function create(class, props)
    local inst = Instance.new(class)
    for prop, value in pairs(props) do
        inst[prop] = value
    end
    return inst
end

local function tween(obj, props, duration, style)
    local info = TweenInfo.new(duration or 0.25, style or Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
    local t = TweenService:Create(obj, info, props)
    t:Play()
    return t
end

-- ============================================================
-- ROOT ScreenGui
-- ============================================================
local ScreenGui = create("ScreenGui", {
    Name = "ModernGUI",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    Parent = playerGui,
})

-- ============================================================
-- TOGGLE BUTTON (bulat, floating, buka/tutup menu)
-- ============================================================
local ToggleButton = create("TextButton", {
    Name = "ToggleButton",
    Parent = ScreenGui,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0, 60, 0, 60),
    Size = UDim2.new(0, 50, 0, 50),
    BackgroundColor3 = Theme.Accent,
    Text = "☰",
    Font = Enum.Font.GothamBold,
    TextSize = 22,
    TextColor3 = Theme.TextMain,
    AutoButtonColor = false,
    ZIndex = 10,
})
create("UICorner", { Parent = ToggleButton, CornerRadius = UDim.new(1, 0) })
create("UIStroke", { Parent = ToggleButton, Color = Theme.Stroke, Thickness = 1.5 })

-- ============================================================
-- MAIN WINDOW FRAME
-- ============================================================
local MainFrame = create("Frame", {
    Name = "MainFrame",
    Parent = ScreenGui,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    Size = UDim2.new(0, 420, 0, 320),
    BackgroundColor3 = Theme.Background,
    ClipsDescendants = true,
    Visible = false, -- mula tertutup
})
create("UICorner", { Parent = MainFrame, CornerRadius = UDim.new(0, 14) })
create("UIStroke", { Parent = MainFrame, Color = Theme.Stroke, Thickness = 1 })

-- Responsif: had min/max saiz
create("UISizeConstraint", {
    Parent = MainFrame,
    MinSize = Vector2.new(300, 220),
    MaxSize = Vector2.new(700, 550),
})

-- Auto-scale ikut saiz skrin (desktop/telefon)
local function updateResponsiveSize()
    local viewport = workspace.CurrentCamera.ViewportSize
    local scaleFactor = math.clamp(viewport.X / 1280, 0.55, 1.15)
    local w = 420 * scaleFactor
    local h = 320 * scaleFactor
    MainFrame.Size = UDim2.new(0, w, 0, h)
end
updateResponsiveSize()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateResponsiveSize)

-- Shadow ringan
create("ImageLabel", {
    Name = "Shadow",
    Parent = MainFrame,
    AnchorPoint = Vector2.new(0.5, 0.5),
    Position = UDim2.new(0.5, 0, 0.5, 6),
    Size = UDim2.new(1, 40, 1, 40),
    BackgroundTransparency = 1,
    Image = "rbxassetid://1316045217",
    ImageColor3 = Color3.new(0, 0, 0),
    ImageTransparency = 0.55,
    ScaleType = Enum.ScaleType.Slice,
    SliceCenter = Rect.new(10, 10, 118, 118),
    ZIndex = -1,
})

-- ============================================================
-- HEADER (title bar) - boleh drag, ada minimize & close
-- ============================================================
local Header = create("Frame", {
    Name = "Header",
    Parent = MainFrame,
    Size = UDim2.new(1, 0, 0, 46),
    BackgroundColor3 = Theme.Header,
})
create("UICorner", { Parent = Header, CornerRadius = UDim.new(0, 14) })

-- Patch supaya bawah header tak bulat
create("Frame", {
    Parent = Header,
    Position = UDim2.new(0, 0, 1, -14),
    Size = UDim2.new(1, 0, 0, 14),
    BackgroundColor3 = Theme.Header,
    BorderSizePixel = 0,
    ZIndex = 0,
})

create("TextLabel", {
    Name = "Title",
    Parent = Header,
    Position = UDim2.new(0, 16, 0, 0),
    Size = UDim2.new(1, -140, 1, 0),
    BackgroundTransparency = 1,
    Text = "Modern GUI",
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextColor3 = Theme.TextMain,
    TextXAlignment = Enum.TextXAlignment.Left,
})

-- Butang Minimize
local MinimizeButton = create("TextButton", {
    Name = "MinimizeButton",
    Parent = Header,
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -56, 0.5, 0),
    Size = UDim2.new(0, 32, 0, 32),
    BackgroundColor3 = Theme.Stroke,
    Text = "—",
    Font = Enum.Font.GothamBold,
    TextSize = 16,
    TextColor3 = Theme.TextMain,
    AutoButtonColor = false,
})
create("UICorner", { Parent = MinimizeButton, CornerRadius = UDim.new(0, 8) })

-- Butang Close
local CloseButton = create("TextButton", {
    Name = "CloseButton",
    Parent = Header,
    AnchorPoint = Vector2.new(1, 0.5),
    Position = UDim2.new(1, -14, 0.5, 0),
    Size = UDim2.new(0, 32, 0, 32),
    BackgroundColor3 = Theme.Danger,
    Text = "✕",
    Font = Enum.Font.GothamBold,
    TextSize = 14,
    TextColor3 = Theme.TextMain,
    AutoButtonColor = false,
})
create("UICorner", { Parent = CloseButton, CornerRadius = UDim.new(0, 8) })

-- ============================================================
-- CONTENT AREA (body menu)
-- ============================================================
local Content = create("ScrollingFrame", {
    Name = "Content",
    Parent = MainFrame,
    Position = UDim2.new(0, 0, 0, 46),
    Size = UDim2.new(1, 0, 1, -46),
    BackgroundTransparency = 1,
    ScrollBarThickness = 4,
    ScrollBarImageColor3 = Theme.Accent,
    CanvasSize = UDim2.new(0, 0, 0, 0),
    AutomaticCanvasSize = Enum.AutomaticSize.Y,
})

create("UIPadding", {
    Parent = Content,
    PaddingTop = UDim.new(0, 14),
    PaddingBottom = UDim.new(0, 14),
    PaddingLeft = UDim.new(0, 14),
    PaddingRight = UDim.new(0, 14),
})

create("UIListLayout", {
    Parent = Content,
    Padding = UDim.new(0, 10),
    SortOrder = Enum.SortOrder.LayoutOrder,
})

-- Contoh item menu (ubah/tambah ikut keperluan anda)
local function createMenuButton(text, order)
    local btn = create("TextButton", {
        Name = text .. "Button",
        Parent = Content,
        Size = UDim2.new(1, 0, 0, 40),
        BackgroundColor3 = Theme.Header,
        Text = "",
        AutoButtonColor = false,
        LayoutOrder = order,
    })
    create("UICorner", { Parent = btn, CornerRadius = UDim.new(0, 8) })
    create("UIStroke", { Parent = btn, Color = Theme.Stroke, Thickness = 1 })

    create("TextLabel", {
        Parent = btn,
        Size = UDim2.new(1, -20, 1, 0),
        Position = UDim2.new(0, 16, 0, 0),
        BackgroundTransparency = 1,
        Text = text,
        Font = Enum.Font.Gotham,
        TextSize = 14,
        TextColor3 = Theme.TextMain,
        TextXAlignment = Enum.TextXAlignment.Left,
    })

    btn.MouseEnter:Connect(function()
        tween(btn, { BackgroundColor3 = Theme.Accent }, 0.15)
    end)
    btn.MouseLeave:Connect(function()
        tween(btn, { BackgroundColor3 = Theme.Header }, 0.15)
    end)

    return btn
end

createMenuButton("🏠  Dashboard", 1)
createMenuButton("⚙️  Settings", 2)
createMenuButton("👤  Profile", 3)
createMenuButton("📦  Inventory", 4)
createMenuButton("ℹ️  About", 5)

-- ============================================================
-- LOGIC: TOGGLE / MINIMIZE / CLOSE
-- ============================================================
local isOpen = false
local isMinimized = false
local fullSize = MainFrame.Size

local function openMenu()
    fullSize = MainFrame.Size
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(fullSize.X.Scale, fullSize.X.Offset, 0, 0)
    tween(MainFrame, { Size = fullSize }, 0.28, Enum.EasingStyle.Back)
    isOpen = true
end

local function closeMenu()
    local t = tween(MainFrame, { Size = UDim2.new(fullSize.X.Scale, fullSize.X.Offset, 0, 0) }, 0.22)
    t.Completed:Connect(function()
        MainFrame.Visible = false
    end)
    isOpen = false
end

ToggleButton.MouseButton1Click:Connect(function()
    if isOpen then
        closeMenu()
    else
        openMenu()
    end
end)

-- Minimize: kecilkan jadi bar header sahaja
MinimizeButton.MouseButton1Click:Connect(function()
    isMinimized = not isMinimized
    if isMinimized then
        tween(MainFrame, { Size = UDim2.new(fullSize.X.Scale, fullSize.X.Offset, 0, 46) }, 0.25)
        Content.Visible = false
        MinimizeButton.Text = "▢"
    else
        tween(MainFrame, { Size = fullSize }, 0.25)
        Content.Visible = true
        MinimizeButton.Text = "—"
    end
end)

-- Close: tutup GUI (boleh dibuka semula guna ToggleButton)
CloseButton.MouseButton1Click:Connect(function()
    closeMenu()
    isMinimized = false
    Content.Visible = true
    MinimizeButton.Text = "—"
end)

-- Hover effects
MinimizeButton.MouseEnter:Connect(function()
    tween(MinimizeButton, { BackgroundColor3 = Theme.AccentHover }, 0.15)
end)
MinimizeButton.MouseLeave:Connect(function()
    tween(MinimizeButton, { BackgroundColor3 = Theme.Stroke }, 0.15)
end)

CloseButton.MouseEnter:Connect(function()
    tween(CloseButton, { BackgroundColor3 = Theme.DangerHover }, 0.15)
end)
CloseButton.MouseLeave:Connect(function()
    tween(CloseButton, { BackgroundColor3 = Theme.Danger }, 0.15)
end)

ToggleButton.MouseEnter:Connect(function()
    tween(ToggleButton, { BackgroundColor3 = Theme.AccentHover }, 0.15)
end)
ToggleButton.MouseLeave:Connect(function()
    tween(ToggleButton, { BackgroundColor3 = Theme.Accent }, 0.15)
end)

-- ============================================================
-- DRAGGABLE WINDOW (drag guna Header)
-- ============================================================
local dragging = false
local dragInput, mousePos, framePos

Header.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        mousePos = input.Position
        framePos = MainFrame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Header.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - mousePos
        MainFrame.Position = UDim2.new(
            framePos.X.Scale, framePos.X.Offset + delta.X,
            framePos.Y.Scale, framePos.Y.Offset + delta.Y
        )
    end
end)

-- ============================================================
-- DRAGGABLE TOGGLE BUTTON
-- ============================================================
local toggleDragging = false
local toggleDragInput, toggleMousePos, togglePos

ToggleButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        toggleDragging = true
        toggleMousePos = input.Position
        togglePos = ToggleButton.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                toggleDragging = false
            end
        end)
    end
end)

ToggleButton.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch then
        toggleDragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if input == toggleDragInput and toggleDragging then
        local delta = input.Position - toggleMousePos
        ToggleButton.Position = UDim2.new(
            togglePos.X.Scale, togglePos.X.Offset + delta.X,
            togglePos.Y.Scale, togglePos.Y.Offset + delta.Y
        )
    end
end)

print("[ModernGUI] Loaded successfully. Klik butang bulat (☰) untuk buka menu.")
