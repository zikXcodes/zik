loadstring(game:HttpGet("https://raw.githubusercontent.com/zikXcodes/zik/refs/heads/main/Speed%20Hub%20X%205.0.0%20Ui%20Source%20Code.txt"))()

-- ===== WALKSPEED FEATURE =====
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Default walkspeed
local defaultWalkSpeed = 16
local currentWalkSpeed = defaultWalkSpeed

-- Function untuk mengubah walkspeed
local function setWalkSpeed(speed)
    currentWalkSpeed = speed
    if Humanoid then
        Humanoid.WalkSpeed = speed
    end
end

-- Function untuk menambah walkspeed
local function increaseWalkSpeed(amount)
    setWalkSpeed(currentWalkSpeed + amount)
end

-- Function untuk mengurangi walkspeed
local function decreaseWalkSpeed(amount)
    setWalkSpeed(math.max(0, currentWalkSpeed - amount))
end

-- Event listener ketika character respawn
LocalPlayer.CharacterAdded:Connect(function(newCharacter)
    Character = newCharacter
    Humanoid = Character:WaitForChild("Humanoid")
    setWalkSpeed(currentWalkSpeed)
end)

-- Keyboard Input untuk mengontrol walkspeed
local UserInputService = game:GetService("UserInputService")

UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end
    
    -- E untuk tambah speed (+5)
    if input.KeyCode == Enum.KeyCode.E then
        increaseWalkSpeed(5)
        print("Walk Speed: " .. currentWalkSpeed)
    end
    
    -- Q untuk kurangi speed (-5)
    if input.KeyCode == Enum.KeyCode.Q then
        decreaseWalkSpeed(5)
        print("Walk Speed: " .. currentWalkSpeed)
    end
    
    -- R untuk reset ke normal
    if input.KeyCode == Enum.KeyCode.R then
        setWalkSpeed(defaultWalkSpeed)
        print("Walk Speed Reset to: " .. defaultWalkSpeed)
    end
end)

print("Walkspeed Mod Loaded!")
print("Controls: E (Increase) | Q (Decrease) | R (Reset)")
