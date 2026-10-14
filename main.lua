--[[
    ZIK HUB
    Dibuat dari struktur tampilan OXio Hub yang diberikan.
    File ini hanya membuat window, tab, section, dan kontrol UI.
    Semua kontrol memakai callback kosong: TIDAK ada fitur gameplay yang dijalankan.

    Catatan:
    - LOGO_ASSET bisa diganti dengan ID logo N3K0P01 HUB milikmu.
    - Nama kontrol dipertahankan sebagai placeholder tampilan.
    - Hubungkan callback kontrol ke script milikmu sendiri jika diperlukan.
]]

local UI_LIBRARY_URL = "https://script.panduhub.com/PanduUiLibrary.lua"
local LOGO_ASSET = "rbxassetid://0" -- Ganti dengan ID logo N3K0P01 HUB

local success, lib = pcall(function()
    return loadstring(game:HttpGet(UI_LIBRARY_URL))()
end)

if not success or not lib then
    warn("N3K0P01 HUB UI: library UI gagal dimuat.")
    return
end

-- Tema visual diambil dari tampilan sumber, dengan branding N3K0P01 HUB.
lib.Scheme.AccentColor = Color3.fromRGB(190, 140, 255)
lib.Scheme.BackgroundColor = Color3.fromRGB(10, 10, 12)
lib.Scheme.MainColor = Color3.fromRGB(16, 16, 18)
lib.Scheme.OutlineColor = Color3.fromRGB(255, 255, 255)
lib.Scheme.FontColor = Color3.fromRGB(235, 235, 240)
lib.Scheme.SubTextColor = Color3.fromRGB(140, 140, 150)
lib.Scheme.HoverColor = Color3.fromRGB(22, 22, 26)

local Window = lib:CreateWindow({
    Title = "ZIK HUB",
    Subtitle = "WELCOME TO ZIK HUB",
    SubtitleColor = Color3.fromRGB(190, 140, 255),
    Logo = LOGO_ASSET,
    LogoSize = 32,
    SphereText = true,
    SphereWords = "N3",
    SphereImage = LOGO_ASSET,
    SphereIconSize = 38,
    Watermark = true,
    WatermarkText = "ZIK HUB",
    WatermarkIcon = LOGO_ASSET,
})
