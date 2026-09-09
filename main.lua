-- ============================================================
-- IZZ HUB · WindUI · Red Crimson Theme
-- LocalScript (StarterGui atau PlayerGui)
-- ============================================================

local Players = game:GetService("Players")
local Player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- ============================================================
-- CEK KETERSEDIAAN WINDUI
-- ============================================================
local WindUIModule = ReplicatedStorage:FindFirstChild("WindUI")
if not WindUIModule then
    warn("[IZZ HUB] WindUI not found! Please install WindUI in ReplicatedStorage.")
    return
end
local WindUI = require(WindUIModule)

-- ============================================================
-- TEMA RED CRIMSON (palet kustom)
-- ============================================================
local crimsonTheme = {
    -- Warna dasar
    Background = Color3.fromRGB(20, 8, 8),       -- hitam kemerahan
    Background2 = Color3.fromRGB(35, 14, 14),    -- merah gelap
    Background3 = Color3.fromRGB(55, 22, 22),    -- merah sedang
    Background4 = Color3.fromRGB(75, 30, 30),    -- untuk hover

    -- Teks
    Text = Color3.fromRGB(255, 235, 235),        -- putih kemerahan
    Text2 = Color3.fromRGB(210, 180, 180),       -- abu kemerahan
    Text3 = Color3.fromRGB(160, 130, 130),       -- lebih redup

    -- Aksen crimson
    Accent = Color3.fromRGB(220, 20, 60),        -- #DC143C
    Accent2 = Color3.fromRGB(180, 10, 40),       -- lebih gelap
    Accent3 = Color3.fromRGB(255, 60, 100),      -- lebih terang (hover)

    -- Border & shadow
    Border = Color3.fromRGB(120, 20, 30),
    Shadow = Color3.fromRGB(0, 0, 0),
}

-- Terapkan tema ke WindUI (global)
WindUI.Theme:SetTheme(crimsonTheme)

-- ============================================================
-- BUAT WINDOW UTAMA
-- ============================================================
local mainWindow = WindUI:CreateWindow({
    Title = "IZZ HUB · Crimson",
    SubTitle = "Better - Faster - Stronger",
    Size = UDim2.new(0, 580, 0, 660),
    Position = UDim2.new(0.5, -290, 0.5, -330),
    Theme = crimsonTheme,          -- tema khusus window ini
    Draggable = true,
    Resizable = false,
    CloseButton = true,
    MinimizeButton = false,
})

-- ============================================================
-- TAB / NAVIGASI
-- ============================================================
local tabs = {
    Home = mainWindow:CreateTab({ Name = "Home", Icon = "🏠" }),
    Scripts = mainWindow:CreateTab({ Name = "Scripts", Icon = "📜" }),
    Player = mainWindow:CreateTab({ Name = "Local Player", Icon = "👤" }),
    Teleport = mainWindow:CreateTab({ Name = "Teleport", Icon = "📍" }),
    Misc = mainWindow:CreateTab({ Name = "Misc", Icon = "⚙️" }),
    Settings = mainWindow:CreateTab({ Name = "Settings", Icon = "🔧" }),
}

-- ============================================================
-- HOME TAB
-- ============================================================
local homeSection = tabs.Home:CreateSection({ Name = "Selamat Datang" })
homeSection:CreateLabel({
    Text = "Ini adalah IZZ HUB dengan tema Red Crimson.",
    TextColor = crimsonTheme.Text2,
})
homeSection:CreateLabel({
    Text = "Pilih tab di atas untuk mengakses fitur.",
    TextColor = crimsonTheme.Text2,
})
homeSection:CreateButton({
    Name = "Test Button",
    Text = "Klik Saya!",
    Color = crimsonTheme.Accent,
    OnClick = function()
        WindUI:Notify({
            Title = "Test",
            Description = "Tombol berfungsi!",
            Duration = 2,
            Theme = crimsonTheme,
        })
    end
})

-- ============================================================
-- SCRIPTS TAB (daftar script dengan list dan search)
-- ============================================================
local scriptSection = tabs.Scripts:CreateSection({ Name = "Daftar Script" })

-- Daftar script (sama seperti sebelumnya)
local scriptList = {
    { name = "Hitbox Modifier", desc = "Memperbesar hitbox karakter." },
    { name = "Killer No Cooldown", desc = "Skill killer tanpa cooldown." },
    { name = "Infinite Lunge", desc = "Lunge tanpa batas." },
    { name = "AIMLOCK M2 SKILL HIDDEN", desc = "Lock musuh secara otomatis." },
    { name = "Mayers (Stalker) No Cooldown", desc = "Stalker tanpa cooldown." },
    { name = "Massked Skill Spammer", desc = "Spam skill secara cepat." },
    { name = "Anti Blind", desc = "Menghilangkan efek blind." }
}

-- Buat list dengan scrolling
local scriptListGroup = scriptSection:CreateList({
    Name = "ScriptList",
    Size = UDim2.new(1, -20, 0, 360),
    BackgroundColor = crimsonTheme.Background2,
    BorderColor = crimsonTheme.Border,
})

-- Tambahkan item ke list
for _, data in ipairs(scriptList) do
    local item = scriptListGroup:CreateItem({
        Name = data.name,
        Text = data.name,
        Description = data.desc,
        Icon = "📌",
        IconColor = crimsonTheme.Accent,
        Button = {
            Text = "Load",
            Color = crimsonTheme.Accent,
            OnClick = function()
                print("Loading script: " .. data.name)
                -- Di sini Tuan bisa tambahkan logika load script
                WindUI:Notify({
                    Title = "Load Script",
                    Description = "Memuat: " .. data.name,
                    Duration = 2,
                    Theme = crimsonTheme,
                })
            end
        }
    })
end

-- Search box (di bawah list)
local searchBox = scriptSection:CreateTextBox({
    Name = "Search",
    Placeholder = "Cari script...",
    Size = UDim2.new(1, -20, 0, 36),
    Position = UDim2.new(0, 10, 1, -46),
    BackgroundColor = crimsonTheme.Background3,
    TextColor = crimsonTheme.Text,
    PlaceholderColor = crimsonTheme.Text3,
    BorderColor = crimsonTheme.Border,
    ClearButton = true,
})

-- Fungsi filter
searchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = searchBox.Text:lower()
    for _, item in pairs(scriptListGroup:GetItems()) do
        local visible = item.Text:lower():find(query) ~= nil
        item:SetVisible(visible)
    end
end)

-- ============================================================
-- TAB LAIN (Local Player, Teleport, Misc, Settings)
-- ============================================================
local function createSimpleTab(tab, title, desc)
    local section = tab:CreateSection({ Name = title })
    section:CreateLabel({ Text = desc, TextColor = crimsonTheme.Text2 })
    -- Contoh tambahan toggle
    section:CreateToggle({
        Name = "Toggle " .. title,
        Text = "Aktifkan fitur",
        Default = false,
        OnToggle = function(state)
            print(title .. " toggle state: " .. tostring(state))
        end
    })
end

createSimpleTab(tabs.Player, "Local Player", "Pengaturan karakter pemain.")
createSimpleTab(tabs.Teleport, "Teleport", "Teleportasi ke lokasi tertentu.")
createSimpleTab(tabs.Misc, "Misc", "Fitur tambahan lainnya.")
createSimpleTab(tabs.Settings, "Settings", "Konfigurasi hub.")

-- ============================================================
-- NOTIFIKASI AWAL
-- ============================================================
WindUI:Notify({
    Title = "IZZ HUB",
    Description = "Loaded with Red Crimson theme!",
    Duration = 3,
    Theme = crimsonTheme,
})

-- ============================================================
-- SELESAI
-- ============================================================
print("IZZ HUB · WindUI · Red Crimson loaded successfully!")
