-- Steal an Egg Script dengan Wind UI Library
-- Pastikan Wind UI sudah ter-install

local WindUI = require(game.ServerScriptService:WaitForChild("WindUI"))

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- Variables
local autoSteal = false
local autoSell = false
local espEnabled = false
local speedBoost = 1
local eggMultiplier = 1

-- Buat Window
local window = WindUI:CreateWindow({
    Title = "Steal an Egg Script",
    Subtitle = "by zikXcodes",
    Size = UDim2.new(0, 400, 0, 500),
    Position = UDim2.new(0.5, -200, 0.5, -250),
    ShowIcon = true,
    Icon = "rbxassetid://6034663971"
})

-- Tab 1: Auto Features
local autoTab = window:CreateTab({
    Title = "Auto Features",
    Icon = "rbxassetid://6034663971"
})

autoTab:CreateToggle({
    Title = "Auto Steal Eggs",
    Callback = function(state)
        autoSteal = state
        if autoSteal then
            autoStealEggs()
        end
    end,
    Enabled = false
})

autoTab:CreateToggle({
    Title = "Auto Sell",
    Callback = function(state)
        autoSell = state
        if autoSell then
            autoSellEggs()
        end
    end,
    Enabled = false
})

autoTab:CreateSlider({
    Title = "Steal Speed",
    Minimum = 0.5,
    Maximum = 5,
    Callback = function(value)
        speedBoost = value
    end,
    DefaultValue = 1
})

autoTab:CreateSlider({
    Title = "Egg Multiplier",
    Minimum = 1,
    Maximum = 10,
    Callback = function(value)
        eggMultiplier = math.floor(value)
    end,
    DefaultValue = 1
})

-- Tab 2: Visual Features
local visualTab = window:CreateTab({
    Title = "Visual",
    Icon = "rbxassetid://6034663971"
})

visualTab:CreateToggle({
    Title = "Enable ESP",
    Callback = function(state)
        espEnabled = state
        if espEnabled then
            enableESP()
        else
            disableESP()
        end
    end,
    Enabled = false
})

visualTab:CreateToggle({
    Title = "Show Hitboxes",
    Callback = function(state)
        if state then
            showHitboxes()
        else
            hideHitboxes()
        end
    end,
    Enabled = false
})

visualTab:CreateButton({
    Title = "Find Eggs",
    Callback = function()
        findAllEggs()
    end
})

-- Tab 3: Player
local playerTab = window:CreateTab({
    Title = "Player",
    Icon = "rbxassetid://6034663971"
})

playerTab:CreateSlider({
    Title = "Walkspeed",
    Minimum = 16,
    Maximum = 100,
    Callback = function(value)
        player.Character:FindFirstChild("Humanoid").WalkSpeed = value
    end,
    DefaultValue = 16
})

playerTab:CreateSlider({
    Title = "Jump Power",
    Minimum = 50,
    Maximum = 150,
    Callback = function(value)
        player.Character:FindFirstChild("Humanoid").JumpPower = value
    end,
    DefaultValue = 50
})

playerTab:CreateButton({
    Title = "Fly",
    Callback = function()
        startFlying()
    end
})

playerTab:CreateButton({
    Title = "Stop Fly",
    Callback = function()
        stopFlying()
    end
})

-- Tab 4: Settings
local settingsTab = window:CreateTab({
    Title = "Settings",
    Icon = "rbxassetid://6034663971"
})

settingsTab:CreateButton({
    Title = "Close GUI",
    Callback = function()
        window:Destroy()
    end
})

settingsTab:CreateLabel("Script Info:")
settingsTab:CreateLabel("Version: 1.0")
settingsTab:CreateLabel("Author: zikXcodes")

-- ==================== FUNCTIONS ====================

-- Auto Steal Eggs Function
function autoStealEggs()
    while autoSteal do
        local eggs = findAllEggs()
        for _, egg in pairs(eggs) do
            if egg and egg.Parent then
                local rootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
                if rootPart then
                    -- Pindah ke egg
                    rootPart.CFrame = egg.CFrame + Vector3.new(0, 3, 0)
                    wait(0.5 / speedBoost)
                    
                    -- Trigger grab
                    local humanoid = player.Character:FindFirstChild("Humanoid")
                    if humanoid then
                        humanoid:MoveTo(egg.Position)
                    end
                    
                    wait(1 / speedBoost)
                end
            end
        end
        wait(0.1)
    end
end

-- Auto Sell Function
function autoSellEggs()
    while autoSell do
        local sellArea = workspace:FindFirstChild("SellArea") or workspace:FindFirstChild("Sell")
        if sellArea then
            local rootPart = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                rootPart.CFrame = sellArea.CFrame + Vector3.new(0, 3, 0)
                wait(0.5)
                
                -- Fire sell event jika ada
                local sellEvent = game.ReplicatedStorage:FindFirstChild("SellEvent")
                if sellEvent then
                    sellEvent:FireServer()
                end
            end
        end
        wait(2)
    end
end

-- Find All Eggs
function findAllEggs()
    local eggs = {}
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Model") or obj:IsA("Part") then
            if string.find(obj.Name:lower(), "egg") then
                table.insert(eggs, obj)
            end
        end
    end
    return eggs
end

-- Enable ESP
function enableESP()
    for _, obj in pairs(workspace:GetDescendants()) do
        if string.find(obj.Name:lower(), "egg") then
            addESP(obj)
        end
    end
end

-- Disable ESP
function disableESP()
    local espFolder = workspace:FindFirstChild("ESPFolder")
    if espFolder then
        espFolder:Destroy()
    end
end

-- Add ESP to Object
function addESP(obj)
    local espFolder = workspace:FindFirstChild("ESPFolder")
    if not espFolder then
        espFolder = Instance.new("Folder")
        espFolder.Name = "ESPFolder"
        espFolder.Parent = workspace
    end
    
    if obj:IsA("Part") then
        local billboardGui = Instance.new("BillboardGui")
        billboardGui.Size = UDim2.new(4, 0, 4, 0)
        billboardGui.MaxDistance = math.huge
        billboardGui.Parent = obj
        
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextSize = 14
        textLabel.Text = obj.Name
        textLabel.Parent = billboardGui
    end
end

-- Show Hitboxes
function showHitboxes()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("Part") and obj.Parent then
            if string.find(obj.Name:lower(), "egg") then
                obj.CanCollide = false
                local boxOutline = Instance.new("BoxHandleAdornment")
                boxOutline.Size = obj.Size
                boxOutline.Color3 = Color3.fromRGB(0, 255, 0)
                boxOutline.Transparency = 0.3
                boxOutline.Adornee = obj
                boxOutline.Parent = obj
            end
        end
    end
end

-- Hide Hitboxes
function hideHitboxes()
    for _, obj in pairs(workspace:GetDescendants()) do
        if obj:IsA("BoxHandleAdornment") then
            obj:Destroy()
        end
    end
end

-- Flying System
local flying = false
local bodyVelocity
local bodyGyro

function startFlying()
    if flying then return end
    flying = true
    
    local rootPart = player.Character:FindFirstChild("HumanoidRootPart")
    if not rootPart then return end
    
    bodyVelocity = Instance.new("BodyVelocity")
    bodyVelocity.Velocity = Vector3.new(0, 0, 0)
    bodyVelocity.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bodyVelocity.Parent = rootPart
    
    bodyGyro = Instance.new("BodyGyro")
    bodyGyro.MaxTorque = Vector3.new(math.huge, math.huge, math.huge)
    bodyGyro.Parent = rootPart
    
    local flySpeed = 50
    
    RunService.RenderStepped:Connect(function()
        if not flying or not rootPart.Parent then return end
        
        local direction = Vector3.new(0, 0, 0)
        
        if UserInputService:IsKeyDown(Enum.KeyCode.W) then
            direction = direction + (camera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.S) then
            direction = direction - (camera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.A) then
            direction = direction - camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.D) then
            direction = direction + camera.CFrame.RightVector
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.Space) then
            direction = direction + Vector3.new(0, 1, 0)
        end
        if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then
            direction = direction - Vector3.new(0, 1, 0)
        end
        
        if direction.Magnitude > 0 then
            direction = direction.Unit
        end
        
        bodyVelocity.Velocity = direction * flySpeed
        bodyGyro.CFrame = camera.CFrame
    end)
end

function stopFlying()
    flying = false
    if bodyVelocity then
        bodyVelocity:Destroy()
    end
    if bodyGyro then
        bodyGyro:Destroy()
    end
end

-- Cleanup saat player meninggal
player.CharacterAdded:Connect(function()
    wait(0.1)
    if flying then
        stopFlying()
    end
end)

print("✓ Steal an Egg Script Loaded!")
print("✓ Wind UI GUI Siap Digunakan!")

