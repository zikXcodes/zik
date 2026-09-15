--========================================================--
-- TARGET LOCK + INVISIBLE
-- Roblox Studio / Game milik sendiri
-- LocalScript -> StarterPlayerScripts
--========================================================--

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--========================================================--
-- CONFIG
--========================================================--

local AimEnabled = false
local InvisibleEnabled = false

local FOV = 180
local Smoothness = 0.18

local Target = nil

--========================================================--
-- OBsidian-style UI
--========================================================--

local Gui = Instance.new("ScreenGui")
Gui.Name = "TargetLockUI"
Gui.ResetOnSpawn = false
Gui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(300, 240)
Main.Position = UDim2.new(0.5, -150, 0.5, -120)
Main.BackgroundColor3 = Color3.fromRGB(12, 12, 16)
Main.BorderSizePixel = 0
Main.Parent = Gui

local Corner = Instance.new("UICorner")
Corner.CornerRadius = UDim.new(0, 12)
Corner.Parent = Main

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -20, 0, 40)
Title.Position = UDim2.fromOffset(10, 5)
Title.BackgroundTransparency = 1
Title.Text = "TARGET CONTROL"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 18
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

--========================================================--
-- BUTTON CREATOR
--========================================================--

local function CreateToggle(text, y)
	local Button = Instance.new("TextButton")

	Button.Size = UDim2.new(1, -30, 0, 42)
	Button.Position = UDim2.fromOffset(15, y)

	Button.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
	Button.BorderSizePixel = 0

	Button.Text = text .. ": OFF"
	Button.TextColor3 = Color3.fromRGB(220, 220, 225)

	Button.Font = Enum.Font.GothamMedium
	Button.TextSize = 14

	Button.Parent = Main

	local C = Instance.new("UICorner")
	C.CornerRadius = UDim.new(0, 8)
	C.Parent = Button

	return Button
end

local AimToggle = CreateToggle("Aim Lock", 55)
local InvisibleToggle = CreateToggle("Invisible", 105)

--========================================================--
-- SLIDER
--========================================================--

local FOVLabel = Instance.new("TextLabel")
FOVLabel.Size = UDim2.new(1, -30, 0, 25)
FOVLabel.Position = UDim2.fromOffset(15, 160)
FOVLabel.BackgroundTransparency = 1
FOVLabel.Text = "FOV: " .. FOV
FOVLabel.TextColor3 = Color3.fromRGB(220, 220, 225)
FOVLabel.Font = Enum.Font.Gotham
FOVLabel.TextSize = 13
FOVLabel.TextXAlignment = Enum.TextXAlignment.Left
FOVLabel.Parent = Main

local FOVBox = Instance.new("TextBox")
FOVBox.Size = UDim2.new(1, -30, 0, 35)
FOVBox.Position = UDim2.fromOffset(15, 185)
FOVBox.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
FOVBox.BorderSizePixel = 0
FOVBox.Text = tostring(FOV)
FOVBox.TextColor3 = Color3.new(1, 1, 1)
FOVBox.Font = Enum.Font.Gotham
FOVBox.TextSize = 14
FOVBox.ClearTextOnFocus = false
FOVBox.Parent = Main

local BoxCorner = Instance.new("UICorner")
BoxCorner.CornerRadius = UDim.new(0, 8)
BoxCorner.Parent = FOVBox

FOVBox.FocusLost:Connect(function()
	local Value = tonumber(FOVBox.Text)

	if Value then
		FOV = math.clamp(Value, 50, 500)
		FOVBox.Text = tostring(FOV)
		FOVLabel.Text = "FOV: " .. FOV
	end
end)

--========================================================--
-- TARGET FINDER
--========================================================--

local function GetCharacter(Player)
	if not Player.Character then
		return nil
	end

	local Character = Player.Character
	local Humanoid = Character:FindFirstChildOfClass("Humanoid")
	local Root = Character:FindFirstChild("HumanoidRootPart")

	if not Humanoid or not Root then
		return nil
	end

	if Humanoid.Health <= 0 then
		return nil
	end

	return Character, Humanoid, Root
end

local function GetClosestTarget()
	local Closest = nil
	local ClosestDistance = FOV

	local Center = Vector2.new(
		Camera.ViewportSize.X / 2,
		Camera.ViewportSize.Y / 2
	)

	for _, Player in ipairs(Players:GetPlayers()) do

		if Player ~= LocalPlayer then

			local Character, Humanoid, Root =
				GetCharacter(Player)

			if Character and Root then

				local Position, Visible =
					Camera:WorldToViewportPoint(
						Root.Position
					)

				if Visible and Position.Z > 0 then

					local Distance =
						(
							Vector2.new(
								Position.X,
								Position.Y
							) - Center
						).Magnitude

					if Distance < ClosestDistance then
						ClosestDistance = Distance
						Closest = Player
					end
				end
			end
		end
	end

	return Closest
end

--========================================================--
-- AIM LOCK
--========================================================--

AimToggle.MouseButton1Click:Connect(function()

	AimEnabled = not AimEnabled

	if AimEnabled then

		AimToggle.Text = "Aim Lock: ON"
		AimToggle.TextColor3 =
			Color3.fromRGB(0, 255, 140)

		Target = GetClosestTarget()

	else

		AimToggle.Text = "Aim Lock: OFF"
		AimToggle.TextColor3 =
			Color3.fromRGB(220, 220, 225)

		Target = nil
	end
end)

RunService.RenderStepped:Connect(function()

	if not AimEnabled then
		return
	end

	if not Target then
		Target = GetClosestTarget()
		return
	end

	local Character, Humanoid, Root =
		GetCharacter(Target)

	if not Character then
		Target = GetClosestTarget()
		return
	end

	local CameraPosition = Camera.CFrame.Position

	local Desired =
		CFrame.lookAt(
			CameraPosition,
			Root.Position
		)

	Camera.CFrame =
		Camera.CFrame:Lerp(
			Desired,
			Smoothness
		)
end)

--========================================================--
-- INVISIBLE
--========================================================--

local OriginalTransparency = {}

local function SetInvisible(State)

	local Character = LocalPlayer.Character

	if not Character then
		return
	end

	for _, Object in ipairs(Character:GetDescendants()) do

		if Object:IsA("BasePart")
			or Object:IsA("Decal")
			or Object:IsA("Texture") then

			if State then

				if OriginalTransparency[Object] == nil then
					OriginalTransparency[Object] =
						Object.Transparency
				end

				Object.Transparency = 1

			else

				if OriginalTransparency[Object] ~= nil then
					Object.Transparency =
						OriginalTransparency[Object]
				end
			end
		end
	end

	if not State then
		table.clear(OriginalTransparency)
	end
end

InvisibleToggle.MouseButton1Click:Connect(function()

	InvisibleEnabled =
		not InvisibleEnabled

	SetInvisible(InvisibleEnabled)

	if InvisibleEnabled then

		InvisibleToggle.Text =
			"Invisible: ON"

		InvisibleToggle.TextColor3 =
			Color3.fromRGB(0, 255, 140)

	else

		InvisibleToggle.Text =
			"Invisible: OFF"

		InvisibleToggle.TextColor3 =
			Color3.fromRGB(220, 220, 225)
	end
end)

--========================================================--
-- RESPAWN SUPPORT
--========================================================--

LocalPlayer.CharacterAdded:Connect(function()

	OriginalTransparency = {}

	if InvisibleEnabled then
		task.wait(0.5)
		SetInvisible(true)
	end

	Target = nil
end)

print("Target Control loaded.")
