--[[
    IZZ HUB - LOADER UI
    Platform: Roblox Lua (LocalScript)
    Style: Dark / Neon Red / Futuristic
    Features: Responsive, Drag, Minimize, Search, Animations
]]

-- ============================================================
--                      CONFIG & SERVICES
-- ============================================================

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local Player = Players.LocalPlayer
local Camera = workspace.CurrentCamera

-- Colors
local COLORS = {
    Background = Color3.fromHex("#050507"),
    Panel = Color3.fromHex("#0B0B10"),
    Secondary = Color3.fromHex("#111118"),
    Border = Color3.fromHex("#2A2A32"),
    Accent = Color3.fromHex("#FF003C"),
    AccentGlow = Color3.fromHex("#FF1744"),
    Text = Color3.fromHex("#FFFFFF"),
    Muted = Color3.fromHex("#8A8A95"),
    Success = Color3.fromHex("#00FF66"),
    CardBg = Color3.fromHex("#0C0C12")
}

-- Easing
local TWEEN_INFO = TweenInfo.new(0.25, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
local TWEEN_INFO_FAST = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

-- Script Data
local SCRIPTS_DATA = {
    {Name = "Hitbox Modifier", Desc = "Memperbesar hitbox karakter.", Icon = "🎯"},
    {Name = "Killer No Cooldown", Desc = "Skill killer tanpa cooldown.", Icon = "☠"},
    {Name = "Infinite Lunge", Desc = "Lunge tanpa batas.", Icon = "🏃"},
    {Name = "Aimlock M2 Skill", Desc = "Lock target secara otomatis.", Icon = "🎯"},
    {Name = "No Cooldown", Desc = "Skill tanpa cooldown.", Icon = "👁"},
    {Name = "Speed Hack", Desc = "Meningkatkan kecepatan jalan.", Icon = "⚡"},
    {Name = "Fly Mode", Desc = "Terbang bebas di map.", Icon = "🪽"},
    {Name = "ESP Visuals", Desc = "Melihat pemain melalui dinding.", Icon = "👓"},
    {Name = "Auto Farm", Desc = "Farm otomatis tanpa henti.", Icon = "🚜"},
    {Name = "Teleport All", Desc = "Teleport semua pemain ke kamu.", Icon = "🌀"}
}

-- ============================================================
--                      UTILITIES
-- ============================================================

local function Create(Class, Properties)
    local Obj = Instance.new(Class)
    for Prop, Value in pairs(Properties) do
        if Prop ~= "Parent" then
            Obj[Prop] = Value
        end
    end
    if Properties.Parent then
        Obj.Parent = Properties.Parent
    end
    return Obj
end

local function AddCorner(Parent, Radius)
    return Create("UICorner", {CornerRadius = UDim.new(0, Radius), Parent = Parent})
end

local function AddStroke(Parent, Color, Thickness, Transparency)
    return Create("UIStroke", {
        Color = Color,
        Thickness = Thickness or 1,
        Transparency = Transparency or 0,
        ApplyStrokeMode = Enum.ApplyStrokeMode.Border,
        Parent = Parent
    })
end

local function AddPadding(Parent, Padding)
    return Create("UIPadding", {
        PaddingTop = UDim.new(0, Padding),
        PaddingBottom = UDim.new(0, Padding),
        PaddingLeft = UDim.new(0, Padding),
        PaddingRight = UDim.new(0, Padding),
        Parent = Parent
    })
end

-- ============================================================
--                      RESPONSIVE SYSTEM
-- ============================================================

local ScreenGui = Create("ScreenGui", {
    Name = "IZZ_HUB_LOADER",
    ResetOnSpawn = false,
    ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
    IgnoreGuiInset = true
})

-- Try to parent to CoreGui for better persistence, fallback to PlayerGui
pcall(function()
    ScreenGui.Parent = CoreGui
end)
if not ScreenGui.Parent then
    ScreenGui.Parent = Player:WaitForChild("PlayerGui")
end

local ViewportSize = Camera.ViewportSize
local IsMobile = UserInputService.TouchEnabled and not UserInputService.KeyboardEnabled
local IsTablet = ViewportSize.X >= 600 and ViewportSize.X < 900

local function GetScaleConfig()
    local vw = Camera.ViewportSize.X
    local vh = Camera.ViewportSize.Y
    
    if vw < 600 then -- Mobile
        return {
            Type = "Mobile",
            MainSize = UDim2.new(0.92, 0, 0.75, 0),
            SidebarWidth = UDim.new(0, 130),
            HeaderHeight = UDim.new(0, 50),
            TextScale = 0.85,
            CardHeight = 55,
            CompactWidth = 280
        }
    elseif vw < 900 then -- Tablet
        return {
            Type = "Tablet",
            MainSize = UDim2.new(0, 750, 0, 450),
            SidebarWidth = UDim.new(0, 180),
            HeaderHeight = UDim.new(0, 55),
            TextScale = 0.95,
            CardHeight = 55,
            CompactWidth = 380
        }
    else -- Desktop
        return {
            Type = "Desktop",
            MainSize = UDim2.new(0, 900, 0, 520),
            SidebarWidth = UDim.new(0, 220),
            HeaderHeight = UDim.new(0, 60),
            TextScale = 1,
            CardHeight = 60,
            CompactWidth = 420
        }
    end
end

local Config = GetScaleConfig()

-- ============================================================
--                      LOADING SCREEN
-- ============================================================

local LoadingFrame = Create("Frame", {
    Name = "LoadingFrame",
    Size = UDim2.new(0, 300, 0, 180),
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0,
    Parent = ScreenGui
})
AddCorner(LoadingFrame, 16)
AddStroke(LoadingFrame, COLORS.Accent, 2)

local LoadingLogo = Create("TextLabel", {
    Name = "Logo",
    Size = UDim2.new(1, 0, 0, 50),
    Position = UDim2.new(0, 0, 0, 20),
    BackgroundTransparency = 1,
    Text = "👑 IZZ HUB",
    Font = Enum.Font.GothamBold,
    TextSize = 24,
    TextColor3 = COLORS.Accent,
    Parent = LoadingFrame
})

local LoadingText = Create("TextLabel", {
    Name = "StatusText",
    Size = UDim2.new(1, 0, 0, 30),
    Position = UDim2.new(0, 0, 0, 80),
    BackgroundTransparency = 1,
    Text = "Initializing...",
    Font = Enum.Font.Gotham,
    TextSize = 14,
    TextColor3 = COLORS.Muted,
    Parent = LoadingFrame
})

local ProgressBarBg = Create("Frame", {
    Name = "ProgressBg",
    Size = UDim2.new(0.8, 0, 0, 4),
    Position = UDim2.new(0.1, 0, 0, 130),
    BackgroundColor3 = COLORS.Secondary,
    BorderSizePixel = 0,
    Parent = LoadingFrame
})
AddCorner(ProgressBarBg, 2)

local ProgressBarFill = Create("Frame", {
    Name = "ProgressFill",
    Size = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = COLORS.Accent,
    BorderSizePixel = 0,
    Parent = ProgressBarBg
})
AddCorner(ProgressBarFill, 2)

-- Loading Sequence
task.spawn(function()
    local steps = {
        {Text = "Initializing...", Progress = 0.1},
        {Text = "Loading UI...", Progress = 0.3},
        {Text = "Checking environment...", Progress = 0.6},
        {Text = "Loading modules...", Progress = 0.8},
        {Text = "IZZHUB Ready ✓", Progress = 1.0}
    }

    for _, step in ipairs(steps) do
        LoadingText.Text = step.Text
        TweenService:Create(ProgressBarFill, TweenInfo.new(0.3), {Size = UDim2.new(step.Progress, 0, 1, 0)}):Play()
        task.wait(0.4)
    end

    task.wait(0.5)
    
    -- Fade out loading
    local fadeOut = TweenService:Create(LoadingFrame, TweenInfo.new(0.3), {BackgroundTransparency = 1})
    for _, child in ipairs(LoadingFrame:GetDescendants()) do
        if child:IsA("TextLabel") or child:IsA("Frame") or child:IsA("UIStroke") then
            if child:IsA("TextLabel") then
                TweenService:Create(child, TweenInfo.new(0.3), {TextTransparency = 1}):Play()
            elseif child:IsA("UIStroke") then
                TweenService:Create(child, TweenInfo.new(0.3), {Transparency = 1}):Play()
            elseif child.Name == "ProgressFill" or child.Name == "ProgressBg" then
                TweenService:Create(child, TweenInfo.new(0.3), {BackgroundTransparency = 1}):Play()
            end
        end
    end
    fadeOut:Play()
    fadeOut.Completed:Wait()
    LoadingFrame:Destroy()
    
    -- Show Main UI
    MainUI_Open()
end)

-- ============================================================
--                      MAIN UI STRUCTURE
-- ============================================================

local MainFrame = Create("Frame", {
    Name = "MainFrame",
    Size = Config.MainSize,
    Position = UDim2.new(0.5, 0, 0.5, 0),
    AnchorPoint = Vector2.new(0.5, 0.5),
    BackgroundColor3 = COLORS.Background,
    BorderSizePixel = 0,
    Visible = false, -- Hidden until loaded
    ClipsDescendants = true,
    Parent = ScreenGui
})
AddCorner(MainFrame, 18)

-- Outer Glow / Border
local MainStroke = AddStroke(MainFrame, COLORS.Accent, 1.5)
MainStroke.Transparency = 0.3

-- Shadow/Glow Effect (Simulated with a larger frame behind)
local GlowFrame = Create("Frame", {
    Name = "Glow",
    Size = UDim2.new(1, 10, 1, 10),
    Position = UDim2.new(0, -5, 0, -5),
    BackgroundTransparency = 1,
    ZIndex = 0,
    Parent = MainFrame
})
-- Note: Real glow is hard without assets, using stroke is safer for performance.

-- ======================== HEADER ========================

local Header = Create("Frame", {
    Name = "Header",
    Size = UDim2.new(1, 0, Config.HeaderHeight.Scale, Config.HeaderHeight.Offset),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0,
    ZIndex = 2,
    Parent = MainFrame
})

local HeaderLine = Create("Frame", {
    Name = "Line",
    Size = UDim2.new(1, 0, 0, 1),
    Position = UDim2.new(0, 0, 1, 0),
    BackgroundColor3 = COLORS.Border,
    BorderSizePixel = 0,
    Parent = Header
})

local LogoContainer = Create("Frame", {
    Name = "LogoContainer",
    Size = UDim2.new(0, 200, 1, 0),
    BackgroundTransparency = 1,
    Parent = Header
})
AddPadding(LogoContainer, 15)

local LogoIcon = Create("TextLabel", {
    Name = "Icon",
    Size = UDim2.new(0, 30, 1, 0),
    BackgroundTransparency = 1,
    Text = "👑",
    Font = Enum.Font.GothamBold,
    TextSize = 20 * Config.TextScale,
    TextColor3 = COLORS.Accent,
    Parent = LogoContainer,
    LayoutOrder = 1
})

local LogoText = Create("TextLabel", {
    Name = "Text",
    Size = UDim2.new(0, 100, 0.5, 0),
    Position = UDim2.new(0, 35, 0.1, 0),
    BackgroundTransparency = 1,
    Text = "IZZ HUB",
    Font = Enum.Font.GothamBold,
    TextSize = 18 * Config.TextScale,
    TextColor3 = COLORS.Text,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = LogoContainer,
    LayoutOrder = 2
})

local LogoSub = Create("TextLabel", {
    Name = "Sub",
    Size = UDim2.new(0, 150, 0.5, 0),
    Position = UDim2.new(0, 35, 0.5, 0),
    BackgroundTransparency = 1,
    Text = "Better • Faster • Stronger",
    Font = Enum.Font.Gotham,
    TextSize = 10 * Config.TextScale,
    TextColor3 = COLORS.Muted,
    TextXAlignment = Enum.TextXAlignment.Left,
    Parent = LogoContainer,
    LayoutOrder = 3
})

-- Use UIListLayout for LogoContainer to align items horizontally? 
-- Actually manual positioning is fine for header logo, but let's use ListLayout for cleaner code if needed.
-- Re-doing LogoContainer with ListLayout for robustness
LogoText.Position = UDim2.new(0,0,0,0)
LogoSub.Position = UDim2.new(0,0,0,0)
LogoIcon.Position = UDim2.new(0,0,0,0)

local LogoList = Create("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 8),
    Parent = LogoContainer
})
-- Adjust sizes for list layout
LogoIcon.Size = UDim2.new(0, 24, 0, 24)
LogoText.Size = UDim2.new(0, 80, 0, 20)
LogoSub.Size = UDim2.new(0, 120, 0, 15)
-- Wait, LogoText and Sub need to be stacked vertically next to icon.
-- Let's wrap text in a frame.

LogoText.Parent = nil
LogoSub.Parent = nil

local TextWrapper = Create("Frame", {
    Name = "TextWrapper",
    Size = UDim2.new(0, 150, 1, 0),
    BackgroundTransparency = 1,
    Parent = LogoContainer,
    LayoutOrder = 2
})

local TextList = Create("UIListLayout", {
    FillDirection = Enum.FillDirection.Vertical,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 2),
    Parent = TextWrapper
})

LogoText.Parent = TextWrapper
LogoSub.Parent = TextWrapper
LogoText.Size = UDim2.new(1, 0, 0, 18)
LogoSub.Size = UDim2.new(1, 0, 0, 12)


-- Header Controls (Right)
local Controls = Create("Frame", {
    Name = "Controls",
    Size = UDim2.new(0, 150, 1, 0),
    Position = UDim2.new(1, -150, 0, 0),
    BackgroundTransparency = 1,
    Parent = Header
})

local ControlsList = Create("UIListLayout", {
    FillDirection = Enum.FillDirection.Horizontal,
    HorizontalAlignment = Enum.HorizontalAlignment.Right,
    VerticalAlignment = Enum.VerticalAlignment.Center,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 10),
    Parent = Controls
})

local function CreateHeaderButton(Name, Text, Color)
    local Btn = Create("TextButton", {
        Name = Name,
        Size = UDim2.new(0, 32, 0, 32),
        BackgroundColor3 = COLORS.Secondary,
        Text = Text,
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        TextColor3 = Color or COLORS.Muted,
        AutoButtonColor = false,
        Parent = Controls
    })
    AddCorner(Btn, 8)
    AddStroke(Btn, COLORS.Border, 1)
    
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TWEEN_INFO_FAST, {BackgroundColor3 = COLORS.Accent, TextColor3 = COLORS.Text}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TWEEN_INFO_FAST, {BackgroundColor3 = COLORS.Secondary, TextColor3 = Color or COLORS.Muted}):Play()
    end)
    return Btn
end

local MinimizeBtn = CreateHeaderButton("Minimize", "-", COLORS.Muted)
local CloseBtn = CreateHeaderButton("Close", "✕", COLORS.Accent)

-- ======================== BODY (Sidebar + Content) ========================

local Body = Create("Frame", {
    Name = "Body",
    Size = UDim2.new(1, 0, 1, -Config.HeaderHeight.Offset),
    Position = UDim2.new(0, 0, 0, Config.HeaderHeight.Offset),
    BackgroundTransparency = 1,
    Parent = MainFrame
})

-- SIDEBAR
local Sidebar = Create("Frame", {
    Name = "Sidebar",
    Size = UDim2.new(Config.SidebarWidth.Scale, Config.SidebarWidth.Offset, 1, 0),
    Position = UDim2.new(0, 0, 0, 0),
    BackgroundColor3 = COLORS.Panel,
    BorderSizePixel = 0,
    Parent = Body
})

local SidebarLine = Create("Frame", {
    Name = "Line",
    Size = UDim2.new(0, 1, 1, 0),
    Position = UDim2.new(1, 0, 0, 0),
    BackgroundColor3 = COLORS.Border,
    BorderSizePixel = 0,
    Parent = Sidebar
})

local NavContainer = Create("Frame", {
    Name = "NavContainer",
    Size = UDim2.new(1, 0, 1, -60), -- Leave space for status
    Position = UDim2.new(0, 0, 0, 10),
    BackgroundTransparency = 1,
    Parent = Sidebar
})

local NavList = Create("UIListLayout", {
    FillDirection = Enum.FillDirection.Vertical,
    SortOrder = Enum.SortOrder.LayoutOrder,
    Padding = UDim.new(0, 5),
    Parent = NavContainer
})
AddPadding(NavContainer, 10)

local Tabs = {
    {Name = "Home", Icon = "🏠"},
    {Name = "Scripts", Icon = "⚡"},
    {Name = "Local Player", Icon = "👤"},
    {Name = "Teleport", Icon = "📍"},
    {Name = "Misc", Icon = "⚙"},
    {Name = "Settings", Icon = "☷"}
}

local TabButtons = {}
local CurrentTab = "Scripts" -- Default active

local function CreateTab(Data, Index)
    local Btn = Create("TextButton", {
        Name = Data.Name,
        Size = UDim2.new(1, -10, 0, 40),
        BackgroundColor3 = COLORS.Background,
        BackgroundTransparency = 1,
        Text = "",
        AutoButtonColor = false,
        Parent = NavContainer
    })
    AddCorner(Btn, 8)
    
    local Icon = Create("TextLabel", {
        Name = "Icon",
        Size = UDim2.new(0, 30, 1, 0),
        Position = UDim2.new(0, 5, 0, 0),
        BackgroundTransparency = 1,
        Text = Data.Icon,
        Font = Enum.Font.Gotham,
        TextSize = 18 * Config.TextScale,
        TextColor3 = COLORS.Muted,
        Parent = Btn
    })
    
    local Label = Create("TextLabel", {
        Name = "Label",
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, 40, 0, 0),
        BackgroundTransparency = 1,
        Text = Data.Name,
        Font = Enum.Font.GothamSemibold,
        TextSize = 14 * Config.TextScale,
        TextColor3 = COLORS.Muted,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = Btn
    })
    
    -- Active State Logic
    local function SetActive(Active)
        if Active then
            TweenService:Create(Btn, TWEEN_INFO, {BackgroundColor3 = Color3.fromHex("#2A000A"), BackgroundTransparency = 0}):Play()
            TweenService:Create(Label, TWEEN_INFO, {TextColor3 = COLORS.Text}):Play()
            TweenService:Create(Icon, TWEEN_INFO, {TextColor3 = COLORS.Accent}):Play()
            -- Add a small accent bar on the left
            local Bar = Btn:FindFirstChild("ActiveBar")
            if not Bar then
                Bar = Create("Frame", {
                    Name = "ActiveBar",
                    Size = UDim2.new(0, 3, 0.6, 0),
                    Position = UDim2.new(0, 0, 0.2, 0),
                    BackgroundColor3 = COLORS.Accent,
                    BorderSizePixel = 0,
                    Parent = Btn
                })
                AddCorner(Bar, 2)
            end
            Bar.Visible = true
        else
            TweenService:Create(Btn, TWEEN_INFO, {BackgroundTransparency = 1}):Play()
            TweenService:Create(Label, TWEEN_INFO, {TextColor3 = COLORS.Muted}):Play()
            TweenService:Create(Icon, TWEEN_INFO, {TextColor3 = COLORS.Muted}):Play()
            local Bar = Btn:FindFirstChild("ActiveBar")
            if Bar then Bar.Visible = false end
        end
    end
    
    Btn.MouseEnter:Connect(function()
        if Btn.Name ~= CurrentTab then
            TweenService:Create(Btn, TWEEN_INFO_FAST, {BackgroundColor3 = COLORS.Secondary, BackgroundTransparency = 0.5}):Play()
            TweenService:Create(Label, TWEEN_INFO_FAST, {TextColor3 = COLORS.Text}):Play()
        end
    end)
    
    Btn.MouseLeave:Connect(function()
        if Btn.Name ~= CurrentTab then
            TweenService:Create(Btn, TWEEN_INFO_FAST, {BackgroundTransparency = 1}):Play()
            TweenService:Create(Label, TWEEN_INFO_FAST, {TextColor3 = COLORS.Muted}):Play()
        end
    end)
    
    Btn.MouseButton1Click:Connect(function()
        CurrentTab = Data.Name
        for _, OtherBtn in pairs(TabButtons) do
            OtherBtn.SetActive(OtherBtn.Button.Name == CurrentTab)
        end
        -- Here you would switch content frames. For this demo, we just log or keep Scripts visible.
        -- If Data.Name == "Scripts" then ShowScripts() else HideScripts() end
    end)
    
    table.insert(TabButtons, {Button = Btn, SetActive = SetActive})
    return Btn
end

for i, tab in ipairs(Tabs) do
    CreateTab(tab, i)
end

-- Set Default Active
task.defer(function()
    for _, tb in pairs(TabButtons) do
        tb.SetActive(tb.Button.Name == CurrentTab)
    end
end)

-- Status Section (Bottom of Sidebar)
local StatusFrame = Create("Frame", {
    Name = "Status",
    Size = UDim2.new(1, -10, 0, 50),
    Position = UDim2.new(0, 5, 1, -55),
    BackgroundTransparency = 1,
    Parent = Sidebar
})

local StatusDot = Create("Frame", {
    Name = "Dot",
    Size = UDim2.new(0, 8, 0, 8),
    Position = UDim2.new(0, 5, 0, 10),
    BackgroundColor3 = COLORS.Success,
    BorderSizePixel = 0,
    Parent = StatusFrame
})
AddCorner(StatusDot, 4)

local StatusLabel = Create("TextLabel", {
    Name = "Label",
    Size = UDim2.new(1, -20, 0, 20),
    Position = UDim2.new(0, 20, 0, 5),
    BackgroundTransparency = 1,
    Text = "Loader Ready",
        Font = Enum.Font.GothamSemibold,
        TextSize = 12 * Config.TextScale,
        TextColor3 = COLORS.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = StatusFrame
    })
    
    local VersionLabel = Create("TextLabel", {
        Name = "Version",
        Size = UDim2.new(1, -20, 0, 15),
        Position = UDim2.new(0, 20, 0, 25),
        BackgroundTransparency = 1,
        Text = "v2.0.0",
        Font = Enum.Font.Gotham,
        TextSize = 10 * Config.TextScale,
        TextColor3 = COLORS.Muted,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = StatusFrame
    })
    
    -- CONTENT AREA
    local Content = Create("Frame", {
        Name = "Content",
        Size = UDim2.new(1, -Config.SidebarWidth.Offset, 1, 0),
        Position = UDim2.new(Config.SidebarWidth.Scale, Config.SidebarWidth.Offset, 0, 0),
        BackgroundTransparency = 1,
        Parent = Body
    })
    AddPadding(Content, 20)
    
    -- Content Header (Title + Search)
    local ContentHeader = Create("Frame", {
        Name = "ContentHeader",
        Size = UDim2.new(1, 0, 0, 60),
        BackgroundTransparency = 1,
        Parent = Content
    })
    
    local Title = Create("TextLabel", {
        Name = "Title",
        Size = UDim2.new(0.5, 0, 0, 30),
        Position = UDim2.new(0, 0, 0, 0),
        BackgroundTransparency = 1,
        Text = "Scripts",
        Font = Enum.Font.GothamBold,
        TextSize = 22 * Config.TextScale,
        TextColor3 = COLORS.Text,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = ContentHeader
    })
    
    local Subtitle = Create("TextLabel", {
        Name = "Subtitle",
        Size = UDim2.new(0.5, 0, 0, 20),
        Position = UDim2.new(0, 0, 0, 30),
        BackgroundTransparency = 1,
        Text = "Pilih script yang ingin kamu gunakan.",
        Font = Enum.Font.Gotham,
        TextSize = 12 * Config.TextScale,
        TextColor3 = COLORS.Muted,
        TextXAlignment = Enum.TextXAlignment.Left,
        Parent = ContentHeader
    })
    
    -- Search Bar
    local SearchContainer = Create("Frame", {
        Name = "SearchContainer",
        Size = UDim2.new(0, 220, 0, 36),
        Position = UDim2.new(1, -220, 0, 10),
        BackgroundColor3 = COLORS.Secondary,
        Parent = ContentHeader
    })
    AddCorner(SearchContainer, 8)
    AddStroke(SearchContainer, COLORS.Border, 1)
    
    local SearchIcon = Create("TextLabel", {
        Name = "Icon",
        Size = UDim2.new(0, 30, 1, 0),
        Position = UDim2.new(0, 5, 0, 0),
        BackgroundTransparency = 1,
        Text = "🔎",
        Font = Enum.Font.Gotham,
        TextSize = 14,
        TextColor3 = COLORS.Muted,
        Parent = SearchContainer
    })
    
    local SearchBox = Create("TextBox", {
        Name = "SearchBox",
        Size = UDim2.new(1, -40, 1, 0),
        Position = UDim2.new(0, 35, 0, 0),
        BackgroundTransparency = 1,
        PlaceholderText = "Cari script...",
        Text = "",
        Font = Enum.Font.Gotham,
        TextSize = 13 * Config.TextScale,
        TextColor3 = COLORS.Text,
        PlaceholderColor3 = COLORS.Muted,
        TextXAlignment = Enum.TextXAlignment.Left,
        ClearTextOnFocus = false,
        Parent = SearchContainer
    })
    
    -- Scripts List Container
    local ScriptsScroll = Create("ScrollingFrame", {
        Name = "ScriptsScroll",
        Size = UDim2.new(1, 0, 1, -70),
        Position = UDim2.new(0, 0, 0, 70),
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        ScrollBarThickness = 4,
        ScrollBarImageColor3 = COLORS.Accent,
        CanvasSize = UDim2.new(0, 0, 0, 0),
        AutomaticCanvasSize = Enum.AutomaticSize.Y,
        Parent = Content
    })
    
    local ScriptsList = Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Vertical,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 8),
        Parent = ScriptsScroll
    })
    
    local NoResultsLabel = Create("TextLabel", {
        Name = "NoResults",
        Size = UDim2.new(1, 0, 0, 50),
        BackgroundTransparency = 1,
        Text = "Tidak ada script ditemukan.",
        Font = Enum.Font.Gotham,
        TextSize = 14,
        TextColor3 = COLORS.Muted,
        Visible = false,
        Parent = ScriptsScroll
    })
    
    -- Function to create Script Cards
    local function CreateScriptCard(Data)
        local Card = Create("Frame", {
            Name = Data.Name,
            Size = UDim2.new(1, 0, 0, Config.CardHeight),
            BackgroundColor3 = COLORS.CardBg,
            Parent = ScriptsScroll
        })
        AddCorner(Card, 10)
        local Stroke = AddStroke(Card, COLORS.Border, 1)
        
        -- Icon Box
        local IconBox = Create("Frame", {
            Name = "IconBox",
            Size = UDim2.new(0, 40, 0, 40),
            Position = UDim2.new(0, 10, 0.5, -20),
            BackgroundColor3 = Color3.fromHex("#1A0005"),
            Parent = Card
        })
        AddCorner(IconBox, 8)
        
        local IconLabel = Create("TextLabel", {
            Name = "Icon",
            Size = UDim2.new(1, 0, 1, 0),
            BackgroundTransparency = 1,
            Text = Data.Icon,
            Font = Enum.Font.Gotham,
            TextSize = 18,
            TextColor3 = COLORS.Accent,
            Parent = IconBox
        })
        
        -- Text Info
        local InfoFrame = Create("Frame", {
            Name = "Info",
            Size = UDim2.new(1, -100, 1, 0),
            Position = UDim2.new(0, 60, 0, 0),
            BackgroundTransparency = 1,
            Parent = Card
        })
        
        local NameLabel = Create("TextLabel", {
            Name = "Name",
            Size = UDim2.new(1, 0, 0.5, 0),
            Position = UDim2.new(0, 0, 0, 2),
            BackgroundTransparency = 1,
            Text = Data.Name,
            Font = Enum.Font.GothamSemibold,
            TextSize = 14 * Config.TextScale,
            TextColor3 = COLORS.Text,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = InfoFrame
        })
        
        local DescLabel = Create("TextLabel", {
            Name = "Desc",
            Size = UDim2.new(1, 0, 0.5, 0),
            Position = UDim2.new(0, 0, 0.5, -2),
            BackgroundTransparency = 1,
            Text = Data.Desc,
            Font = Enum.Font.Gotham,
            TextSize = 11 * Config.TextScale,
            TextColor3 = COLORS.Muted,
            TextXAlignment = Enum.TextXAlignment.Left,
            Parent = InfoFrame
        })
        
        -- Arrow
        local Arrow = Create("TextLabel", {
            Name = "Arrow",
            Size = UDim2.new(0, 30, 1, 0),
            Position = UDim2.new(1, -35, 0, 0),
            BackgroundTransparency = 1,
            Text = ">",
            Font = Enum.Font.GothamBold,
            TextSize = 18,
            TextColor3 = COLORS.Accent,
            Parent = Card
        })
        
        -- Interactions
        Card.InputBegan:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                TweenService:Create(Card, TWEEN_INFO_FAST, {BackgroundColor3 = Color3.fromHex("#15151E")}):Play()
                TweenService:Create(Stroke, TWEEN_INFO_FAST, {Color = COLORS.Accent}):Play()
            end
        end)
        
        Card.InputEnded:Connect(function(Input)
            if Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch then
                TweenService:Create(Card, TWEEN_INFO_FAST, {BackgroundColor3 = COLORS.CardBg}):Play()
                TweenService:Create(Stroke, TWEEN_INFO_FAST, {Color = COLORS.Border}):Play()
            end
        end)
        
        -- Click Animation
        Card.MouseButton1Click:Connect(function()
            local Shrink = TweenService:Create(Card, TweenInfo.new(0.1), {Size = UDim2.new(0.98, 0, 0, Config.CardHeight - 2)})
            Shrink:Play()
            Shrink.Completed:Wait()
            TweenService:Create(Card, TweenInfo.new(0.1), {Size = UDim2.new(1, 0, 0, Config.CardHeight)}):Play()
            print("Executed: " .. Data.Name)
        end)
        
        return Card
    end
    
    -- Populate Scripts
    for _, data in ipairs(SCRIPTS_DATA) do
        CreateScriptCard(data)
    end
    
    -- Search Logic
    SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
        local Query = SearchBox.Text:lower()
        local VisibleCount = 0
        
        for _, Child in ipairs(ScriptsScroll:GetChildren()) do
            if Child:IsA("Frame") then
                local Name = Child.Name:lower()
                if Name:find(Query) then
                    Child.Visible = true
                    VisibleCount += 1
                else
                    Child.Visible = false
                end
            end
        end
        
        NoResultsLabel.Visible = (VisibleCount == 0)
    end)
    
    -- ============================================================
    --                      MINIMIZE SYSTEM
    -- ============================================================
    
    local CompactBar = Create("Frame", {
        Name = "CompactBar",
        Size = UDim2.new(0, Config.CompactWidth, 0, 55),
        Position = MainFrame.Position, -- Start at same pos
        AnchorPoint = Vector2.new(0.5, 0.5),
        BackgroundColor3 = COLORS.Panel,
        BorderSizePixel = 0,
        Visible = false,
        ZIndex = 10,
        Parent = ScreenGui
    })
    AddCorner(CompactBar, 12)
    AddStroke(CompactBar, COLORS.Accent, 1.5)
    
    local CompactList = Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 15),
        Parent = CompactBar
    })
    
    local CompactLogo = Create("TextLabel", {
        Name = "Logo",
        Size = UDim2.new(0, 80, 0, 30),
        BackgroundTransparency = 1,
        Text = "👑 IZZ HUB",
        Font = Enum.Font.GothamBold,
        TextSize = 14,
        TextColor3 = COLORS.Accent,
        Parent = CompactBar
    })
    
    local CompactIcons = Create("Frame", {
        Name = "Icons",
        Size = UDim2.new(0, 120, 0, 30),
        BackgroundTransparency = 1,
        Parent = CompactBar
    })
    
    local IconList = Create("UIListLayout", {
        FillDirection = Enum.FillDirection.Horizontal,
        VerticalAlignment = Enum.VerticalAlignment.Center,
        HorizontalAlignment = Enum.HorizontalAlignment.Center,
        SortOrder = Enum.SortOrder.LayoutOrder,
        Padding = UDim.new(0, 10),
        Parent = CompactIcons
    })
    
    local MiniIcons = {"🏠", "⚡", "", "", "⚙"}
    for _, Icon in ipairs(MiniIcons) do
        Create("TextLabel", {
            Size = UDim2.new(0, 20, 0, 20),
            BackgroundTransparency = 1,
            Text = Icon,
            Font = Enum.Font.Gotham,
            TextSize = 14,
            TextColor3 = COLORS.Muted,
            Parent = CompactIcons
        })
    end
    
    local RestoreBtn = Create("TextButton", {
        Name = "Restore",
        Size = UDim2.new(0, 30, 0, 30),
        BackgroundColor3 = COLORS.Secondary,
        Text = "◧", -- Expand icon approx
        Font = Enum.Font.GothamBold,
        TextSize = 16,
        TextColor3 = COLORS.Accent,
        AutoButtonColor = false,
        Parent = CompactBar
    })
    AddCorner(RestoreBtn, 6)
    
    local IsMinimized = false
    local LastPosition = MainFrame.Position
    local LastSize = MainFrame.Size
    
    MinimizeBtn.MouseButton1Click:Connect(function()
        if IsMinimized then return end
        IsMinimized = true
        
        LastPosition = MainFrame.Position
        LastSize = MainFrame.Size
        
        -- Hide Main
        TweenService:Create(MainFrame, TWEEN_INFO, {Size = UDim2.new(0,0,0,0), BackgroundTransparency = 1}):Play()
        for _, v in ipairs(MainFrame:GetDescendants()) do
            if v:IsA("TextLabel") then TweenService:Create(v, TWEEN_INFO, {TextTransparency = 1}):Play() end
            if v:IsA("Frame") and v.Name ~= "Glow" then TweenService:Create(v, TWEEN_INFO, {BackgroundTransparency = 1}):Play() end
            if v:IsA("UIStroke") then TweenService:Create(v, TWEEN_INFO, {Transparency = 1}):Play() end
        end
        
        task.wait(0.15)
        MainFrame.Visible = false
        
        -- Show Compact
        CompactBar.Position = LastPosition
        CompactBar.Size = UDim2.new(0, 0, 0, 0)
        CompactBar.Visible = true
        CompactBar.BackgroundTransparency = 1
        
        -- Reset children transparency for animation
        for _, v in ipairs(CompactBar:GetDescendants()) do
            if v:IsA("TextLabel") then v.TextTransparency = 1 end
            if v:IsA("UIStroke") then v.Transparency = 1 end
        end
        
        TweenService:Create(CompactBar, TWEEN_INFO, {
            Size = UDim2.new(0, Config.CompactWidth, 0, 55),
            BackgroundTransparency = 0
        }):Play()
        
        for _, v in ipairs(CompactBar:GetDescendants()) do
            if v:IsA("TextLabel") then TweenService:Create(v, TWEEN_INFO, {TextTransparency = 0}):Play() end
            if v:IsA("UIStroke") then TweenService:Create(v, TWEEN_INFO, {Transparency = 0}):Play() end
        end
    end)
    
    local function RestoreUI()
        if not IsMinimized then return end
        IsMinimized = false
        
        -- Hide Compact
        TweenService:Create(CompactBar, TWEEN_INFO, {
            Size = UDim2.new(0, 0, 0, 0),
            BackgroundTransparency = 1
        }):Play()
        for _, v in ipairs(CompactBar:GetDescendants()) do
            if v:IsA("TextLabel") then TweenService:Create(v, TWEEN_INFO, {TextTransparency = 1}):Play() end
            if v:IsA("UIStroke") then TweenService:Create(v, TWEEN_INFO, {Transparency = 1}):Play() end
        end
        
        task.wait(0.15)
        CompactBar.Visible = false
        
        -- Show Main
        MainFrame.Visible = true
        MainFrame.Position = LastPosition
        MainFrame.Size = UDim2.new(0,0,0,0)
        MainFrame.BackgroundTransparency = 1
        
        -- CLEANER APPROACH FOR RESTORE:
        -- Just set properties instantly to near-final, then tween size.
        for _, v in ipairs(MainFrame:GetDescendants()) do
            if v:IsA("TextLabel") then v.TextTransparency = 0 end
            if v:IsA("UIStroke") then v.Transparency = 0 end 
            if v:IsA("Frame") then
                if v.Name == "Header" or v.Name == "Sidebar" or v.Name == "IconBox" or v.Name == "SearchContainer" or v.Name == "ProgressBg" or v.Name == "ProgressFill" or v.Name == "Dot" or v.Name == "ActiveBar" or v.Name == "Line" or v.Name == "HeaderLine" or v.Name == "SidebarLine" then
                    v.BackgroundTransparency = 0
                elseif v.Name == "Body" or v.Name == "Content" or v.Name == "NavContainer" or v.Name == "Controls" or v.Name == "LogoContainer" or v.Name == "TextWrapper" or v.Name == "Info" or v.Name == "ContentHeader" or v.Name == "ScriptsScroll" or v.Name == "Status" then
                    v.BackgroundTransparency = 1
                else
                    -- Cards etc
                    v.BackgroundTransparency = 0
                end
            end
        end
        MainFrame.BackgroundTransparency = 0
        
        TweenService:Create(MainFrame, TWEEN_INFO, {
            Size = LastSize,
            Position = LastPosition
        }):Play()
    end
    
    RestoreBtn.MouseButton1Click:Connect(RestoreUI)
    CompactBar.MouseButton1Click:Connect(RestoreUI) -- Click anywhere on bar to restore
    
    -- Close Button
    CloseBtn.MouseButton1Click:Connect(function()
        TweenService:Create(MainFrame, TWEEN_INFO, {BackgroundTransparency = 1}):Play()
        for _, v in ipairs(MainFrame:GetDescendants()) do
            if v:IsA("TextLabel") then TweenService:Create(v, TWEEN_INFO, {TextTransparency = 1}):Play() end
            if v:IsA("Frame") then TweenService:Create(v, TWEEN_INFO, {BackgroundTransparency = 1}):Play() end
            if v:IsA("UIStroke") then TweenService:Create(v, TWEEN_INFO, {Transparency = 1}):Play() end
        end
        task.wait(0.3)
        ScreenGui:Destroy()
    end)
    
    -- ============================================================
    --                      DRAG SYSTEM
    -- ============================================================
    
    local Dragging = false
    local DragStart = nil
    local StartPos = nil
    local DragObject = MainFrame -- Can switch to CompactBar
    
    local function UpdateDrag(Input)
        local Delta = Input.Position - DragStart
        local NewPos = UDim2.new(StartPos.X.Scale, StartPos.X.Offset + Delta.X, StartPos.Y.Scale, StartPos.Y.Offset + Delta.Y)
        
        -- Boundary Check (Simple)
        -- Keep within screen roughly
        DragObject.Position = NewPos
    end
    
    local function StartDrag(Input)
        -- Only drag if clicking on background or header, not buttons
        if Input.UserInputType == Enum.UserInputType.MouseButton1 or Input.UserInputType == Enum.UserInputType.Touch then
            Dragging = true
            DragStart = Input.Position
            StartPos = DragObject.Position
            
            local Connection
            Connection = Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                    Connection:Disconnect()
                end
            end)
        end
    end
    
    -- Apply Drag to MainFrame Header
    Header.InputBegan:Connect(function(Input)
        if not IsMinimized then
            DragObject = MainFrame
            StartDrag(Input)
        end
    end)
    
    -- Apply Drag to CompactBar
    CompactBar.InputBegan:Connect(function(Input)
        if IsMinimized then
            DragObject = CompactBar
            local StartPosInput = Input.Position
            local OriginalPos = CompactBar.Position
            local Moved = false
            
            Dragging = true
            DragStart = Input.Position
            StartPos = CompactBar.Position
            
            local Connection
            Connection = Input.Changed:Connect(function()
                if Input.UserInputState == Enum.UserInputState.End then
                    Dragging = false
                    Connection:Disconnect()
                    if not Moved then
                        RestoreUI()
                    end
                elseif Input.UserInputState == Enum.UserInputState.Change then
                    local Delta = (Input.Position - StartPosInput).Magnitude
                    if Delta > 5 then Moved = true end
                    UpdateDrag(Input)
                end
            end)
        end
    end)
    
    UserInputService.InputChanged:Connect(function(Input)
        if Dragging and (Input.UserInputType == Enum.UserInputType.MouseMovement or Input.UserInputType == Enum.UserInputType.Touch) then
            UpdateDrag(Input)
        end
    end)
    
    -- ============================================================
    --                      FINAL INIT & OPEN ANIMATION
    -- ============================================================
    
    function MainUI_Open()
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 0, 0, 0)
        MainFrame.BackgroundTransparency = 1
        
        -- Prepare children
        for _, v in ipairs(MainFrame:GetDescendants()) do
            if v:IsA("TextLabel") then v.TextTransparency = 1 end
            if v:IsA("Frame") and v.Name ~= "Glow" then v.BackgroundTransparency = 1 end
            if v:IsA("UIStroke") then v.Transparency = 1 end
        end
        
        -- Animate In
        TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = Config.MainSize,
            BackgroundTransparency = 0
        }):Play()
        
        task.wait(0.1)
        
        for _, v in ipairs(MainFrame:GetDescendants()) do
            if v:IsA("TextLabel") then 
                TweenService:Create(v, TweenInfo.new(0.3), {TextTransparency = 0}):Play() 
            end
            if v:IsA("UIStroke") then 
                TweenService:Create(v, TweenInfo.new(0.3), {Transparency = 0.3}):Play() -- Default border trans
            end
            if v:IsA("Frame") then
                 -- Restore specific transparencies
                 if v.Name == "Header" or v.Name == "Sidebar" or v.Name == "IconBox" or v.Name == "SearchContainer" or v.Name == "ProgressBg" or v.Name == "ProgressFill" or v.Name == "Dot" or v.Name == "ActiveBar" or v.Name == "Line" or v.Name == "HeaderLine" or v.Name == "SidebarLine" or v.Name == "Minimize" or v.Name == "Close" or v.Name == "Restore" then
                     TweenService:Create(v, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
                 elseif v.Name == "Body" or v.Name == "Content" or v.Name == "NavContainer" or v.Name == "Controls" or v.Name == "LogoContainer" or v.Name == "TextWrapper" or v.Name == "Info" or v.Name == "ContentHeader" or v.Name == "ScriptsScroll" or v.Name == "Status" or v.Name == "Icons" or v.Name == "CompactIcons" then
                     -- Keep transparent
                 else
                     -- Cards
                     TweenService:Create(v, TweenInfo.new(0.3), {BackgroundTransparency = 0}):Play()
                 end
            end
        end
    end
    
    -- Handle Resize
    Camera:GetPropertyChangedSignal("ViewportSize"):Connect(function()
        -- Basic resize handling could go here, but for simplicity in one script, 
        -- we rely on the initial config. A full responsive re-calculation requires 
        -- updating all UDim2s which is verbose. 
        -- The initial Config sets the scale/offset based on start size.
        -- For a truly dynamic resize, we'd need to re-run GetScaleConfig and update elements.
        -- Given constraints, we'll stick to initial load sizing which covers most cases.
    end)
