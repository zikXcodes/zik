-- ======================================================
-- IZZ HUB UI V2 (Ultra Cool Edition - Frontend Only)
-- Dibuat oleh: bl_ai v1.0
-- Fitur: Toggle Button, Tab System, Search, Notifications
-- ======================================================

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Hapus GUI lama jika ada
local oldGui = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("IZZ_HUB_UI_V2")
if oldGui then
    oldGui:Destroy()
end

-- ==================== EXECUTING ANIMATION SYSTEM ====================
local ExecOverlay = Instance.new("Frame")
ExecOverlay.Name = "ExecOverlay"
ExecOverlay.Size = UDim2.new(1, 0, 1, 0)
ExecOverlay.Position = UDim2.new(0, 0, 0, 0)
ExecOverlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ExecOverlay.BackgroundTransparency = 0.5
ExecOverlay.BorderSizePixel = 0
ExecOverlay.ZIndex = 50
ExecOverlay.Visible = false
ExecOverlay.Parent = MainFrame
createCorner(ExecOverlay, 14)

local ExecText = Instance.new("TextLabel")
ExecText.Size = UDim2.new(1, 0, 0, 30)
ExecText.Position = UDim2.new(0, 0, 0.5, -50)
ExecText.BackgroundTransparency = 1
ExecText.Text = "⚡ Executing..."
ExecText.TextColor3 = Colors.Accent
ExecText.Font = Enum.Font.GothamBold
ExecText.TextSize = 18
ExecText.ZIndex = 51
ExecText.Parent = ExecOverlay

local ProgressBg = Instance.new("Frame")
ProgressBg.Size = UDim2.new(0.6, 0, 0, 6)
ProgressBg.Position = UDim2.new(0.2, 0, 0.5, 10)
ProgressBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
ProgressBg.BorderSizePixel = 0
ProgressBg.ZIndex = 51
ProgressBg.Parent = ExecOverlay
createCorner(ProgressBg, 3)

local ProgressFill = Instance.new("Frame")
ProgressFill.Size = UDim2.new(0, 0, 1, 0)
ProgressFill.BackgroundColor3 = Colors.Accent
ProgressFill.BorderSizePixel = 0
ProgressFill.ZIndex = 52
ProgressFill.Parent = ProgressBg
createCorner(ProgressFill, 3)

-- Gradient Progress Bar biar makin keren
local progressGradient = Instance.new("UIGradient")
progressGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Colors.AccentDark),
    ColorSequenceKeypoint.new(1, Colors.AccentHover)
})
progressGradient.Rotation = 0
progressGradient.Parent = ProgressFill

-- Fungsi Animasi Execute
local function playExecuteAnimation(callback)
    if ExecOverlay.Visible then return end -- Cegah spam klik
    
    ExecOverlay.Visible = true
    ProgressFill.Size = UDim2.new(0, 0, 1, 0)
    
    -- Efek suara (bisa diganti kalau tuan punya asset ID lain)
    playSound(Sounds.Click, 0.6)
    
    -- Animasi progress bar dari 0% ke 100%
    TweenService:Create(ProgressFill, TweenInfo.new(0.8, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Size = UDim2.new(1, 0, 1, 0)
    }):Play()
    
    -- Tunggu animasi selesai, tutup overlay, lalu jalankan aksi aslinya
    task.wait(0.9)
    ExecOverlay.Visible = false
    
    if callback then
        callback()
    end
end

-- ==================== KONFIGURASI WARNA ====================
local Colors = {
    Background = Color3.fromRGB(12, 12, 14),
    Sidebar = Color3.fromRGB(18, 18, 22),
    Accent = Color3.fromRGB(220, 30, 40),
    AccentHover = Color3.fromRGB(255, 50, 60),
    AccentDark = Color3.fromRGB(150, 15, 25),
    Text = Color3.fromRGB(245, 245, 245),
    TextDim = Color3.fromRGB(140, 140, 150),
    ItemBg = Color3.fromRGB(26, 26, 32),
    ItemHover = Color3.fromRGB(40, 40, 48),
    ToggleOn = Color3.fromRGB(220, 30, 40),
    ToggleOff = Color3.fromRGB(60, 60, 70),
    NotificationBg = Color3.fromRGB(30, 30, 36)
}

-- ==================== VARIABEL UTAMA ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "IZZ_HUB_UI_V2"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- ==================== FUNGSI UTILITAS ====================
local function createCorner(parent, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = parent
    return corner
end

local function createStroke(parent, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness or 1
    stroke.Transparency = transparency or 0
    stroke.Parent = parent
    return stroke
end

-- Efek Suara
local Sounds = {
    Click = "rbxassetid://6895079853",
    Open = "rbxassetid://6895079853",
    Close = "rbxassetid://6895079853",
    Hover = "rbxassetid://6895079853"
}

local function playSound(id, volume)
    local s = Instance.new("Sound")
    s.SoundId = id
    s.Volume = volume or 0.5
    s.Parent = ScreenGui
    s:Play()
    task.delay(2, function() s:Destroy() end)
end

-- ==================== TOGGLE BUTTON (FLOATING) ====================
local ToggleButton = Instance.new("TextButton")
ToggleButton.Name = "ToggleButton"
ToggleButton.Size = UDim2.new(0, 55, 0, 55)
ToggleButton.Position = UDim2.new(0, 20, 0.5, -27)
ToggleButton.BackgroundColor3 = Colors.Accent
ToggleButton.Text = "👑"
ToggleButton.TextColor3 = Colors.Text
ToggleButton.Font = Enum.Font.GothamBold
ToggleButton.TextSize = 24
ToggleButton.Visible = false
ToggleButton.Active = true
ToggleButton.Draggable = true
ToggleButton.Parent = ScreenGui

createCorner(ToggleButton, 27)
local toggleStroke = createStroke(ToggleButton, Colors.AccentHover, 2, 0.3)

-- Gradient untuk Toggle Button
local toggleGradient = Instance.new("UIGradient")
toggleGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Colors.Accent),
    ColorSequenceKeypoint.new(1, Colors.AccentDark)
})
toggleGradient.Rotation = 45
toggleGradient.Parent = ToggleButton

-- Animasi Hover Toggle Button
ToggleButton.MouseEnter:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 60, 0, 60)}):Play()
    TweenService:Create(toggleStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
end)

ToggleButton.MouseLeave:Connect(function()
    TweenService:Create(ToggleButton, TweenInfo.new(0.2), {Size = UDim2.new(0, 55, 0, 55)}):Play()
    TweenService:Create(toggleStroke, TweenInfo.new(0.2), {Transparency = 0.3}):Play()
end)

-- ==================== MAIN FRAME ====================
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 650, 0, 450)
MainFrame.Position = UDim2.new(0.5, -325, 0.5, -225)
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true
MainFrame.Visible = true
MainFrame.Parent = ScreenGui

createCorner(MainFrame, 14)
local mainStroke = createStroke(MainFrame, Colors.Accent, 1, 0.4)

-- Gradient Background Main Frame
local mainGradient = Instance.new("UIGradient")
mainGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 20, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(10, 10, 12))
})
mainGradient.Rotation = 90
mainGradient.Parent = MainFrame

-- ==================== SIDEBAR ====================
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 160, 1, 0)
Sidebar.BackgroundColor3 = Colors.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

createCorner(Sidebar, 14)
local sidebarCover = Instance.new("Frame")
sidebarCover.Size = UDim2.new(0, 10, 1, 0)
sidebarCover.Position = UDim2.new(1, -10, 0, 0)
sidebarCover.BackgroundColor3 = Colors.Sidebar
sidebarCover.BorderSizePixel = 0
sidebarCover.Parent = Sidebar

-- Logo Area
local LogoFrame = Instance.new("Frame")
LogoFrame.Size = UDim2.new(1, 0, 0, 70)
LogoFrame.BackgroundTransparency = 1
LogoFrame.Parent = Sidebar

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 0, 30)
LogoText.Position = UDim2.new(0, 0, 0, 18)
LogoText.BackgroundTransparency = 1
LogoText.Text = "👑 IZZ HUB"
LogoText.TextColor3 = Colors.Accent
LogoText.Font = Enum.Font.GothamBold
LogoText.TextSize = 20
LogoText.TextXAlignment = Enum.TextXAlignment.Center
LogoText.Parent = LogoFrame

local SubLogoText = Instance.new("TextLabel")
SubLogoText.Size = UDim2.new(1, 0, 0, 15)
SubLogoText.Position = UDim2.new(0, 0, 0, 45)
SubLogoText.BackgroundTransparency = 1
SubLogoText.Text = "Better • Faster • Stronger"
SubLogoText.TextColor3 = Colors.TextDim
SubLogoText.Font = Enum.Font.Gotham
SubLogoText.TextSize = 9
SubLogoText.TextXAlignment = Enum.TextXAlignment.Center
SubLogoText.Parent = LogoFrame

-- Nav Container
local NavContainer = Instance.new("Frame")
NavContainer.Size = UDim2.new(1, 0, 1, -140)
NavContainer.Position = UDim2.new(0, 0, 0, 80)
NavContainer.BackgroundTransparency = 1
NavContainer.Parent = Sidebar

local NavLayout = Instance.new("UIListLayout")
NavLayout.Padding = UDim.new(0, 4)
NavLayout.SortOrder = Enum.SortOrder.LayoutOrder
NavLayout.Parent = NavContainer

local NavPadding = Instance.new("UIPadding")
NavPadding.PaddingLeft = UDim.new(0, 12)
NavPadding.PaddingRight = UDim.new(0, 12)
NavPadding.Parent = NavContainer

-- Status Area
local StatusFrame = Instance.new("Frame")
StatusFrame.Size = UDim2.new(1, 0, 0, 50)
StatusFrame.Position = UDim2.new(0, 0, 1, -55)
StatusFrame.BackgroundTransparency = 1
StatusFrame.Parent = Sidebar

local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.new(0, 8, 0, 8)
StatusDot.Position = UDim2.new(0, 18, 0, 12)
StatusDot.BackgroundColor3 = Color3.fromRGB(50, 220, 50)
StatusDot.BorderSizePixel = 0
StatusDot.Parent = StatusFrame
createCorner(StatusDot, 4)

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -35, 0, 15)
StatusText.Position = UDim2.new(0, 32, 0, 9)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Loader Ready"
StatusText.TextColor3 = Colors.Text
StatusText.Font = Enum.Font.GothamMedium
StatusText.TextSize = 11
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Parent = StatusFrame

local VersionText = Instance.new("TextLabel")
VersionText.Size = UDim2.new(1, -35, 0, 15)
VersionText.Position = UDim2.new(0, 32, 0, 25)
VersionText.BackgroundTransparency = 1
VersionText.Text = "v2.0.0 • bl_ai"
VersionText.TextColor3 = Colors.TextDim
VersionText.Font = Enum.Font.Gotham
VersionText.TextSize = 9
VersionText.TextXAlignment = Enum.TextXAlignment.Left
VersionText.Parent = StatusFrame

-- ==================== CONTENT AREA ====================
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -160, 1, 0)
ContentFrame.Position = UDim2.new(0, 160, 0, 0)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Header Content
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, 0, 0, 70)
HeaderFrame.BackgroundTransparency = 1
HeaderFrame.Parent = ContentFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0, 300, 0, 25)
TitleText.Position = UDim2.new(0, 25, 0, 15)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Home"
TitleText.TextColor3 = Colors.Text
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 20
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = HeaderFrame

local SubTitleText = Instance.new("TextLabel")
SubTitleText.Size = UDim2.new(0, 300, 0, 15)
SubTitleText.Position = UDim2.new(0, 25, 0, 42)
SubTitleText.BackgroundTransparency = 1
SubTitleText.Text = "Selamat datang di IZZ HUB"
SubTitleText.TextColor3 = Colors.TextDim
SubTitleText.Font = Enum.Font.Gotham
SubTitleText.TextSize = 11
SubTitleText.TextXAlignment = Enum.TextXAlignment.Left
SubTitleText.Parent = HeaderFrame

-- Search Bar
local SearchBar = Instance.new("Frame")
SearchBar.Size = UDim2.new(0, 180, 0, 32)
SearchBar.Position = UDim2.new(1, -260, 0, 18)
SearchBar.BackgroundColor3 = Colors.Sidebar
SearchBar.BorderSizePixel = 0
SearchBar.Parent = HeaderFrame
createCorner(SearchBar, 8)
createStroke(SearchBar, Colors.Accent, 1, 0.7)

local SearchIcon = Instance.new("TextLabel")
SearchIcon.Size = UDim2.new(0, 30, 1, 0)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Text = "🔍"
SearchIcon.TextColor3 = Colors.TextDim
SearchIcon.Font = Enum.Font.Gotham
SearchIcon.TextSize = 14
SearchIcon.Parent = SearchBar

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -35, 1, 0)
SearchBox.Position = UDim2.new(0, 30, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.Text = ""
SearchBox.PlaceholderText = "Cari..."
SearchBox.PlaceholderColor3 = Colors.TextDim
SearchBox.TextColor3 = Colors.Text
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 12
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.Parent = SearchBar

-- Minimize & Close Buttons
local MinBtn = Instance.new("TextButton")
MinBtn.Size = UDim2.new(0, 30, 0, 30)
MinBtn.Position = UDim2.new(1, -60, 0, 18)
MinBtn.BackgroundColor3 = Colors.Sidebar
MinBtn.Text = "—"
MinBtn.TextColor3 = Colors.Text
MinBtn.Font = Enum.Font.GothamBold
MinBtn.TextSize = 16
MinBtn.Parent = HeaderFrame
createCorner(MinBtn, 6)

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -25, 0, 18)
CloseBtn.BackgroundColor3 = Colors.Accent
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Colors.Text
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = HeaderFrame
createCorner(CloseBtn, 6)

-- ==================== SCROLLING LIST ====================
local ScriptList = Instance.new("ScrollingFrame")
ScriptList.Size = UDim2.new(1, -50, 1, -90)
ScriptList.Position = UDim2.new(0, 25, 0, 80)
ScriptList.BackgroundTransparency = 1
ScriptList.BorderSizePixel = 0
ScriptList.ScrollBarThickness = 4
ScriptList.ScrollBarImageColor3 = Colors.Accent
ScriptList.CanvasSize = UDim2.new(0, 0, 0, 0)
ScriptList.Parent = ContentFrame

local ListLayout = Instance.new("UIListLayout")
ListLayout.Padding = UDim.new(0, 8)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Parent = ScriptList

-- ==================== NOTIFICATION SYSTEM ====================
local NotifFrame = Instance.new("Frame")
NotifFrame.Size = UDim2.new(0, 250, 0, 50)
NotifFrame.Position = UDim2.new(1, -270, 1, 20) -- Start hidden below
NotifFrame.BackgroundColor3 = Colors.NotificationBg
NotifFrame.BorderSizePixel = 0
NotifFrame.Visible = false
NotifFrame.Parent = MainFrame
createCorner(NotifFrame, 8)
createStroke(NotifFrame, Colors.Accent, 1, 0.5)

local NotifTitle = Instance.new("TextLabel")
NotifTitle.Size = UDim2.new(1, -20, 0, 20)
NotifTitle.Position = UDim2.new(0, 15, 0, 8)
NotifTitle.BackgroundTransparency = 1
NotifTitle.Text = "✅ Script Loaded"
NotifTitle.TextColor3 = Colors.Text
NotifTitle.Font = Enum.Font.GothamBold
NotifTitle.TextSize = 13
NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
NotifTitle.Parent = NotifFrame

local NotifDesc = Instance.new("TextLabel")
NotifDesc.Size = UDim2.new(1, -20, 0, 15)
NotifDesc.Position = UDim2.new(0, 15, 0, 28)
NotifDesc.BackgroundTransparency = 1
NotifDesc.Text = "Fitur berhasil dijalankan."
NotifDesc.TextColor3 = Colors.TextDim
NotifDesc.Font = Enum.Font.Gotham
NotifDesc.TextSize = 10
NotifDesc.TextXAlignment = Enum.TextXAlignment.Left
NotifDesc.Parent = NotifFrame

local function showNotification(title, desc)
    NotifTitle.Text = title
    NotifDesc.Text = desc
    NotifFrame.Visible = true
    NotifFrame.Position = UDim2.new(1, -270, 1, 20)
    
    TweenService:Create(NotifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
        Position = UDim2.new(1, -270, 1, -70)
    }):Play()
    
    task.delay(3, function()
        TweenService:Create(NotifFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
            Position = UDim2.new(1, -270, 1, 20)
        }):Play()
        task.wait(0.3)
        NotifFrame.Visible = false
    end)
end

-- ==================== DATA SCRIPT PER TAB ====================
local TabsData = {
    Home = {
        Title = "Home",
        SubTitle = "Selamat datang di IZZ HUB",
        Items = {
            {Name = "Status Menu", Desc = "Cek status semua fitur.", Icon = "📊"},
            {Name = "Informasi Update", Desc = "Lihat changelog terbaru.", Icon = "📰"},
            {Name = "Kredit & Kontributor", Desc = "Terima kasih untuk semua.", Icon = "💖"}
        }
    },
    Scripts = {
        Title = "Scripts",
        SubTitle = "Pilih script yang ingin kamu gunakan.",
        Items = {
            {Name = "Hitbox Modifier", Desc = "Memperbesar hitbox karakter.", Icon = "🎯"},
            {Name = "Killer No Cooldown", Desc = "Skill killer tanpa cooldown.", Icon = "💀"},
            {Name = "Infinite Lunge", Desc = "Lunge tanpa batas.", Icon = "🏃"},
            {Name = "AIMLOCK M2 SKILL HIDDEN", Desc = "Lock musuh secara otomatis.", Icon = "🔒"},
            {Name = "Mayers (Stalker) No Cooldown", Desc = "Stalker tanpa cooldown.", Icon = "👁️"},
            {Name = "Massked Skill Spammer", Desc = "Spam skill secara cepat.", Icon = "✳️"},
            {Name = "Anti Blind", Desc = "Menghilangkan efek blind.", Icon = "👁️‍🗨️"}
        }
    },
    LocalPlayer = {
        Title = "Local Player",
        SubTitle = "Pengaturan karakter kamu.",
        Items = {
            {Name = "WalkSpeed", Desc = "Atur kecepatan berjalan.", Icon = "🏃‍♂️"},
            {Name = "JumpPower", Desc = "Atur kekuatan lompat.", Icon = "🦘"},
            {Name = "Infinite Jump", Desc = "Lompat tanpa batas.", Icon = "⬆️"}
        }
    },
    Teleport = {
        Title = "Teleport",
        SubTitle = "Pindah lokasi dengan cepat.",
        Items = {
            {Name = "Spawn", Desc = "Teleport ke spawn.", Icon = "🏠"},
            {Name = "Random Player", Desc = "Teleport ke player random.", Icon = "🎲"},
            {Name = "Custom Coords", Desc = "Teleport ke koordinat custom.", Icon = "📍"}
        }
    },
    Misc = {
        Title = "Misc",
        SubTitle = "Fitur tambahan lainnya.",
        Items = {
            {Name = "Fullbright", Desc = "Terangin seluruh map.", Icon = "💡"},
            {Name = "Anti AFK", Desc = "Cegah kick karena AFK.", Icon = "⏳"},
            {Name = "FPS Booster", Desc = "Tingkatkan performa.", Icon = "⚡"}
        }
    },
    Settings = {
        Title = "Settings",
        SubTitle = "Konfigurasi UI dan sistem.",
        Items = {
            {Name = "UI Transparency", Desc = "Atur transparansi UI.", Icon = "🎨"},
            {Name = "Toggle Keybind", Desc = "Ubah tombol toggle.", Icon = "⌨️"},
            {Name = "Reset Config", Desc = "Reset semua pengaturan.", Icon = "🔄"}
        }
    }
}

-- ==================== FUNGSI MEMBUAT ITEM ====================
local currentTabItems = {} -- Menyimpan item yang sedang ditampilkan

local function createScriptItem(data, order)
    local ItemFrame = Instance.new("Frame")
    ItemFrame.Name = data.Name .. "Item"
    ItemFrame.Size = UDim2.new(1, -10, 0, 55)
    ItemFrame.BackgroundColor3 = Colors.ItemBg
    ItemFrame.BorderSizePixel = 0
    ItemFrame.LayoutOrder = order
    ItemFrame.Parent = ScriptList
    createCorner(ItemFrame, 10)
    
    local itemStroke = createStroke(ItemFrame, Colors.Accent, 1, 0.8)

    -- Icon
    local IconLabel = Instance.new("TextLabel")
    IconLabel.Size = UDim2.new(0, 45, 1, 0)
    IconLabel.BackgroundTransparency = 1
    IconLabel.Text = data.Icon
    IconLabel.TextColor3 = Colors.Accent
    IconLabel.Font = Enum.Font.GothamBold
    IconLabel.TextSize = 20
    IconLabel.Parent = ItemFrame

    -- Title
    local ItemTitle = Instance.new("TextLabel")
    ItemTitle.Size = UDim2.new(1, -150, 0, 20)
    ItemTitle.Position = UDim2.new(0, 55, 0, 10)
    ItemTitle.BackgroundTransparency = 1
    ItemTitle.Text = data.Name
    ItemTitle.TextColor3 = Colors.Text
    ItemTitle.Font = Enum.Font.GothamBold
    ItemTitle.TextSize = 14
    ItemTitle.TextXAlignment = Enum.TextXAlignment.Left
    ItemTitle.Parent = ItemFrame

    -- Description
    local ItemDesc = Instance.new("TextLabel")
    ItemDesc.Size = UDim2.new(1, -150, 0, 15)
    ItemDesc.Position = UDim2.new(0, 55, 0, 32)
    ItemDesc.BackgroundTransparency = 1
    ItemDesc.Text = data.Desc
    ItemDesc.TextColor3 = Colors.TextDim
    ItemDesc.Font = Enum.Font.Gotham
    ItemDesc.TextSize = 11
    ItemDesc.TextXAlignment = Enum.TextXAlignment.Left
    ItemDesc.Parent = ItemFrame

    -- Toggle Switch (Pengganti Chevron biar lebih keren)
    local ToggleSwitch = Instance.new("TextButton")
    ToggleSwitch.Size = UDim2.new(0, 40, 0, 20)
    ToggleSwitch.Position = UDim2.new(1, -55, 0.5, -10)
    ToggleSwitch.BackgroundColor3 = Colors.ToggleOff
    ToggleSwitch.Text = ""
    ToggleSwitch.Parent = ItemFrame
    createCorner(ToggleSwitch, 10)

    local ToggleDot = Instance.new("Frame")
    ToggleDot.Size = UDim2.new(0, 16, 0, 16)
    ToggleDot.Position = UDim2.new(0, 2, 0.5, -8)
    ToggleDot.BackgroundColor3 = Colors.Text
    ToggleDot.BorderSizePixel = 0
    ToggleDot.Parent = ToggleSwitch
    createCorner(ToggleDot, 8)

    local isToggled = false

    -- Hover Effect
    ItemFrame.MouseEnter:Connect(function()
        TweenService:Create(ItemFrame, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ItemHover}):Play()
        TweenService:Create(itemStroke, TweenInfo.new(0.2), {Transparency = 0}):Play()
    end)

    ItemFrame.MouseLeave:Connect(function()
        TweenService:Create(ItemFrame, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ItemBg}):Play()
        TweenService:Create(itemStroke, TweenInfo.new(0.2), {Transparency = 0.8}):Play()
    end)

    -- Click Action
    ToggleSwitch.MouseButton1Click:Connect(function()
        isToggled = not isToggled
        playSound(Sounds.Click, 0.4)
        
        if isToggled then
            TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ToggleOn}):Play()
            TweenService:Create(ToggleDot, TweenInfo.new(0.2), {Position = UDim2.new(1, -18, 0.5, -8)}):Play()
            showNotification("✅ " .. data.Name, "Fitur berhasil diaktifkan.")
            print("[bl_ai] Simulasi ON: " .. data.Name)
        else
            TweenService:Create(ToggleSwitch, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ToggleOff}):Play()
            TweenService:Create(ToggleDot, TweenInfo.new(0.2), {Position = UDim2.new(0, 2, 0.5, -8)}):Play()
            showNotification("❌ " .. data.Name, "Fitur dimatikan.")
            print("[bl_ai] Simulasi OFF: " .. data.Name)
                        end
    end)

    return ItemFrame
end

-- ==================== FUNGSI GANTI TAB ====================
local function switchTab(tabName)
    -- Hapus item lama
    for _, item in ipairs(currentTabItems) do
        item:Destroy()
    end
    currentTabItems = {}

    -- Update Header
    local tabData = TabsData[tabName]
    if not tabData then return end
    
    TitleText.Text = tabData.Title
    SubTitleText.Text = tabData.SubTitle

    -- Buat item baru
    for i, data in ipairs(tabData.Items) do
        local item = createScriptItem(data, i)
        table.insert(currentTabItems, item)
    end

    -- Update Canvas Size
    task.wait(0.05)
    ScriptList.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 20)
end

-- ==================== SIDEBAR NAVIGATION ====================
local navButtons = {}

local function createNavButton(name, icon, order)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Btn"
    btn.Size = UDim2.new(1, 0, 0, 38)
    btn.BackgroundColor3 = Colors.Sidebar
    btn.BorderSizePixel = 0
    btn.Text = "  " .. icon .. "  " .. name
    btn.TextColor3 = Colors.TextDim
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.LayoutOrder = order
    btn.Parent = NavContainer
    createCorner(btn, 8)

    -- Indikator Aktif (Garis Merah di Kiri)
    local activeIndicator = Instance.new("Frame")
    activeIndicator.Size = UDim2.new(0, 3, 0.6, 0)
    activeIndicator.Position = UDim2.new(0, 0, 0.2, 0)
    activeIndicator.BackgroundColor3 = Colors.Accent
    activeIndicator.BorderSizePixel = 0
    activeIndicator.Visible = false
    activeIndicator.Parent = btn
    createCorner(activeIndicator, 2)

    btn.MouseEnter:Connect(function()
        if not btn:GetAttribute("Active") then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ItemHover, TextColor3 = Colors.Text}):Play()
        end
    end)

    btn.MouseLeave:Connect(function()
        if not btn:GetAttribute("Active") then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Sidebar, TextColor3 = Colors.TextDim}):Play()
        end
    end)

    btn.MouseButton1Click:Connect(function()
        playSound(Sounds.Click, 0.4)
        
        -- Reset semua tombol
        for _, b in pairs(navButtons) do
            b:SetAttribute("Active", false)
            b.BackgroundColor3 = Colors.Sidebar
            b.TextColor3 = Colors.TextDim
            b:FindFirstChildOfClass("Frame").Visible = false
        end

        -- Set tombol ini aktif
        btn:SetAttribute("Active", true)
        btn.BackgroundColor3 = Colors.Accent
        btn.TextColor3 = Colors.Text
        activeIndicator.Visible = true

        -- Ganti konten
        switchTab(name)
    end)

    navButtons[name] = btn
    return btn
end

-- Buat tombol navigasi
createNavButton("Home", "🏠", 1)
createNavButton("Scripts", "⚡", 2)
createNavButton("LocalPlayer", "👤", 3)
createNavButton("Teleport", "📍", 4)
createNavButton("Misc", "⚙️", 5)
createNavButton("Settings", "⚙", 6)

-- Set Home sebagai default
navButtons["Home"]:SetAttribute("Active", true)
navButtons["Home"].BackgroundColor3 = Colors.Accent
navButtons["Home"].TextColor3 = Colors.Text
navButtons["Home"]:FindFirstChildOfClass("Frame").Visible = true
switchTab("Home")

-- ==================== SEARCH FUNCTIONALITY ====================
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = string.lower(SearchBox.Text)
    for _, item in ipairs(currentTabItems) do
        local title = item:FindFirstChild("TextLabel") -- Ambil TextLabel pertama (Title)
        if title then
            local itemName = string.lower(title.Text)
            if query == "" or string.find(itemName, query) then
                item.Visible = true
            else
                item.Visible = false
            end
        end
    end
end)

-- ==================== TOGGLE & ANIMASI UI ====================
local isOpen = true

local function openUI()
    isOpen = true
    ToggleButton.Visible = false
    MainFrame.Visible = true
    MainFrame.Size = UDim2.new(0, 0, 0, 0)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    
    playSound(Sounds.Open, 0.5)
    
    TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Size = UDim2.new(0, 650, 0, 450),
        Position = UDim2.new(0.5, -325, 0.5, -225)
    }):Play()
end

local function closeUI()
    isOpen = false
    playSound(Sounds.Close, 0.5)
    
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 0, 0, 0),
        Position = UDim2.new(0.5, 0, 0.5, 0)
    }):Play()
    
    task.wait(0.3)
    MainFrame.Visible = false
    ToggleButton.Visible = true
end

-- Event Klik Tombol
CloseBtn.MouseButton1Click:Connect(closeUI)
MinBtn.MouseButton1Click:Connect(closeUI) -- Minimize sama kayak close, tapi UI bisa dibuka lagi
ToggleButton.MouseButton1Click:Connect(openUI)

-- Keybind Toggle (Tombol "RightShift" atau "Kanan Shift")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    if input.KeyCode == Enum.KeyCode.RightShift then
        if isOpen then
            closeUI()
        else
            openUI()
        end
    end
end)

print("[bl_ai] IZZ HUB UI V2 (Ultra Cool Edition) berhasil dimuat! 🫡")
print("[bl_ai] Tekan 'RightShift' untuk buka/tutup UI.")
 
