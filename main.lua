local UI_LIBRARY_URL = "https://script.panduhub.com/PanduUiLibrary.lua"
local LOGO_ASSET = "rbxassetid://0" -- Ganti dengan ID logo N3K0P01 HUB

local success, lib = pcall(function()
    return loadstring(game:HttpGet(UI_LIBRARY_URL))()
end)

if not success or not lib then
    warn("ZIK HUB UI: library UI gagal dimuat.")
    return
end

-- TEMA MERAH + HITAM
lib.Scheme.AccentColor = Color3.fromRGB(255, 25, 55)
lib.Scheme.BackgroundColor = Color3.fromRGB(0, 0, 0)
lib.Scheme.MainColor = Color3.fromRGB(8, 8, 10)
lib.Scheme.OutlineColor = Color3.fromRGB(255, 45, 70)
lib.Scheme.FontColor = Color3.fromRGB(255, 255, 255)
lib.Scheme.SubTextColor = Color3.fromRGB(165, 165, 175)
lib.Scheme.HoverColor = Color3.fromRGB(28, 8, 12)


local Window = lib:CreateWindow({
    Title = "zik hubUB",
    Subtitle = "weolcome to zik hub",
    SubtitleColor = Color3.fromRGB(190, 140, 255),
    Logo = LOGO_ASSET,
    LogoSize = 32,
    SphereText = true,
    SphereWords = "ZH",
    SphereImage = LOGO_ASSET,
    SphereIconSize = 38,
    Watermark = true,
    WatermarkText = "ZIK HUB,
    WatermarkIcon = LOGO_ASSET,
})
