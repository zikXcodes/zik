-- Target Lock / Camera Lock
-- Untuk Roblox Studio / game milik sendiri

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

local enabled = false
local target = nil

local FOV_RADIUS = 180
local SMOOTHNESS = 0.18

--==================================================
-- GUI
--==================================================

local gui = Instance.new("ScreenGui")
gui.Name = "TargetLockUI"
gui.ResetOnSpawn = false
gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local button = Instance.new("TextButton")
button.Size = UDim2.fromOffset(170, 45)
button.Position = UDim2.new(1, -190, 1, -70)
button.BackgroundColor3 = Color3.fromRGB(20, 20, 25)
button.TextColor3 = Color3.new(1, 1, 1)
button.TextSize = 16
button.Font = Enum.Font.GothamBold
button.Text = "TARGET LOCK: OFF"
button.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = button

--==================================================
-- FOV CIRCLE
--==================================================

local fov = Instance.new("Frame")
fov.Name = "FOV"
fov.Size = UDim2.fromOffset(FOV_RADIUS * 2, FOV_RADIUS * 2)
fov.AnchorPoint = Vector2.new(0.5, 0.5)
fov.Position = UDim2.fromScale(0.5, 0.5)
fov.BackgroundTransparency = 1
fov.Visible = false
fov.Parent = gui

local stroke = Instance.new("UIStroke")
stroke.Thickness = 2
stroke.Transparency = 0.2
stroke.Parent = fov

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fov

--==================================================
-- TARGET CHECK
--==================================================

local function getCharacter(player)
	local character = player.Character

	if not character then
		return nil
	end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")

	if not humanoid or not root then
		return nil
	end

	if humanoid.Health <= 0 then
		return nil
	end

	return character, humanoid, root
end

local function getClosestTarget()
	local closestPlayer = nil
	local closestDistance = FOV_RADIUS

	local viewportCenter = Vector2.new(
		Camera.ViewportSize.X / 2,
		Camera.ViewportSize.Y / 2
	)

	for _, player in ipairs(Players:GetPlayers()) do
		if player ~= LocalPlayer then

			local character, humanoid, root = getCharacter(player)

			if character and humanoid and root then

				local screenPosition, visible =
					Camera:WorldToViewportPoint(root.Position)

				if visible and screenPosition.Z > 0 then

					local distance = (
						Vector2.new(screenPosition.X, screenPosition.Y)
						- viewportCenter
					).Magnitude

					if distance < closestDistance then
						closestDistance = distance
						closestPlayer = player
					end
				end
			end
		end
	end

	return closestPlayer
end

--==================================================
-- TOGGLE
--==================================================

local function toggleLock()
	enabled = not enabled

	if enabled then
		target = getClosestTarget()

		button.Text = "TARGET LOCK: ON"
		fov.Visible = true
	else
		target = nil

		button.Text = "TARGET LOCK: OFF"
		fov.Visible = false
	end
end

button.MouseButton1Click:Connect(toggleLock)

-- PC shortcut
UserInputService.InputBegan:Connect(function(input, processed)
	if processed then
		return
	end

	if input.KeyCode == Enum.KeyCode.Q then
		toggleLock()
	end
end)

--==================================================
-- CAMERA LOCK
--==================================================

RunService.RenderStepped:Connect(function()
	if not enabled then
		return
	end

	if not target then
		target = getClosestTarget()
		return
	end

	local character, humanoid, root = getCharacter(target)

	if not character then
		target = getClosestTarget()
		return
	end

	local cameraPosition = Camera.CFrame.Position
	local targetPosition = root.Position

	local desiredCFrame = CFrame.lookAt(
		cameraPosition,
		targetPosition
	)

	Camera.CFrame = Camera.CFrame:Lerp(
		desiredCFrame,
		SMOOTHNESS
	)
end)

--==================================================
-- KEEP FOV CENTERED
--==================================================

RunService.RenderStepped:Connect(function()
	fov.Position = UDim2.fromOffset(
		Camera.ViewportSize.X / 2,
		Camera.ViewportSize.Y / 2
	)
end)
