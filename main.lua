local WindUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/Footagesus/WindUI/main/dist/main.lua"))()

local Window = WindUI:CreateWindow({
    Title = "Zik",
    Icon = "",
    Theme = "Crimson",
    Folder = "MyHub",
})

local Tab = Window:Tab({
    Title = "Main",
    Icon = "home",
})

-- Toggle
Tab:Toggle({
    Title = "Enable Feature",
    Value = false,
    Callback = function(state)
        print("Feature enabled:", state)
    end,
})

Tab:Space()

-- Button
Tab:Button({
    Title = "Run Action",
    Icon = "play",
    Callback = function()
        print("Button clicked")
    end,
})

Tab:Space()

-- Slider
Tab:Slider({
    Title = "Walk Speed",
    Step = 1,
    Value = {
        Min = 16,
        Max = 100,
        Default = 16,
    },
    Callback = function(value)
        local Players = game:GetService("Players")
        local player = Players.LocalPlayer
        if not player then return end
        local char = player.Character or player.CharacterAdded:Wait()
        local humanoid = char:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = value
        end
    end,
})

Tab:Space()

-- Dropdown
Tab:Dropdown({
    Title = "Select Team",
    Values = { "Red", "Blue", "Green" },
    Value = 1,
    Callback = function(selectedValue)
        print("Team selected:", selectedValue)
    end,
})

WindUI:Notify({
    Title = "Hub Loaded",
    Content = "Welcome! My Hub is ready.",
    Icon = "solar:bell-bold",
    Duration = 5,
})

local OpenButton = {
    Title         = "Open Hub",
    CornerRadius  = UDim.new(1, 0),
    StrokeThickness = 3,
    Enabled       = true,
    Draggable     = true,
    OnlyMobile    = false,
    Scale         = 0.5,
    Color         = ColorSequence.new(
        Color3.fromHex("#30FF6A"),
        Color3.fromHex("#e7ff2f")
    ),
}

local User = {
    Enabled   = true,
    Anonymous = false,          -- show "Anonymous" instead of real name
    Callback  = function()      -- called when the user clicks the panel
        print("user clicked")
    end,
}

-- Choose a single background. Examples below — uncomment what you want to use.

-- Solid asset
-- local Background = "rbxassetid://123456789"

-- HTTPS image (downloaded on first run)
-- local Background = "https://example.com/bg.png"

-- Looping video
-- local Background = "video:rbxassetid://987654321"

-- Gradient (example)
local Background = WindUI:Gradient({
    ["0"]   = { Color = Color3.fromHex("#1a1a2e"), Transparency = 0 },
    ["100"] = { Color = Color3.fromHex("#16213e"), Transparency = 0 },
}, { Rotation = 90 })

-- If WindUI supports setting these after creation, apply them. Example (only if API supports):
-- Window:SetOpenButton(OpenButton)
-- Window:SetUserPanel(User)
-- Window:SetBackground(Background)


-- =====================
-- New features for Burgerz (auto cook + kill aura)
-- Note: these are heuristic/local implementations. Game internals may differ — adjust
-- target names/paths as needed for the specific Burgerz game's model names and structure.
-- =====================

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local workspace = game:GetService("Workspace")

-- Global toggles so loops can be controlled from outside coroutines
getgenv().ZikSettings = getgenv().ZikSettings or {
    AutoCook = false,
    KillAura = false,
    KillAuraTargets = { npc = true, cop = true, customer = true },
    KillAuraRange = 20,
    CookInterval = 1.0,
}

-- Utility: find humanoid on a Model
local function findHumanoid(model)
    if not model then return nil end
    for _, v in pairs(model:GetDescendants()) do
        if v and v:IsA("Humanoid") then
            return v
        end
    end
    return nil
end

-- Kill aura implementation (local): finds nearby characters whose name matches targets and sets Health = 0
local function killAuraLoop()
    while getgenv().ZikSettings.KillAura do
        local success, err = pcall(function()
            if not LocalPlayer or not LocalPlayer.Character then return end
            local hrp = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if not hrp then return end
            for _, model in pairs(workspace:GetDescendants()) do
                if model:IsA("Model") and model ~= LocalPlayer.Character then
                    local name = model.Name:lower()
                    local isTarget = false
                    if getgenv().ZikSettings.KillAuraTargets.npc and name:find("npc") then isTarget = true end
                    if getgenv().ZikSettings.KillAuraTargets.cop and name:find("cop") then isTarget = true end
                    if getgenv().ZikSettings.KillAuraTargets.customer and (name:find("customer") or name:find("cust")) then isTarget = true end
                    if isTarget then
                        local targetHRP = model:FindFirstChild("HumanoidRootPart")
                        local humanoid = findHumanoid(model)
                        if targetHRP and humanoid and humanoid.Health > 0 then
                            local distance = (targetHRP.Position - hrp.Position).Magnitude
                            if distance <= getgenv().ZikSettings.KillAuraRange then
                                -- try to set health to 0 (local change might be enough for some games)
                                pcall(function() humanoid.Health = 0 end)
                            end
                        end
                    end
                end
            end
        end)
        if not success then
            warn("KillAura error:", err)
        end
        wait(0.2)
    end
end

-- Auto cook implementation (very generic): tries to find raw items and cooking stations
-- You will likely need to change the search terms to match the Burgerz game structure.
local function autoCookLoop()
    while getgenv().ZikSettings.AutoCook do
        local success, err = pcall(function()
            -- Example heuristic: search for 'Raw' or 'Uncooked' items in workspace and move them to nearby 'Grill' or 'Cook' parts
            local playerChar = LocalPlayer and LocalPlayer.Character
            local hrp = playerChar and playerChar:FindFirstChild("HumanoidRootPart")
            if not hrp then return end

            local rawItems = {}
            for _, obj in pairs(workspace:GetDescendants()) do
                if obj:IsA("BasePart") or obj:IsA("Model") then
                    local n = obj.Name:lower()
                    if n:find("raw") or n:find("uncook") or n:find("patty") then
                        table.insert(rawItems, obj)
                    end
                end
            end

            local grills = {}
            for _, obj in pairs(workspace:GetDescendants()) do
                local n = obj.Name:lower()
                if (obj:IsA("BasePart") or obj:IsA("Model")) and (n:find("grill") or n:find("cook") or n:find("stove")) then
                    table.insert(grills, obj)
                end
            end

            -- simple interaction: move close to raw item, then move to grill and wait
            for _, raw in pairs(rawItems) do
                if not getgenv().ZikSettings.AutoCook then break end
                local rawPos
                if raw:IsA("BasePart") then 
                    rawPos = raw.Position
                else
                    local part = raw:FindFirstChildWhichIsA("BasePart")
                    rawPos = part and part.Position
                end
                if rawPos and hrp then
                    if (rawPos - hrp.Position).Magnitude > 6 then
                        -- teleport near the item (local teleport only)
                        pcall(function() hrp.CFrame = CFrame.new(rawPos + Vector3.new(0, 3, 0)) end)
                        wait(0.15)
                    end

                    -- attempt pickup by firing touch (heuristic)
                    if raw:IsA("BasePart") then
                        local playerPart = playerChar:FindFirstChildWhichIsA("BasePart")
                        if playerPart then
                            pcall(function() 
                                firetouchinterest(raw, playerPart, 0)
                                wait(0.1)
                                firetouchinterest(raw, playerPart, 1)
                            end)
                        end
                    end

                    -- send to nearest grill
                    local nearestGrill
                    local nearestDist = math.huge
                    for _, g in pairs(grills) do
                        local gPos
                        if g:IsA("BasePart") then 
                            gPos = g.Position 
                        else 
                            local gPart = g:FindFirstChildWhichIsA("BasePart")
                            gPos = gPart and gPart.Position 
                        end
                        if gPos then
                            local d = (gPos - hrp.Position).Magnitude
                            if d < nearestDist then 
                                nearestDist = d
                                nearestGrill = g 
                            end
                        end
                    end

                    if nearestGrill and nearestDist > 3 then
                        local gPos
                        if nearestGrill:IsA("BasePart") then 
                            gPos = nearestGrill.Position 
                        else 
                            local gPart = nearestGrill:FindFirstChildWhichIsA("BasePart")
                            gPos = gPart and gPart.Position 
                        end
                        if gPos then 
                            pcall(function() hrp.CFrame = CFrame.new(gPos + Vector3.new(0, 3, 0)) end)
                        end
                    end

                    -- wait a bit to simulate cooking
                    wait(getgenv().ZikSettings.CookInterval)
                end
            end
        end)
        if not success then 
            warn("AutoCook error:", err) 
        end
        wait(0.5)
    end
end

-- UI additions: controls for AutoCook and KillAura
local AutoTab = Window:Tab({ Title = "Auto", Icon = "auto" })

AutoTab:Toggle({
    Title = "Auto Cook",
    Value = false,
    Callback = function(state)
        getgenv().ZikSettings.AutoCook = state
        if state then
            spawn(autoCookLoop)
            WindUI:Notify({ Title = "Auto Cook", Content = "Enabled", Duration = 3 })
        else
            WindUI:Notify({ Title = "Auto Cook", Content = "Disabled", Duration = 3 })
        end
    end,
})

AutoTab:Slider({
    Title = "Cook Interval (s)",
    Step = 0.1,
    Value = { Min = 0.2, Max = 5, Default = getgenv().ZikSettings.CookInterval },
    Callback = function(val) getgenv().ZikSettings.CookInterval = val end,
})

AutoTab:Space()

AutoTab:Toggle({
    Title = "Kill Aura",
    Value = false,
    Callback = function(state)
        getgenv().ZikSettings.KillAura = state
        if state then
            spawn(killAuraLoop)
            WindUI:Notify({ Title = "Kill Aura", Content = "Enabled", Duration = 3 })
        else
            WindUI:Notify({ Title = "Kill Aura", Content = "Disabled", Duration = 3 })
        end
    end,
})

AutoTab:Slider({
    Title = "Kill Range",
    Step = 1,
    Value = { Min = 5, Max = 200, Default = getgenv().ZikSettings.KillAuraRange },
    Callback = function(val) getgenv().ZikSettings.KillAuraRange = val end,
})

AutoTab:Checkbox({
    Title = "Target NPC",
    Value = getgenv().ZikSettings.KillAuraTargets.npc,
    Callback = function(v) getgenv().ZikSettings.KillAuraTargets.npc = v end,
})

AutoTab:Checkbox({
    Title = "Target Cop",
    Value = getgenv().ZikSettings.KillAuraTargets.cop,
    Callback = function(v) getgenv().ZikSettings.KillAuraTargets.cop = v end,
})

AutoTab:Checkbox({
    Title = "Target Customer",
    Value = getgenv().ZikSettings.KillAuraTargets.customer,
    Callback = function(v) getgenv().ZikSettings.KillAuraTargets.customer = v end,
})

-- UI: draw separators/lines between tabs to avoid sloppy look
-- This tries to attach simple lines overlay in PlayerGui. It may need adjusting depending on WindUI structure.
local function createTabSeparators()
    local playerGui = Players.LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if not playerGui then return end
    local name = "ZikTabSeparators"
    local gui = playerGui:FindFirstChild(name) or Instance.new("ScreenGui")
    gui.Name = name
    gui.ResetOnSpawn = false
    gui.Parent = playerGui

    -- clear previous lines
    for _, c in pairs(gui:GetChildren()) do
        if c:IsA("Frame") and c.Name:match("ZikSeparator") then c:Destroy() end
    end

    -- heuristic: create a top horizontal line and a left vertical line to separate tabs area
    local topLine = Instance.new("Frame")
    topLine.Name = "ZikSeparatorTop"
    topLine.Size = UDim2.new(1, 0, 0, 2)
    topLine.Position = UDim2.new(0, 0, 0, 32)
    topLine.BackgroundColor3 = Color3.fromHex("#222222")
    topLine.BackgroundTransparency = 0
    topLine.BorderSizePixel = 0
    topLine.Parent = gui

    local leftLine = Instance.new("Frame")
    leftLine.Name = "ZikSeparatorLeft"
    leftLine.Size = UDim2.new(0, 2, 1, -32)
    leftLine.Position = UDim2.new(0, 0, 0, 32)
    leftLine.BackgroundColor3 = Color3.fromHex("#222222")
    leftLine.BackgroundTransparency = 0
    leftLine.BorderSizePixel = 0
    leftLine.Parent = gui

    -- subtle strokes
    for _, f in pairs({topLine, leftLine}) do
        local stroke = Instance.new("UIStroke")
        stroke.Thickness = 1
        stroke.Color = Color3.fromHex("#FFFFFF")
        stroke.Transparency = 0.9
        stroke.Parent = f
    end
end

-- Try to create separators now and whenever PlayerGui is added
spawn(function()
    pcall(function() createTabSeparators() end)
    local pg = Players.LocalPlayer:WaitForChild("PlayerGui")
    pg.ChildAdded:Connect(function(child)
        wait(0.2)
        pcall(function() createTabSeparators() end)
    end)
end)

-- Keep old main tab visible and tidy
Tab:Label({ Title = "Info:", Content = "Use the Auto tab to enable Auto Cook and Kill Aura for Burgerz." })

-- End of file
