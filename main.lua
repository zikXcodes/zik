--[[
	RobloxUILibrary.lua
	----------------------------------------------------------------
	UI Library Roblox reusable: sidebar navigation, list item, toggle,
	minimize button, dan layout responsif.

	CARA PAKAI (contoh ada di paling bawah file, dalam komentar):
	1. Taruh file ini sebagai ModuleScript, misal di ReplicatedStorage
	   dengan nama "UILib".
	2. Di LocalScript lain:
		local UILib = require(game.ReplicatedStorage.UILib)
		local window = UILib.new({ Title = "Nama App" })
		local tab = window:AddTab({ Name = "Home", Icon = "rbxassetid://0" })
		tab:AddItem({
			Title = "Contoh Fitur",
			Description = "Deskripsi singkat fitur.",
			Type = "Toggle", -- atau "Button"
			OnToggle = function(state)
				print("Toggle:", state)
			end,
		})

	Library ini KOSONG dari sisi fungsi -- semua callback (OnToggle,
	OnClick) kamu isi sendiri sesuai kebutuhan proyekmu.
--]]

local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")

local UILib = {}
UILib.__index = UILib

local Tab = {}
Tab.__index = Tab

--// ---------- KONFIGURASI WARNA & STYLE ---------- //--
local THEME = {
	Background   = Color3.fromRGB(15, 12, 13),
	Panel        = Color3.fromRGB(20, 16, 17),
	Border       = Color3.fromRGB(60, 20, 22),
	Accent       = Color3.fromRGB(200, 30, 40),
	AccentDim    = Color3.fromRGB(90, 20, 25),
	TextPrimary  = Color3.fromRGB(235, 235, 235),
	TextSecond   = Color3.fromRGB(150, 150, 150),
	ItemBg       = Color3.fromRGB(22, 18, 19),
	ItemBgHover  = Color3.fromRGB(30, 22, 24),
}

local FONT_BOLD = Enum.Font.GothamBold
local FONT_REG  = Enum.Font.Gotham

--// ---------- HELPER ---------- //--
local function new(class, props, children)
	local inst = Instance.new(class)
	for k, v in pairs(props or {}) do
		inst[k] = v
	end
	for _, child in ipairs(children or {}) do
		child.Parent = inst
	end
	return inst
end

local function corner(radius)
	return new("UICorner", { CornerRadius = UDim.new(0, radius or 8) })
end

local function stroke(color, thickness)
	return new("UIStroke", {
		Color = color or THEME.Border,
		Thickness = thickness or 1,
	})
end

local function tween(obj, props, time, style)
	TweenService:Create(obj, TweenInfo.new(time or 0.2, style or Enum.EasingStyle.Quad), props):Play()
end

--// ---------- WINDOW ---------- //--
-- Membuat window utama. props:
--   Title (string), Subtitle (string), Size (UDim2), MinSize (Vector2)
function UILib.new(props)
	props = props or {}
	local self = setmetatable({}, UILib)

	local player = Players.LocalPlayer
	local playerGui = player:WaitForChild("PlayerGui")

	self.ScreenGui = new("ScreenGui", {
		Name = "UILib_" .. (props.Title or "Window"),
		ResetOnSpawn = false,
		ZIndexBehavior = Enum.ZIndexBehavior.Sibling,
		Parent = playerGui,
	})

	-- Frame utama, ukuran berbasis Scale supaya responsif di berbagai resolusi
	self.MainFrame = new("Frame", {
		Name = "Main",
		Size = props.Size or UDim2.fromScale(0.55, 0.6),
		Position = UDim2.fromScale(0.5, 0.5),
		AnchorPoint = Vector2.new(0.5, 0.5),
		BackgroundColor3 = THEME.Background,
		Parent = self.ScreenGui,
	}, {
		corner(14),
		stroke(THEME.Border, 1),
	})

	-- Batas ukuran min/max agar tetap enak dilihat di layar kecil/besar
	new("UISizeConstraint", {
		MinSize = props.MinSize or Vector2.new(560, 360),
		MaxSize = props.MaxSize or Vector2.new(1100, 720),
		Parent = self.MainFrame,
	})

	self:_buildTopBar(props.Title or "App", props.Subtitle or "")
	self:_buildSidebar()
	self:_buildContentArea()

	self.Tabs = {}
	self.ActiveTab = nil
	self._minimized = false
	self._bodyHeight = self.MainFrame.Size

	self:_makeDraggable(self.TopBar)

	return self
end

function UILib:_buildTopBar(title, subtitle)
	self.TopBar = new("Frame", {
		Name = "TopBar",
		Size = UDim2.new(1, 0, 0, 56),
		BackgroundColor3 = THEME.Panel,
		Parent = self.MainFrame,
	}, { corner(14) })

	-- Tutup sudut bawah topbar biar nyatu sama body (patch corner)
	new("Frame", {
		Size = UDim2.new(1, 0, 0, 14),
		Position = UDim2.new(0, 0, 1, -14),
		BackgroundColor3 = THEME.Panel,
		BorderSizePixel = 0,
		Parent = self.TopBar,
	})

	new("TextLabel", {
		Text = title,
		Font = FONT_BOLD,
		TextSize = 18,
		TextColor3 = THEME.TextPrimary,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 20, 0, 8),
		Size = UDim2.new(0.6, 0, 0, 20),
		Parent = self.TopBar,
	})

	new("TextLabel", {
		Text = subtitle,
		Font = FONT_REG,
		TextSize = 13,
		TextColor3 = THEME.TextSecond,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, 20, 0, 30),
		Size = UDim2.new(0.6, 0, 0, 16),
		Parent = self.TopBar,
	})

	-- Search box (opsional, hiasan siap pakai)
	self.SearchBox = new("TextBox", {
		PlaceholderText = "Cari...",
		Text = "",
		Font = FONT_REG,
		TextSize = 13,
		TextColor3 = THEME.TextPrimary,
		PlaceholderColor3 = THEME.TextSecond,
		BackgroundColor3 = THEME.ItemBg,
		Size = UDim2.new(0, 180, 0, 32),
		Position = UDim2.new(1, -230, 0.5, -16),
		Parent = self.TopBar,
	}, { corner(8), stroke(THEME.Border, 1) })
	new("UIPadding", { PaddingLeft = UDim.new(0, 10), Parent = self.SearchBox })

	-- Tombol minimize
	self.MinimizeBtn = new("TextButton", {
		Text = "-",
		Font = FONT_BOLD,
		TextSize = 20,
		TextColor3 = THEME.TextPrimary,
		BackgroundColor3 = THEME.ItemBg,
		Size = UDim2.new(0, 32, 0, 32),
		Position = UDim2.new(1, -80, 0.5, -16),
		AutoButtonColor = false,
		Parent = self.TopBar,
	}, { corner(8) })

	-- Tombol close
	self.CloseBtn = new("TextButton", {
		Text = "X",
		Font = FONT_BOLD,
		TextSize = 16,
		TextColor3 = Color3.fromRGB(255, 255, 255),
		BackgroundColor3 = THEME.Accent,
		Size = UDim2.new(0, 32, 0, 32),
		Position = UDim2.new(1, -40, 0.5, -16),
		AutoButtonColor = false,
		Parent = self.TopBar,
	}, { corner(8) })

	self.CloseBtn.MouseButton1Click:Connect(function()
		self.ScreenGui:Destroy()
	end)

	self.MinimizeBtn.MouseButton1Click:Connect(function()
		self:ToggleMinimize()
	end)
end

function UILib:_buildSidebar()
	self.Sidebar = new("Frame", {
		Name = "Sidebar",
		Size = UDim2.new(0, 190, 1, -56),
		Position = UDim2.new(0, 0, 0, 56),
		BackgroundColor3 = THEME.Panel,
		Parent = self.MainFrame,
	})

	self.TabList = new("UIListLayout", {
		Padding = UDim.new(0, 4),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = new("Frame", {
			Name = "TabButtons",
			Size = UDim2.new(1, -20, 1, -20),
			Position = UDim2.new(0, 10, 0, 10),
			BackgroundTransparency = 1,
			Parent = self.Sidebar,
		}),
	}).Parent
end

function UILib:_buildContentArea()
	self.ContentArea = new("Frame", {
		Name = "Content",
		Size = UDim2.new(1, -190, 1, -56),
		Position = UDim2.new(0, 190, 0, 56),
		BackgroundTransparency = 1,
		Parent = self.MainFrame,
	})
end

--// ---------- MINIMIZE ---------- //--
function UILib:ToggleMinimize()
	self._minimized = not self._minimized
	if self._minimized then
		self._bodyHeight = self.MainFrame.Size
		tween(self.MainFrame, {
			Size = UDim2.new(self.MainFrame.Size.X.Scale, self.MainFrame.Size.X.Offset, 0, 56),
		}, 0.25)
		self.MinimizeBtn.Text = "+"
	else
		tween(self.MainFrame, { Size = self._bodyHeight }, 0.25)
		self.MinimizeBtn.Text = "-"
	end
end

--// ---------- DRAG WINDOW ---------- //--
function UILib:_makeDraggable(handle)
	local UserInputService = game:GetService("UserInputService")
	local dragging, dragStart, startPos

	handle.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1
			or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = self.MainFrame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
			or input.UserInputType == Enum.UserInputType.Touch) then
			local delta = input.Position - dragStart
			self.MainFrame.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
end

--// ---------- TABS ---------- //--
-- props: Name (string), Icon (rbxassetid string, opsional)
function UILib:AddTab(props)
	props = props or {}
	local isFirst = (next(self.Tabs) == nil)

	local btn = new("TextButton", {
		Name = props.Name,
		Size = UDim2.new(1, 0, 0, 40),
		BackgroundColor3 = isFirst and THEME.Accent or THEME.ItemBg,
		AutoButtonColor = false,
		Text = "",
		Parent = self.TabList,
	}, { corner(8) })

	if props.Icon then
		new("ImageLabel", {
			Image = props.Icon,
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 20, 0, 20),
			Position = UDim2.new(0, 12, 0.5, -10),
			ImageColor3 = THEME.TextPrimary,
			Parent = btn,
		})
	end

	new("TextLabel", {
		Text = props.Name,
		Font = FONT_BOLD,
		TextSize = 14,
		TextColor3 = THEME.TextPrimary,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, props.Icon and 42 or 14, 0, 0),
		Size = UDim2.new(1, -50, 1, 0),
		Parent = btn,
	})

	local page = new("ScrollingFrame", {
		Name = props.Name .. "_Page",
		Size = UDim2.fromScale(1, 1),
		BackgroundTransparency = 1,
		BorderSizePixel = 0,
		ScrollBarThickness = 4,
		ScrollBarImageColor3 = THEME.Accent,
		CanvasSize = UDim2.new(0, 0, 0, 0),
		AutomaticCanvasSize = Enum.AutomaticSize.Y,
		Visible = isFirst,
		Parent = self.ContentArea,
	})

	new("UIListLayout", {
		Padding = UDim.new(0, 10),
		SortOrder = Enum.SortOrder.LayoutOrder,
		Parent = page,
	})
	new("UIPadding", {
		PaddingLeft = UDim.new(0, 16),
		PaddingRight = UDim.new(0, 16),
		PaddingTop = UDim.new(0, 12),
		PaddingBottom = UDim.new(0, 12),
		Parent = page,
	})

	local tabObj = setmetatable({
		Name = props.Name,
		Button = btn,
		Page = page,
		Lib = self,
	}, Tab)

	self.Tabs[props.Name] = tabObj
	if isFirst then
		self.ActiveTab = tabObj
	end

	btn.MouseButton1Click:Connect(function()
		self:SetActiveTab(props.Name)
	end)

	return tabObj
end

function UILib:SetActiveTab(name)
	local target = self.Tabs[name]
	if not target then return end

	for _, tab in pairs(self.Tabs) do
		tab.Page.Visible = (tab == target)
		tween(tab.Button, {
			BackgroundColor3 = (tab == target) and THEME.Accent or THEME.ItemBg,
		}, 0.15)
	end

	self.ActiveTab = target
end

--// ---------- LIST ITEM (dengan toggle atau tombol) ---------- //--
-- props: Title, Description, Icon (rbxassetid), Type ("Toggle"|"Button"),
--        Default (bool, untuk Toggle), OnToggle(state), OnClick()
function Tab:AddItem(props)
	props = props or {}

	local item = new("Frame", {
		Size = UDim2.new(1, 0, 0, 56),
		BackgroundColor3 = THEME.ItemBg,
		Parent = self.Page,
	}, { corner(10), stroke(THEME.Border, 1) })

	if props.Icon then
		new("ImageLabel", {
			Image = props.Icon,
			BackgroundTransparency = 1,
			Size = UDim2.new(0, 22, 0, 22),
			Position = UDim2.new(0, 16, 0.5, -11),
			ImageColor3 = THEME.TextPrimary,
			Parent = item,
		})
	end

	local textX = props.Icon and 52 or 16
	new("TextLabel", {
		Text = props.Title or "Item",
		Font = FONT_BOLD,
		TextSize = 15,
		TextColor3 = THEME.TextPrimary,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, textX, 0, 8),
		Size = UDim2.new(1, -160, 0, 18),
		Parent = item,
	})

	new("TextLabel", {
		Text = props.Description or "",
		Font = FONT_REG,
		TextSize = 12,
		TextColor3 = THEME.TextSecond,
		TextXAlignment = Enum.TextXAlignment.Left,
		BackgroundTransparency = 1,
		Position = UDim2.new(0, textX, 0, 28),
		Size = UDim2.new(1, -160, 0, 16),
		Parent = item,
	})

	if props.Type == "Toggle" then
		local state = props.Default or false

		local toggleBg = new("Frame", {
			Size = UDim2.new(0, 44, 0, 24),
			Position = UDim2.new(1, -60, 0.5, -12),
			BackgroundColor3 = state and THEME.Accent or THEME.AccentDim,
			Parent = item,
		}, { corner(12) })

		local knob = new("Frame", {
			Size = UDim2.new(0, 18, 0, 18),
			Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
			BackgroundColor3 = Color3.fromRGB(255, 255, 255),
			Parent = toggleBg,
		}, { corner(9) })

		local clickArea = new("TextButton", {
			Size = UDim2.fromScale(1, 1),
			BackgroundTransparency = 1,
			Text = "",
			Parent = toggleBg,
		})

		clickArea.MouseButton1Click:Connect(function()
			state = not state
			tween(toggleBg, { BackgroundColor3 = state and THEME.Accent or THEME.AccentDim }, 0.15)
			tween(knob, {
				Position = state and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9),
			}, 0.15)
			if props.OnToggle then
				props.OnToggle(state)
			end
		end)

	elseif props.Type == "Button" then
		local btn = new("TextButton", {
			Text = props.ButtonText or "Jalankan",
			Font = FONT_BOLD,
			TextSize = 13,
			TextColor3 = Color3.fromRGB(255, 255, 255),
			BackgroundColor3 = THEME.Accent,
			Size = UDim2.new(0, 90, 0, 30),
			Position = UDim2.new(1, -106, 0.5, -15),
			AutoButtonColor = false,
			Parent = item,
		}, { corner(8) })

		btn.MouseButton1Click:Connect(function()
			if props.OnClick then
				props.OnClick()
			end
		end)
	else
		-- Default: chevron indikator seperti referensi (tanpa aksi)
		new("TextLabel", {
			Text = ">",
			Font = FONT_BOLD,
			TextSize = 16,
			TextColor3 = THEME.Accent,
			BackgroundTransparency = 1,
			Position = UDim2.new(1, -36, 0, 0),
			Size = UDim2.new(0, 20, 1, 0),
			Parent = item,
		})
	end

	return item
end

return UILib

--[[
	CONTOH PEMAKAIAN LENGKAP (hapus komentar & taruh di LocalScript terpisah):

	local UILib = require(game.ReplicatedStorage.UILib)

	local window = UILib.new({
		Title = "App Saya",
		Subtitle = "Pilih menu di bawah.",
	})

	local homeTab = window:AddTab({ Name = "Home" })
	homeTab:AddItem({
		Title = "Fitur A",
		Description = "Deskripsi fitur A.",
		Type = "Toggle",
		Default = false,
		OnToggle = function(state)
			print("Fitur A:", state)
		end,
	})
	homeTab:AddItem({
		Title = "Fitur B",
		Description = "Deskripsi fitur B.",
		Type = "Button",
		ButtonText = "Jalankan",
		OnClick = function()
			print("Fitur B dijalankan")
		end,
	})

	local settingsTab = window:AddTab({ Name = "Settings" })
	settingsTab:AddItem({
		Title = "Opsi Lain",
		Description = "Contoh item tanpa aksi.",
	})
--]]
