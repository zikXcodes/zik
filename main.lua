--[[
    Script: Burgerz Automation Hub
    UI: Urban UI Library (Red Theme)
    Fitur: Kill Aura (NPC, Cop, Customer), Auto Serve, Auto Task
]]

-- 1. Load Urban UI Library
local WIND = loadstring(game:HttpGet("https://raw.githubusercontent.com/vortex-py/Urban-Ui-Library/refs/heads/main/load-ui.lua"))()

-- 2. Buat Window Utama
local Window = WIND:CreateWindow({
    Title = "BURGERZ HUB",
    SubTitle = "by AI Assistant",
    Size = UDim2.new(0, 520, 0, 350),
    Icon = "rbxassetid://80788381547970",
    FloatIcon = "rbxassetid://80788381547970",
    FloatIconSize = 36
})

-- 3. Buat Tabs
local MainTab = Window:CreateTab("Utama")
local AutoTab = Window:CreateTab("Auto")
local AuraTab = Window:CreateTab("Kill Aura")

-- ==================== TAB UTAMA ====================
local MainSec = MainTab:AddSection("Informasi")

MainSec:AddParagraph("Selamat Datang", "Aktifkan fitur di tab Auto dan Kill Aura. Gunakan tombol Panic untuk mematikan semua fitur.")

MainSec:AddButton("Panic (Matikan Semua)", function()
    -- Matikan semua flag
    getgenv().AutoServe = false
    getgenv().AutoTask = false
    getgenv().AuraNPC = false
    getgenv().AuraCop = false
    getgenv().AuraCustomer = false
    WIND:Notify({
        Title = "Panic",
        Content = "Semua fitur dimatikan!",
        Duration = 3
    })
end)

-- ==================== TAB AUTO ====================
local AutoSec = AutoTab:AddSection("Otomatisasi")

AutoSec:AddToggle("Auto Siapkan Hidangan", false, function(state)
    getgenv().AutoServe = state
    if state then
        WIND:Notify({Title = "Auto Serve", Content = "Auto Siapkan Hidangan: ON", Duration = 2})
    else
        WIND:Notify({Title = "Auto Serve", Content = "Auto Siapkan Hidangan: OFF", Duration = 2})
    end
end)

AutoSec:AddToggle("Auto Ambil Task", false, function(state)
    getgenv().AutoTask = state
    if state then
        WIND:Notify({Title = "Auto Task", Content = "Auto Ambil Task: ON", Duration = 2})
    else
        WIND:Notify({Title = "Auto Task", Content = "Auto Ambil Task: OFF", Duration = 2})
    end
end)

-- ==================== TAB KILL AURA ====================
local AuraSec = AuraTab:AddSection("Target Kill Aura")

AuraSec:AddToggle("Kill Aura NPC", false, function(state)
    getgenv().AuraNPC = state
end)

AuraSec:AddToggle("Kill Aura Cop", false, function(state)
    getgenv().AuraCop = state
end)

AuraSec:AddToggle("Kill Aura Customer", false, function(state)
    getgenv().AuraCustomer = state
end)

AuraSec:AddSlider("Jarak Kill Aura", 5, 100, 30, function(value)
    getgenv().AuraRange = value
end)

-- ==================== LOGIKA KILL AURA ====================
-- Fungsi untuk mendapatkan semua target berdasarkan nama/tag
local function getTargets()
    local targets = {}
    local range = getgenv().AuraRange or 30
    local player = game.Players.LocalPlayer
    local char = player.Character
    if not char then return targets end
    local root = char:FindFirstChild("HumanoidRootPart")
    if not root then return targets end

    -- Cari di Workspace
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("Model") and obj:FindFirstChild("Humanoid") then
            local humanoid = obj.Humanoid
            if humanoid.Health > 0 then
                local objRoot = obj:FindFirstChild("HumanoidRootPart")
                if objRoot then
                    local dist = (objRoot.Position - root.Position).Magnitude
                    if dist <= range then
                        -- Cek tipe target berdasarkan nama/tag
                        local name = obj.Name:lower()
                        local isNPC = name:find("npc") or obj:GetAttribute("NPC")
                        local isCop = name:find("cop") or name:find("police") or obj:GetAttribute("Cop")
                        local isCustomer = name:find("customer") or name:find("pelanggan") or obj:GetAttribute("Customer")

                        if (getgenv().AuraNPC and isNPC) or
                           (getgenv().AuraCop and isCop) or
                           (getgenv().AuraCustomer and isCustomer) then
                            table.insert(targets, {model = obj, humanoid = humanoid})
                        end
                    end
                end
            end
        end
    end
    return targets
end

-- Loop Kill Aura
task.spawn(function()
    while task.wait(0.1) do
        if getgenv().AuraNPC or getgenv().AuraCop or getgenv().AuraCustomer then
            local targets = getTargets()
            for _, target in ipairs(targets) do
                -- Metode damage: bisa menggunakan FireServer atau langsung set Health
                -- Jika game menggunakan RemoteEvent, ganti dengan yang sesuai.
                -- Contoh: game:GetService("ReplicatedStorage").Remotes.Damage:FireServer(target.model)
                if target.humanoid then
                    target.humanoid.Health = 0 -- Langsung matikan (hati-hati, bisa terdeteksi)
                    -- Alternatif: target.humanoid:TakeDamage(100)
                end
            end
        end
    end
end)

-- ==================== LOGIKA AUTO SERVE & AUTO TASK ====================
-- Fungsi untuk mencari ProximityPrompt berdasarkan nama
local function findPrompts(keywords)
    local found = {}
    for _, obj in ipairs(workspace:GetDescendants()) do
        if obj:IsA("ProximityPrompt") then
            local actionText = obj.ActionText:lower()
            for _, keyword in ipairs(keywords) do
                if actionText:find(keyword) then
                    table.insert(found, obj)
                    break
                end
            end
        end
    end
    return found
end

-- Loop Auto Serve
task.spawn(function()
    while task.wait(0.5) do
        if getgenv().AutoServe then
            local prompts = findPrompts({"serve", "siapkan", "hidangkan", "deliver", "order"})
            for _, prompt in ipairs(prompts) do
                if prompt.Enabled then
                    fireproximityprompt(prompt)
                    task.wait(0.2)
                end
            end
        end
    end
end)

-- Loop Auto Task
task.spawn(function()
    while task.wait(1) do
        if getgenv().AutoTask then
            local prompts = findPrompts({"task", "ambil", "tugas", "order", "pesanan"})
            for _, prompt in ipairs(prompts) do
                if prompt.Enabled then
                    fireproximityprompt(prompt)
                    task.wait(0.2)
                end
            end
        end
    end
end)

-- Notifikasi awal
WIND:Notify({
    Title = "Burgerz Hub",
    Content = "Script berhasil dimuat!",
    Duration = 5
})
