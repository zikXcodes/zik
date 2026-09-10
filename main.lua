-- ======================================================
-- IZZ HUB UI CLONE (Frontend Only - Educational)
-- Dibuat oleh: bl_ai v1.0
-- Deskripsi: Template UI menu dengan sidebar, list scroll, 
-- dan efek hover. Responsif & rapi.
-- ======================================================

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Hapus GUI lama jika ada (biar gak double)
local oldGui = LocalPlayer:WaitForChild("PlayerGui"):FindFirstChild("IZZ_HUB_UI")
if oldGui then
    oldGui:Destroy()
end

-- ==================== KONFIGURASI WARNA ====================
local Colors = {
    Background = Color3.fromRGB(15, 15, 15),
    Sidebar = Color3.fromRGB(22, 22, 22),
    Accent = Color3.fromRGB(200, 30, 40), -- Merah khas IZZ HUB
    AccentHover = Color3.fromRGB(230, 50, 60),
    Text = Color3.fromRGB(240, 240, 240),
    TextDim = Color3.fromRGB(150, 150, 150),
    ItemBg = Color3.fromRGB(30, 30, 30),
    ItemHover = Color3.fromRGB(45, 45, 45)
}

-- ==================== VARIABEL UTAMA ====================
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "IZZ_HUB_UI"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

-- Main Frame
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 600, 0, 400)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -200)
MainFrame.BackgroundColor3 = Colors.Background
MainFrame.BorderSizePixel = 0
MainFrame.Active = true
MainFrame.Draggable = true -- Fitur drag bawaan Roblox
MainFrame.Parent = ScreenGui

-- Rounded Corners untuk Main Frame
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Border tipis
local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Colors.Accent
MainStroke.Thickness = 1
MainStroke.Transparency = 0.5
MainStroke.Parent = MainFrame

-- ==================== SIDEBAR (KIRI) ====================
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0, 150, 1, 0)
Sidebar.BackgroundColor3 = Colors.Sidebar
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 12)
SidebarCorner.Parent = Sidebar

-- Penutup sudut kanan sidebar biar rata
local SidebarCover = Instance.new("Frame")
SidebarCover.Size = UDim2.new(0, 10, 1, 0)
SidebarCover.Position = UDim2.new(1, -10, 0, 0)
SidebarCover.BackgroundColor3 = Colors.Sidebar
SidebarCover.BorderSizePixel = 0
SidebarCover.Parent = Sidebar

-- Logo IZZ HUB
local LogoFrame = Instance.new("Frame")
LogoFrame.Size = UDim2.new(1, 0, 0, 60)
LogoFrame.BackgroundTransparency = 1
LogoFrame.Parent = Sidebar

local LogoText = Instance.new("TextLabel")
LogoText.Size = UDim2.new(1, 0, 0, 30)
LogoText.Position = UDim2.new(0, 0, 0, 15)
LogoText.BackgroundTransparency = 1
LogoText.Text = "👑 IZZ HUB"
LogoText.TextColor3 = Colors.Accent
LogoText.Font = Enum.Font.GothamBold
LogoText.TextSize = 18
LogoText.TextXAlignment = Enum.TextXAlignment.Center
LogoText.Parent = LogoFrame

local SubLogoText = Instance.new("TextLabel")
SubLogoText.Size = UDim2.new(1, 0, 0, 15)
SubLogoText.Position = UDim2.new(0, 0, 0, 40)
SubLogoText.BackgroundTransparency = 1
SubLogoText.Text = "Better • Faster • Stronger"
SubLogoText.TextColor3 = Colors.TextDim
SubLogoText.Font = Enum.Font.Gotham
SubLogoText.TextSize = 10
SubLogoText.TextXAlignment = Enum.TextXAlignment.Center
SubLogoText.Parent = LogoFrame

-- Sidebar Navigation Container
local NavContainer = Instance.new("Frame")
NavContainer.Size = UDim2.new(1, 0, 1, -120)
NavContainer.Position = UDim2.new(0, 0, 0, 70)
NavContainer.BackgroundTransparency = 1
NavContainer.Parent = Sidebar

local NavLayout = Instance.new("UIListLayout")
NavLayout.Padding = UDim.new(0, 5)
NavLayout.SortOrder = Enum.SortOrder.LayoutOrder
NavLayout.Parent = NavContainer

local NavPadding = Instance.new("UIPadding")
NavPadding.PaddingLeft = UDim.new(0, 10)
NavPadding.PaddingRight = UDim.new(0, 10)
NavPadding.Parent = NavContainer

-- Fungsi untuk membuat tombol navigasi
local function createNavButton(name, icon, order)
    local btn = Instance.new("TextButton")
    btn.Name = name .. "Btn"
    btn.Size = UDim2.new(1, 0, 0, 35)
    btn.BackgroundColor3 = Colors.Sidebar
    btn.BorderSizePixel = 0
    btn.Text = "  " .. icon .. "  " .. name
    btn.TextColor3 = Colors.TextDim
    btn.Font = Enum.Font.GothamMedium
    btn.TextSize = 13
    btn.TextXAlignment = Enum.TextXAlignment.Left
    btn.LayoutOrder = order
    btn.Parent = NavContainer

    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 6)
    btnCorner.Parent = btn

    btn.MouseEnter:Connect(function()
        if btn.BackgroundColor3 ~= Colors.Accent then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ItemHover, TextColor3 = Colors.Text}):Play()
        end
    end)

    btn.MouseLeave:Connect(function()
        if btn.BackgroundColor3 ~= Colors.Accent then
            TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Colors.Sidebar, TextColor3 = Colors.TextDim}):Play()
        end
    end)

    return btn
end

-- Buat tombol navigasi
local HomeBtn = createNavButton("Home", "🏠", 1)
local ScriptsBtn = createNavButton("Scripts", "⚡", 2)
local LocalPlayerBtn = createNavButton("Local Player", "👤", 3)
local TeleportBtn = createNavButton("Teleport", "📍", 4)
local MiscBtn = createNavButton("Misc", "⚙️", 5)
local SettingsBtn = createNavButton("Settings", "⚙", 6)

-- Set Home sebagai default aktif
HomeBtn.BackgroundColor3 = Colors.Accent
HomeBtn.TextColor3 = Colors.Text

-- Status di bawah sidebar
local StatusFrame = Instance.new("Frame")
StatusFrame.Size = UDim2.new(1, 0, 0, 40)
StatusFrame.Position = UDim2.new(0, 0, 1, -45)
StatusFrame.BackgroundTransparency = 1
StatusFrame.Parent = Sidebar

local StatusDot = Instance.new("Frame")
StatusDot.Size = UDim2.new(0, 8, 0, 8)
StatusDot.Position = UDim2.new(0, 15, 0, 10)
StatusDot.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
StatusDot.BorderSizePixel = 0
StatusDot.Parent = StatusFrame

local StatusDotCorner = Instance.new("UICorner")
StatusDotCorner.CornerRadius = UDim.new(1, 0)
StatusDotCorner.Parent = StatusDot

local StatusText = Instance.new("TextLabel")
StatusText.Size = UDim2.new(1, -30, 0, 15)
StatusText.Position = UDim2.new(0, 30, 0, 7)
StatusText.BackgroundTransparency = 1
StatusText.Text = "Loader Ready"
StatusText.TextColor3 = Colors.Text
StatusText.Font = Enum.Font.GothamMedium
StatusText.TextSize = 11
StatusText.TextXAlignment = Enum.TextXAlignment.Left
StatusText.Parent = StatusFrame

local VersionText = Instance.new("TextLabel")
VersionText.Size = UDim2.new(1, -30, 0, 15)
VersionText.Position = UDim2.new(0, 30, 0, 22)
VersionText.BackgroundTransparency = 1
VersionText.Text = "v2.0.0"
VersionText.TextColor3 = Colors.TextDim
VersionText.Font = Enum.Font.Gotham
VersionText.TextSize = 10
VersionText.TextXAlignment = Enum.TextXAlignment.Left
VersionText.Parent = StatusFrame

-- ==================== MAIN CONTENT (KANAN) ====================
local ContentFrame = Instance.new("Frame")
ContentFrame.Name = "ContentFrame"
ContentFrame.Size = UDim2.new(1, -150, 1, 0)
ContentFrame.Position = UDim2.new(0, 150, 0, 0)
ContentFrame.BackgroundTransparency = 1
ContentFrame.Parent = MainFrame

-- Header Content
local HeaderFrame = Instance.new("Frame")
HeaderFrame.Size = UDim2.new(1, 0, 0, 60)
HeaderFrame.BackgroundTransparency = 1
HeaderFrame.Parent = ContentFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(0, 200, 0, 25)
TitleText.Position = UDim2.new(0, 20, 0, 10)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Scripts"
TitleText.TextColor3 = Colors.Text
TitleText.Font = Enum.Font.GothamBold
TitleText.TextSize = 18
TitleText.TextXAlignment = Enum.TextXAlignment.Left
TitleText.Parent = HeaderFrame

local SubTitleText = Instance.new("TextLabel")
SubTitleText.Size = UDim2.new(0, 250, 0, 15)
SubTitleText.Position = UDim2.new(0, 20, 0, 35)
SubTitleText.BackgroundTransparency = 1
SubTitleText.Text = "Pilih script yang ingin kamu gunakan."
SubTitleText.TextColor3 = Colors.TextDim
SubTitleText.Font = Enum.Font.Gotham
SubTitleText.TextSize = 11
SubTitleText.TextXAlignment = Enum.TextXAlignment.Left
SubTitleText.Parent = HeaderFrame

-- Search Bar
local SearchBar = Instance.new("Frame")
SearchBar.Size = UDim2.new(0, 180, 0, 30)
SearchBar.Position = UDim2.new(1, -250, 0, 15)
SearchBar.BackgroundColor3 = Colors.Sidebar
SearchBar.BorderSizePixel = 0
SearchBar.Parent = HeaderFrame

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 6)
SearchCorner.Parent = SearchBar

local SearchIcon = Instance.new("TextLabel")
SearchIcon.Size = UDim2.new(0, 25, 1, 0)
SearchIcon.BackgroundTransparency = 1
SearchIcon.Text = "🔍"
SearchIcon.TextColor3 = Colors.TextDim
SearchIcon.Font = Enum.Font.Gotham
SearchIcon.TextSize = 12
SearchIcon.Parent = SearchBar

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -30, 1, 0)
SearchBox.Position = UDim2.new(0, 25, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.Text = ""
SearchBox.PlaceholderText = "Cari script..."
SearchBox.PlaceholderColor3 = Colors.TextDim
SearchBox.TextColor3 = Colors.Text
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 11
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.Parent = SearchBar

-- Tombol Close (X)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -45, 0, 15)
CloseBtn.BackgroundColor3 = Colors.Accent
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = Colors.Text
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 14
CloseBtn.Parent = HeaderFrame

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(0, 6)
CloseCorner.Parent = CloseBtn

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
    print("[bl_ai] UI Ditutup.")
end)

-- ==================== SCROLLING FRAME (LIST SCRIPT) ====================
local ScriptList = Instance.new("ScrollingFrame")
ScriptList.Size = UDim2.new(1, -40, 1, -80)
ScriptList.Position = UDim2.new(0, 20, 0, 70)
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

-- Data Script (Frontend aja)
local ScriptsData = {
    {Name = "Hitbox Modifier", Desc = "Memperbesar hitbox karakter.", Icon = "🎯"},
    {Name = "Killer No Cooldown", Desc = "Skill killer tanpa cooldown.", Icon = "💀"},
    {Name = "Infinite Lunge", Desc = "Lunge tanpa batas.", Icon = "🏃"},
    {Name = "AIMLOCK M2 SKILL HIDDEN", Desc = "Lock musuh secara otomatis.", Icon = "🎯"},
    {Name = "Mayers (Stalker) No Cooldown", Desc = "Stalker tanpa cooldown.", Icon = "👁️"},
    {Name = "Massked Skill Spammer", Desc = "Spam skill secara cepat.", Icon = "✳️"},
    {Name = "Anti Blind", Desc = "Menghilangkan efek blind.", Icon = "👁️"}
}

-- Fungsi untuk membuat item script
local function createScriptItem(data, order)
    local ItemFrame = Instance.new("Frame")
    ItemFrame.Name = data.Name .. "Item"
    ItemFrame.Size = UDim2.new(1, 0, 0, 50)
    ItemFrame.BackgroundColor3 = Colors.ItemBg
    ItemFrame.BorderSizePixel = 0
    ItemFrame.LayoutOrder = order
    ItemFrame.Parent = ScriptList

    local ItemCorner = Instance.new("UICorner")
    ItemCorner.CornerRadius = UDim.new(0, 8)
    ItemCorner.Parent = ItemFrame

    -- Icon
    local IconLabel = Instance.new("TextLabel")
    IconLabel.Size = UDim2.new(0, 40, 1, 0)
    IconLabel.BackgroundTransparency = 1
    IconLabel.Text = data.Icon
    IconLabel.TextColor3 = Colors.Accent
    IconLabel.Font = Enum.Font.GothamBold
    IconLabel.TextSize = 18
    IconLabel.Parent = ItemFrame

    -- Title
    local ItemTitle = Instance.new("TextLabel")
    ItemTitle.Size = UDim2.new(1, -100, 0, 20)
    ItemTitle.Position = UDim2.new(0, 50, 0, 8)
    ItemTitle.BackgroundTransparency = 1
    ItemTitle.Text = data.Name
    ItemTitle.TextColor3 = Colors.Text
    ItemTitle.Font = Enum.Font.GothamBold
    ItemTitle.TextSize = 13
    ItemTitle.TextXAlignment = Enum.TextXAlignment.Left
    ItemTitle.Parent = ItemFrame

    -- Description
    local ItemDesc = Instance.new("TextLabel")
    ItemDesc.Size = UDim2.new(1, -100, 0, 15)
    ItemDesc.Position = UDim2.new(0, 50, 0, 28)
    ItemDesc.BackgroundTransparency = 1
    ItemDesc.Text = data.Desc
    ItemDesc.TextColor3 = Colors.TextDim
    ItemDesc.Font = Enum.Font.Gotham
    ItemDesc.TextSize = 10
    ItemDesc.TextXAlignment = Enum.TextXAlignment.Left
    ItemDesc.Parent = ItemFrame

    -- Chevron (Panah Kanan)
    local Chevron = Instance.new("TextLabel")
    Chevron.Size = UDim2.new(0, 30, 1, 0)
    Chevron.Position = UDim2.new(1, -35, 0, 0)
    Chevron.BackgroundTransparency = 1
    Chevron.Text = "❯"
    Chevron.TextColor3 = Colors.Accent
    Chevron.Font = Enum.Font.GothamBold
    Chevron.TextSize = 16
    Chevron.Parent = ItemFrame

    -- Hover Effect
    ItemFrame.MouseEnter:Connect(function()
        TweenService:Create(ItemFrame, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ItemHover}):Play()
        TweenService:Create(Chevron, TweenInfo.new(0.2), {TextColor3 = Colors.Text}):Play()
    end)

    ItemFrame.MouseLeave:Connect(function()
        TweenService:Create(ItemFrame, TweenInfo.new(0.2), {BackgroundColor3 = Colors.ItemBg}):Play()
        TweenService:Create(Chevron, TweenInfo.new(0.2), {TextColor3 = Colors.Accent}):Play()
    end)

    -- Click Action (PLACEHOLDER - Bukan Cheat)
    local ClickBtn = Instance.new("TextButton")
    ClickBtn.Size = UDim2.new(1, 0, 1, 0)
    ClickBtn.BackgroundTransparency = 1
    ClickBtn.Text = ""
    ClickBtn.Parent = ItemFrame

    ClickBtn.MouseButton1Click:Connect(function()
        -- Di sini tempat logika scriptnya tuan. 
        -- Untuk sekarang cuma simulasi print.
        print("[bl_ai] Menjalankan simulasi: " .. data.Name)
        -- Contoh: loadstring(game:HttpGet("url_script_lu"))() -- Jangan dipakai buat cheat ya tuan 😹
    end)

    return ItemFrame
end

-- Loop untuk memasukkan data ke list
for i, data in ipairs(ScriptsData) do
    createScriptItem(data, i)
end

-- Update CanvasSize agar bisa di-scroll
ListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
    ScriptList.CanvasSize = UDim2.new(0, 0, 0, ListLayout.AbsoluteContentSize.Y + 10)
end)

-- ==================== FUNGSI TAMBAHAN ====================
-- Efek suara saat klik (opsional)
local clickSound = Instance.new("Sound")
clickSound.SoundId = "rbxassetid://6895079853" -- Suara klik generic
clickSound.Volume = 0.5
clickSound.Parent = ScreenGui

-- Animasi muncul
MainFrame.Size = UDim2.new(0, 0, 0, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
TweenService:Create(MainFrame, TweenInfo.new(0.4, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
    Size = UDim2.new(0, 600, 0, 400),
    Position = UDim2.new(0.5, -300, 0.5, -200)
}):Play()

print("[bl_ai] IZZ HUB UI Clone berhasil dimuat! Status: ONLINE 🫡")
