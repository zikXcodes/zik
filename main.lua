-- =====================================================
-- IZZ HUB · v2.0.0 (Roblox Lua)
-- UI 1:1 dari desain foto
-- LocalScript (ScreenGui)
-- =====================================================

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local GuiService = game:GetService("GuiService")

-- Buat ScreenGui utama
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "IZZ_HUB"
screenGui.Parent = Player:WaitForChild("PlayerGui")
screenGui.ResetOnSpawn = false

-- =====================================================
-- MAIN CONTAINER (Frame)
-- =====================================================
local container = Instance.new("Frame")
container.Name = "Container"
container.Size = UDim2.new(0, 560, 0, 640)
container.Position = UDim2.new(0.5, -280, 0.5, -320)
container.BackgroundColor3 = Color3.fromRGB(18, 24, 34)
container.BackgroundTransparency = 0.15
container.BorderSizePixel = 0
container.ClipsDescendants = true
container.Parent = screenGui

-- Efek blur (gunakan BackgroundTransparency + layer, atau pakai ImageLabel dengan blur? Kita pakai Background + Corner)
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 32)
corner.Parent = container

-- Stroke halus (Border)
local stroke = Instance.new("UIStroke")
stroke.Color = Color3.fromRGB(255, 255, 255)
stroke.Transparency = 0.96
stroke.Thickness = 1
stroke.Parent = container

-- Shadow (pakai UIShadow)
local shadow = Instance.new("UIShadow")
shadow.Size = UDim.new(0, 30)
shadow.Offset = Vector2.new(0, 8)
shadow.Color = Color3.fromRGB(0, 0, 0)
shadow.Transparency = 0.6
shadow.Parent = container

-- =====================================================
-- HEADER
-- =====================================================
local header = Instance.new("Frame")
header.Name = "Header"
header.Size = UDim2.new(1, -20, 0, 72)
header.Position = UDim2.new(0, 10, 0, 10)
header.BackgroundTransparency = 1
header.Parent = container

-- Title Group
local titleGroup = Instance.new("Frame")
titleGroup.Size = UDim2.new(0, 200, 1, 0)
titleGroup.BackgroundTransparency = 1
titleGroup.Parent = header

local title = Instance.new("TextLabel")
title.Text = "IZZ HUB"
title.TextColor3 = Color3.fromRGB(160, 240, 255)
title.TextScaled = false
title.TextSize = 28
title.Font = Enum.Font.GothamBold
title.Size = UDim2.new(1, 0, 0.6, 0)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleGroup

-- Gradient effect (pakai TextLabel dengan gradient? Kita bisa pakai UIGradient pada teks? Tidak langsung. Kita buat manual dengan dua label? Sederhana: kita pakai warna solid tapi lebih keren dengan gradient di background? Saya akan buat efek glow dengan shadow)
local glow = Instance.new("UIGradient")
glow.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(160, 240, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(91, 192, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(59, 140, 255))
})
-- Tapi TextLabel tidak support UIGradient langsung. Kita bisa pakai ImageLabel untuk teks? Atau kita tetap pakai warna solid dengan shadow. Saya akan buat warna solid.

-- Subtitle
local subtitle = Instance.new("TextLabel")
subtitle.Text = "Better - Faster - Stronger"
subtitle.TextColor3 = Color3.fromRGB(142, 164, 201)
subtitle.TextSize = 14
subtitle.Font = Enum.Font.GothamMedium
subtitle.Size = UDim2.new(1, 0, 0.4, 0)
subtitle.Position = UDim2.new(0, 0, 0.6, 0)
subtitle.BackgroundTransparency = 1
subtitle.TextXAlignment = Enum.TextXAlignment.Left
subtitle.Parent = titleGroup

-- Loader Status (kanan atas)
local loader = Instance.new("Frame")
loader.Size = UDim2.new(0, 150, 0, 34)
loader.Position = UDim2.new(1, -160, 0, 18)
loader.BackgroundColor3 = Color3.fromRGB(0, 255, 170)
loader.BackgroundTransparency = 0.94
loader.BorderSizePixel = 0
loader.Parent = header

local loaderCorner = Instance.new("UICorner")
loaderCorner.CornerRadius = UDim.new(0, 40)
loaderCorner.Parent = loader

local loaderStroke = Instance.new("UIStroke")
loaderStroke.Color = Color3.fromRGB(0, 255, 170)
loaderStroke.Transparency = 0.85
loaderStroke.Thickness = 1
loaderStroke.Parent = loader

local loaderIcon = Instance.new("TextLabel")
loaderIcon.Text = "●"
loaderIcon.TextColor3 = Color3.fromRGB(107, 255, 184)
loaderIcon.TextSize = 18
loaderIcon.Size = UDim2.new(0, 20, 1, 0)
loaderIcon.Position = UDim2.new(0, 8, 0, 0)
loaderIcon.BackgroundTransparency = 1
loaderIcon.TextXAlignment = Enum.TextXAlignment.Center
loaderIcon.Parent = loader

local loaderText = Instance.new("TextLabel")
loaderText.Text = "Loader Ready"
loaderText.TextColor3 = Color3.fromRGB(107, 255, 184)
loaderText.TextSize = 13
loaderText.Font = Enum.Font.GothamBold
loaderText.Size = UDim2.new(1, -30, 1, 0)
loaderText.Position = UDim2.new(0, 30, 0, 0)
loaderText.BackgroundTransparency = 1
loaderText.TextXAlignment = Enum.TextXAlignment.Left
loaderText.Parent = loader

local versionText = Instance.new("TextLabel")
versionText.Text = "v2.0.0"
versionText.TextColor3 = Color3.fromRGB(255, 255, 255)
versionText.TextSize = 11
versionText.Font = Enum.Font.GothamMedium
versionText.Size = UDim2.new(0, 50, 1, 0)
versionText.Position = UDim2.new(1, -55, 0, 0)
versionText.BackgroundTransparency = 1
versionText.TextXAlignment = Enum.TextXAlignment.Right
versionText.TextTransparency = 0.5
versionText.Parent = loader

-- =====================================================
-- NAVIGATION
-- =====================================================
local nav = Instance.new("Frame")
nav.Name = "Navigation"
nav.Size = UDim2.new(1, -20, 0, 48)
nav.Position = UDim2.new(0, 10, 0, 92)
nav.BackgroundTransparency = 1
nav.Parent = container

-- Item navigasi (daftar)
local navItems = {"Home", "Scripts", "Local Player", "Teleport", "Misc", "Settings"}
local navButtons = {}
local activeNav = "Home" -- default

local function createNavButton(text, index)
    local btn = Instance.new("TextButton")
    btn.Name = text
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(138, 155, 189)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamSemibold
    btn.Size = UDim2.new(0, 0, 1, 0) -- akan diatur manual
    btn.BackgroundTransparency = 1
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Parent = nav

    -- padding horizontal otomatis? Kita atur dengan UIPadding? Lebih mudah kita buat layout dengan UIGridLayout atau manual.
    -- Kita gunakan manual dengan perhitungan.
    return btn
end

-- Karena kita perlu layout horizontal, kita buat dengan UIPadding dan pakai UIGridLayout? Atau kita hitung posisi.
-- Saya akan gunakan UIGridLayout dengan FillDirection = Horizontal.
local gridLayout = Instance.new("UIGridLayout")
gridLayout.FillDirection = Enum.FillDirection.Horizontal
gridLayout.HorizontalAlignment = Enum.HorizontalAlignment.Left
gridLayout.VerticalAlignment = Enum.VerticalAlignment.Center
gridLayout.CellSize = UDim2.new(0, 0, 1, 0) -- auto
gridLayout.CellPadding = UDim2.new(0, 4, 0, 0)
gridLayout.Parent = nav

-- Buat tombol
for i, name in ipairs(navItems) do
    local btn = Instance.new("TextButton")
    btn.Name = name
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(138, 155, 189)
    btn.TextSize = 14
    btn.Font = Enum.Font.GothamSemibold
    btn.Size = UDim2.new(0, 0, 1, 0) -- auto
    btn.BackgroundTransparency = 1
    btn.BorderSizePixel = 0
    btn.AutoButtonColor = false
    btn.Parent = nav

    -- padding
    local pad = Instance.new("UIPadding")
    pad.PaddingLeft = UDim.new(0, 14)
    pad.PaddingRight = UDim.new(0, 14)
    pad.Parent = btn

    -- Corner untuk efek hover/aktif
    local cornerBtn = Instance.new("UICorner")
    cornerBtn.CornerRadius = UDim.new(0, 40)
    cornerBtn.Parent = btn

    -- Simpan referensi
    navButtons[name] = btn

    -- Event klik
    btn.MouseButton1Click:Connect(function()
        -- Set aktif
        for _, b in pairs(navButtons) do
            b.BackgroundTransparency = 1
            b.TextColor3 = Color3.fromRGB(138, 155, 189)
            b.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            b.BackgroundTransparency = 1
        end
        btn.BackgroundTransparency = 0.88
        btn.BackgroundColor3 = Color3.fromRGB(91, 192, 255)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
        -- Tampilkan konten sesuai
        showContent(name)
    end)
end

-- Default aktif: Home
local function setActiveNav(name)
    for _, b in pairs(navButtons) do
        b.BackgroundTransparency = 1
        b.TextColor3 = Color3.fromRGB(138, 155, 189)
        b.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    end
    local btn = navButtons[name]
    if btn then
        btn.BackgroundTransparency = 0.88
        btn.BackgroundColor3 = Color3.fromRGB(91, 192, 255)
        btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    end
end

-- =====================================================
-- CONTENT AREA (berubah sesuai nav)
-- =====================================================
local contentArea = Instance.new("Frame")
contentArea.Name = "Content"
contentArea.Size = UDim2.new(1, -20, 1, -160)
contentArea.Position = UDim2.new(0, 10, 0, 148)
contentArea.BackgroundTransparency = 1
contentArea.ClipsDescendants = true
contentArea.Parent = container

-- Kita buat beberapa panel untuk tiap halaman, tapi kita hanya akan fokus ke "Scripts" karena di foto itu isinya.
-- Untuk demo, saya buat panel dinamis.

local contentPanels = {}

-- Fungsi untuk membuat panel kosong
local function createPanel(name)
    local panel = Instance.new("Frame")
    panel.Name = name .. "Panel"
    panel.Size = UDim2.new(1, 0, 1, 0)
    panel.BackgroundTransparency = 1
    panel.Visible = false
    panel.Parent = contentArea
    return panel
end

-- Panel Home
local homePanel = createPanel("Home")
local homeTitle = Instance.new("TextLabel")
homeTitle.Text = "Selamat datang di IZZ HUB"
homeTitle.TextColor3 = Color3.fromRGB(240, 246, 255)
homeTitle.TextSize = 22
homeTitle.Font = Enum.Font.GothamBold
homeTitle.Size = UDim2.new(1, 0, 0.2, 0)
homeTitle.BackgroundTransparency = 1
homeTitle.Parent = homePanel

local homeDesc = Instance.new("TextLabel")
homeDesc.Text = "Pilih menu di navigasi untuk mengakses fitur."
homeDesc.TextColor3 = Color3.fromRGB(122, 140, 180)
homeDesc.TextSize = 16
homeDesc.Font = Enum.Font.GothamMedium
homeDesc.Size = UDim2.new(1, 0, 0.2, 0)
homeDesc.Position = UDim2.new(0, 0, 0.3, 0)
homeDesc.BackgroundTransparency = 1
homeDesc.Parent = homePanel

-- Panel Scripts (yang utama)
local scriptsPanel = createPanel("Scripts")

-- Title Scripts
local scriptsTitle = Instance.new("TextLabel")
scriptsTitle.Text = "Scripts"
scriptsTitle.TextColor3 = Color3.fromRGB(240, 246, 255)
scriptsTitle.TextSize = 22
scriptsTitle.Font = Enum.Font.GothamBold
scriptsTitle.Size = UDim2.new(1, 0, 0.1, 0)
scriptsTitle.BackgroundTransparency = 1
scriptsTitle.TextXAlignment = Enum.TextXAlignment.Left
scriptsTitle.Parent = scriptsPanel

local scriptsDesc = Instance.new("TextLabel")
scriptsDesc.Text = "Pilih script yang ingin kamu gunakan."
scriptsDesc.TextColor3 = Color3.fromRGB(122, 140, 180)
scriptsDesc.TextSize = 14
scriptsDesc.Font = Enum.Font.GothamMedium
scriptsDesc.Size = UDim2.new(1, 0, 0.08, 0)
scriptsDesc.Position = UDim2.new(0, 0, 0.12, 0)
scriptsDesc.BackgroundTransparency = 1
scriptsDesc.TextXAlignment = Enum.TextXAlignment.Left
scriptsDesc.Parent = scriptsPanel

-- Daftar script (list)
local scriptList = {
    {name = "Hitbox Modifier", desc = "Memperbesar hitbox karakter."},
    {name = "Killer No Cooldown", desc = "Skill killer tanpa cooldown."},
    {name = "Infinite Lunge", desc = "Lunge tanpa batas."},
    {name = "AIMLOCK M2 SKILL HIDDEN", desc = "Lock musuh secara otomatis."},
    {name = "Mayers (Stalker) No Cooldown", desc = "Stalker tanpa cooldown."},
    {name = "Massked Skill Spammer", desc = "Spam skill secara cepat."},
    {name = "Anti Blind", desc = "Menghilangkan efek blind."}
}

local listContainer = Instance.new("ScrollingFrame")
listContainer.Size = UDim2.new(1, 0, 0.8, 0)
listContainer.Position = UDim2.new(0, 0, 0.22, 0)
listContainer.BackgroundTransparency = 1
listContainer.BorderSizePixel = 0
listContainer.ScrollBarThickness = 4
listContainer.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right
listContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
listContainer.Parent = scriptsPanel

-- Layout list
local listLayout = Instance.new("UIListLayout")
listLayout.FillDirection = Enum.FillDirection.Vertical
listLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
listLayout.VerticalAlignment = Enum.VerticalAlignment.Top
listLayout.Padding = UDim.new(0, 8)
listLayout.Parent = listContainer

-- Buat item script
local scriptButtons = {}
for i, data in ipairs(scriptList) do
    local item = Instance.new("TextButton")
    item.Name = data.name
    item.Size = UDim2.new(1, -10, 0, 50)
    item.BackgroundColor3 = Color3.fromRGB(30, 40, 56)
    item.BackgroundTransparency = 0.8
    item.BorderSizePixel = 0
    item.Text = ""
    item.AutoButtonColor = false
    item.Parent = listContainer

    local cornerItem = Instance.new("UICorner")
    cornerItem.CornerRadius = UDim.new(0, 12)
    cornerItem.Parent = item

    -- Label nama
    local nameLabel = Instance.new("TextLabel")
    nameLabel.Text = data.name
    nameLabel.TextColor3 = Color3.fromRGB(220, 235, 255)
    nameLabel.TextSize = 16
    nameLabel.Font = Enum.Font.GothamSemibold
    nameLabel.Size = UDim2.new(0.7, 0, 1, 0)
    nameLabel.Position = UDim2.new(0.05, 0, 0, 0)
    nameLabel.BackgroundTransparency = 1
    nameLabel.TextXAlignment = Enum.TextXAlignment.Left
    nameLabel.Parent = item

    -- Deskripsi (small)
    local descLabel = Instance.new("TextLabel")
    descLabel.Text = data.desc
    descLabel.TextColor3 = Color3.fromRGB(160, 180, 210)
    descLabel.TextSize = 12
    descLabel.Font = Enum.Font.GothamMedium
    descLabel.Size = UDim2.new(0.7, 0, 0.4, 0)
    descLabel.Position = UDim2.new(0.05, 0, 0.6, 0)
    descLabel.BackgroundTransparency = 1
    descLabel.TextXAlignment = Enum.TextXAlignment.Left
    descLabel.Parent = item

    -- Tombol aksi (misal toggle)
    local actionBtn = Instance.new("TextButton")
    actionBtn.Text = "Load"
    actionBtn.TextColor3 = Color3.fromRGB(0, 200, 255)
    actionBtn.TextSize = 13
    actionBtn.Font = Enum.Font.GothamBold
    actionBtn.Size = UDim2.new(0, 70, 0, 30)
    actionBtn.Position = UDim2.new(1, -85, 0.5, -15)
    actionBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 255)
    actionBtn.BackgroundTransparency = 0.9
    actionBtn.BorderSizePixel = 0
    actionBtn.Parent = item

    local cornerAction = Instance.new("UICorner")
    cornerAction.CornerRadius = UDim.new(0, 8)
    cornerAction.Parent = actionBtn

    -- Event klik load
    actionBtn.MouseButton1Click:Connect(function()
        print("Loading script: " .. data.name)
        -- Di sini Tuan bisa tambahkan fungsi load script
    end)

    -- Hover effect pada item
    item.MouseEnter:Connect(function()
        item.BackgroundTransparency = 0.5
    end)
    item.MouseLeave:Connect(function()
        item.BackgroundTransparency = 0.8
    end)

    scriptButtons[data.name] = item
end

-- Update CanvasSize
listContainer.CanvasSize = UDim2.new(0, 0, 0, #scriptList * 58 + 10)

-- Panel lain (Local Player, Teleport, Misc, Settings) - kita buat sederhana
local function createGenericPanel(name, desc)
    local panel = createPanel(name)
    local title = Instance.new("TextLabel")
    title.Text = name
    title.TextColor3 = Color3.fromRGB(240, 246, 255)
    title.TextSize = 22
    title.Font = Enum.Font.GothamBold
    title.Size = UDim2.new(1, 0, 0.1, 0)
    title.BackgroundTransparency = 1
    title.Parent = panel

    local descLabel = Instance.new("TextLabel")
    descLabel.Text = desc or "Fitur ini sedang dalam pengembangan."
    descLabel.TextColor3 = Color3.fromRGB(122, 140, 180)
    descLabel.TextSize = 14
    descLabel.Font = Enum.Font.GothamMedium
    descLabel.Size = UDim2.new(1, 0, 0.2, 0)
    descLabel.Position = UDim2.new(0, 0, 0.15, 0)
    descLabel.BackgroundTransparency = 1
    descLabel.Parent = panel
    return panel
end

createGenericPanel("Local Player", "Pengaturan karakter pemain.")
createGenericPanel("Teleport", "Teleportasi ke lokasi tertentu.")
createGenericPanel("Misc", "Fitur tambahan lainnya.")
createGenericPanel("Settings", "Konfigurasi hub.")

-- =====================================================
-- SEARCH BAR (di bawah list? Di foto ada "Cari script..." di bagian bawah. Kita taruh di bawah list di panel Scripts)
-- =====================================================
local searchFrame = Instance.new("Frame")
searchFrame.Size = UDim2.new(1, -20, 0, 40)
searchFrame.Position = UDim2.new(0, 10, 1, -50)
searchFrame.BackgroundColor3 = Color3.fromRGB(20, 30, 45)
searchFrame.BackgroundTransparency = 0.6
searchFrame.BorderSizePixel = 0
searchFrame.Parent = scriptsPanel

local searchCorner = Instance.new("UICorner")
searchCorner.CornerRadius = UDim.new(0, 20)
searchCorner.Parent = searchFrame

local searchIcon = Instance.new("TextLabel")
searchIcon.Text = "🔍"
searchIcon.TextColor3 = Color3.fromRGB(150, 170, 200)
searchIcon.TextSize = 18
searchIcon.Size = UDim2.new(0, 30, 1, 0)
searchIcon.BackgroundTransparency = 1
searchIcon.TextXAlignment = Enum.TextXAlignment.Center
searchIcon.Parent = searchFrame

local searchBox = Instance.new("TextBox")
searchBox.Text = "Cari script..."
searchBox.TextColor3 = Color3.fromRGB(200, 215, 240)
searchBox.TextSize = 15
searchBox.Font = Enum.Font.GothamMedium
searchBox.Size = UDim2.new(1, -40, 1, 0)
searchBox.Position = UDim2.new(0, 35, 0, 0)
searchBox.BackgroundTransparency = 1
searchBox.BorderSizePixel = 0
searchBox.ClearTextOnFocus = false
searchBox.Parent = searchFrame

-- Fungsi filter (sederhana)
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = searchBox.Text:lower()
    for name, btn in pairs(scriptButtons) do
        local visible = name:lower():find(query) ~= nil
        btn.Visible = visible
    end
    -- update canvas setelah filter
    local visibleCount = 0
    for _, btn in pairs(scriptButtons) do
        if btn.Visible then visibleCount = visibleCount + 1 end
    end
    listContainer.CanvasSize = UDim2.new(0, 0, 0, visibleCount * 58 + 10)
end)

-- =====================================================
-- FUNGSI SHOW CONTENT
-- =====================================================
function showContent(name)
    for _, panel in pairs(contentPanels) do
        panel.Visible = false
    end
    local panelName = name .. "Panel"
    local panel = contentArea:FindFirstChild(panelName)
    if panel then
        panel.Visible = true
    else
        -- fallback: home
        homePanel.Visible = true
    end
    setActiveNav(name)
end

-- Daftarkan panel ke contentPanels
for _, child in pairs(contentArea:GetChildren()) do
    if child:IsA("Frame") then
        contentPanels[child.Name] = child
    end
end

-- Default tampilkan Home
showContent("Home")

-- =====================================================
-- DRAG (biar bisa dipindah)
-- =====================================================
local dragging = false
local dragInput, dragStart, startPos

container.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = container.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

container.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        container.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- ========================================
-- CLOSE BUTTON (pojok kanan atas)
-- ========================================
local closeBtn = Instance.new("TextButton")
closeBtn.Text = "✕"
closeBtn.TextColor3 = Color3.fromRGB(200, 200, 200)
closeBtn.TextSize = 20
closeBtn.Font = Enum.Font.GothamBold
closeBtn.Size = UDim2.new(0, 32, 0, 32)
closeBtn.Position = UDim2.new(1, -42, 0, 10)
closeBtn.BackgroundTransparency = 1
closeBtn.BorderSizePixel = 0
closeBtn.Parent = container

closeBtn.MouseButton1Click:Connect(function()
    screenGui.Enabled = false  -- Tutup GUI
end)

-- ========================================
-- SELESAI
-- ========================================
print("IZZ HUB v2.0.0 loaded successfully!")
