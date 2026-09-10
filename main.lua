--[[
    ROBLOX UI MASTER — RESPONSIVE UI KIT
    Fitur: Sidebar + Tab System + Search Bar + Toggle Button + Execute Animation
    Cara pakai: Paste seluruh script ini ke dalam LocalScript
    (StarterGui/StarterPlayerScripts, atau langsung di executor).
--]]

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Bersihkan UI lama biar gak numpuk kalau di-rerun
local old = playerGui:FindFirstChild("RUI_Master")
if old then old:Destroy() end

----------------------------------------------------------------
-- ROOT SCREEN GUI
----------------------------------------------------------------
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "RUI_Master"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = playerGui

----------------------------------------------------------------
-- MAIN FRAME (Responsif: AnchorPoint + UIScale + AspectRatio)
----------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0.55, 0, 0.6, 0)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Color = Color3.fromRGB(90, 90, 255)
MainStroke.Thickness = 1.5
MainStroke.Transparency = 0.3
MainStroke.Parent = MainFrame

local MainAspect = Instance.new("UIAspectRatioConstraint")
MainAspect.AspectRatio = 1.55
MainAspect.DominantAxis = Enum.DominantAxis.Width
MainAspect.Parent = MainFrame

local MainScale = Instance.new("UIScale")
MainScale.Scale = 1
MainScale.Parent = MainFrame

-- Auto-scale ringan biar tetap enak di layar kecil (mobile/tablet)
local function updateScale()
    local viewport = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize
    if not viewport then return end
    local minSide = math.min(viewport.X, viewport.Y)
    if minSide < 500 then
        MainScale.Scale = 0.8
    elseif minSide < 800 then
        MainScale.Scale = 0.9
    else
        MainScale.Scale = 1
    end
end
updateScale()
workspace.CurrentCamera:GetPropertyChangedSignal("ViewportSize"):Connect(updateScale)

----------------------------------------------------------------
-- TOP BAR (Title + Toggle Button target)
----------------------------------------------------------------
local TopBar = Instance.new("Frame")
TopBar.Name = "TopBar"
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = Color3.fromRGB(18, 18, 24)
TopBar.BorderSizePixel = 0
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 12)
TopBarCorner.Parent = TopBar

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(0.6, 0, 1, 0)
TitleLabel.Position = UDim2.new(0, 15, 0, 0)
TitleLabel.BackgroundTransparency = 1
TitleLabel.Text = "RUI MASTER"
TitleLabel.Font = Enum.Font.GothamBold
TitleLabel.TextSize = 18
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
TitleLabel.Parent = TopBar

----------------------------------------------------------------
-- BODY CONTAINER (Sidebar + Content)
----------------------------------------------------------------
local Body = Instance.new("Frame")
Body.Name = "Body"
Body.Size = UDim2.new(1, 0, 1, -40)
Body.Position = UDim2.new(0, 0, 0, 40)
Body.BackgroundTransparency = 1
Body.Parent = MainFrame

----------------------------------------------------------------
-- SIDEBAR
----------------------------------------------------------------
local Sidebar = Instance.new("Frame")
Sidebar.Name = "Sidebar"
Sidebar.Size = UDim2.new(0.28, 0, 1, 0)
Sidebar.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
Sidebar.BorderSizePixel = 0
Sidebar.Parent = Body

local SidebarPadding = Instance.new("UIPadding")
SidebarPadding.PaddingTop = UDim.new(0, 8)
SidebarPadding.PaddingLeft = UDim.new(0, 6)
SidebarPadding.PaddingRight = UDim.new(0, 6)
SidebarPadding.Parent = Sidebar

local SidebarLayout = Instance.new("UIListLayout")
SidebarLayout.FillDirection = Enum.FillDirection.Vertical
SidebarLayout.Padding = UDim.new(0, 6)
SidebarLayout.SortOrder = Enum.SortOrder.LayoutOrder
SidebarLayout.Parent = Sidebar

----------------------------------------------------------------
-- CONTENT AREA (kanan)
----------------------------------------------------------------
local Content = Instance.new("Frame")
Content.Name = "Content"
Content.Size = UDim2.new(0.72, 0, 1, 0)
Content.Position = UDim2.new(0.28, 0, 0, 0)
Content.BackgroundTransparency = 1
Content.Parent = Body

-- Search Bar
local SearchBar = Instance.new("Frame")
SearchBar.Name = "SearchBar"
SearchBar.Size = UDim2.new(1, -20, 0, 34)
SearchBar.Position = UDim2.new(0, 10, 0, 8)
SearchBar.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
SearchBar.BorderSizePixel = 0
SearchBar.Parent = Content

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 8)
SearchCorner.Parent = SearchBar

local SearchStroke = Instance.new("UIStroke")
SearchStroke.Color = Color3.fromRGB(90, 90, 255)
SearchStroke.Transparency = 0.6
SearchStroke.Parent = SearchBar

local SearchBox = Instance.new("TextBox")
SearchBox.Name = "SearchBox"
SearchBox.Size = UDim2.new(1, -20, 1, 0)
SearchBox.Position = UDim2.new(0, 10, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.PlaceholderText = "Cari fitur..."
SearchBox.Text = ""
SearchBox.Font = Enum.Font.Gotham
SearchBox.TextSize = 14
SearchBox.TextColor3 = Color3.fromRGB(255, 255, 255)
SearchBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 150)
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.ClearTextOnFocus = false
SearchBox.Parent = SearchBar

-- ScrollingFrame untuk daftar item per tab
local ScrollArea = Instance.new("ScrollingFrame")
ScrollArea.Name = "ScrollArea"
ScrollArea.Size = UDim2.new(1, -20, 1, -100)
ScrollArea.Position = UDim2.new(0, 10, 0, 50)
ScrollArea.BackgroundTransparency = 1
ScrollArea.BorderSizePixel = 0
ScrollArea.ScrollBarThickness = 5
ScrollArea.ScrollBarImageColor3 = Color3.fromRGB(90, 90, 255)
ScrollArea.CanvasSize = UDim2.new(0, 0, 0, 0)
ScrollArea.AutomaticCanvasSize = Enum.AutomaticSize.Y
ScrollArea.Parent = Content

local ScrollPadding = Instance.new("UIPadding")
ScrollPadding.PaddingTop = UDim.new(0, 4)
ScrollPadding.PaddingRight = UDim.new(0, 4)
ScrollPadding.Parent = ScrollArea

local ScrollLayout = Instance.new("UIListLayout")
ScrollLayout.Padding = UDim.new(0, 6)
ScrollLayout.SortOrder = Enum.SortOrder.LayoutOrder
ScrollLayout.Parent = ScrollArea

-- Bottom bar: Toggle + Execute button
local BottomBar = Instance.new("Frame")
BottomBar.Name = "BottomBar"
BottomBar.Size = UDim2.new(1, -20, 0, 40)
BottomBar.Position = UDim2.new(0, 10, 1, -46)
BottomBar.BackgroundTransparency = 1
BottomBar.Parent = Content

local BottomLayout = Instance.new("UIListLayout")
BottomLayout.FillDirection = Enum.FillDirection.Horizontal
BottomLayout.Padding = UDim.new(0, 8)
BottomLayout.HorizontalAlignment = Enum.HorizontalAlignment.Right
BottomLayout.VerticalAlignment = Enum.VerticalAlignment.Center
BottomLayout.SortOrder = Enum.SortOrder.LayoutOrder
BottomLayout.Parent = BottomBar

----------------------------------------------------------------
-- HELPER: Bikin item list dengan toggle
----------------------------------------------------------------
local function CreateToggleItem(name, order)
    local Item = Instance.new("Frame")
    Item.Name = name
    Item.Size = UDim2.new(1, 0, 0, 38)
    Item.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    Item.BorderSizePixel = 0
    Item.LayoutOrder = order
    Item.Parent = ScrollArea

    local ItemCorner = Instance.new("UICorner")
    ItemCorner.CornerRadius = UDim.new(0, 8)
    ItemCorner.Parent = Item

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, 0, 1, 0)
    Label.Position = UDim2.new(0, 12, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextColor3 = Color3.fromRGB(230, 230, 230)
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = Item

    -- Toggle switch (pill style)
    local ToggleBG = Instance.new("Frame")
    ToggleBG.Size = UDim2.new(0, 44, 0, 22)
    ToggleBG.Position = UDim2.new(1, -56, 0.5, 0)
    ToggleBG.AnchorPoint = Vector2.new(0, 0.5)
    ToggleBG.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    ToggleBG.BorderSizePixel = 0
    ToggleBG.Parent = Item

    local ToggleBGCorner = Instance.new("UICorner")
    ToggleBGCorner.CornerRadius = UDim.new(1, 0)
    ToggleBGCorner.Parent = ToggleBG

    local Knob = Instance.new("Frame")
    Knob.Size = UDim2.new(0, 18, 0, 18)
    Knob.Position = UDim2.new(0, 2, 0.5, 0)
    Knob.AnchorPoint = Vector2.new(0, 0.5)
    Knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Knob.BorderSizePixel = 0
    Knob.Parent = ToggleBG

    local KnobCorner = Instance.new("UICorner")
    KnobCorner.CornerRadius = UDim.new(1, 0)
    KnobCorner.Parent = Knob

    local state = false
    ToggleBG.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            state = not state
            local targetColor = state and Color3.fromRGB(90, 90, 255) or Color3.fromRGB(60, 60, 70)
            local targetPos = state and UDim2.new(1, -20, 0.5, 0) or UDim2.new(0, 2, 0.5, 0)
            TweenService:Create(ToggleBG, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {BackgroundColor3 = targetColor}):Play()
            TweenService:Create(Knob, TweenInfo.new(0.18, Enum.EasingStyle.Quad), {Position = targetPos}):Play()
        end
    end)

    return Item
end

----------------------------------------------------------------
-- TAB SYSTEM
----------------------------------------------------------------
local tabs = {
    Main = {"Auto Farm", "Auto Collect", "Speed Boost", "Fly Mode", "ESP Player"},
    Settings = {"UI Scale", "Notifications", "Sound FX", "Auto Save"},
    Info = {"Credits", "Version 1.0.0", "Discord Server"},
}

local tabButtons = {}
local activeTab = nil

local function RenderTab(tabName)
    -- Bersihkan ScrollArea
    for _, child in ipairs(ScrollArea:GetChildren()) do
        if child:IsA("Frame") then
            child:Destroy()
        end
    end

    local list = tabs[tabName] or {}
    for i, itemName in ipairs(list) do
        CreateToggleItem(itemName, i)
    end

    -- Update visual tab aktif
    for name, btn in pairs(tabButtons) do
        if name == tabName then
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(90, 90, 255)}):Play()
        else
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(30, 30, 38)}):Play()
        end
    end

    activeTab = tabName
end

local order = 0
for tabName, _ in pairs(tabs) do
    order += 1
    local TabBtn = Instance.new("TextButton")
    TabBtn.Name = tabName .. "TabBtn"
    TabBtn.Size = UDim2.new(1, 0, 0, 36)
    TabBtn.BackgroundColor3 = Color3.fromRGB(30, 30, 38)
    TabBtn.BorderSizePixel = 0
    TabBtn.Text = tabName
    TabBtn.Font = Enum.Font.GothamBold
    TabBtn.TextSize = 14
    TabBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    TabBtn.AutoButtonColor = false
    TabBtn.LayoutOrder = order
    TabBtn.Parent = Sidebar

    local TabCorner = Instance.new("UICorner")
    TabCorner.CornerRadius = UDim.new(0, 8)
    TabCorner.Parent = TabBtn

    TabBtn.MouseButton1Click:Connect(function()
        RenderTab(tabName)
    end)

    tabButtons[tabName] = TabBtn
end

-- Search filter sederhana: sembunyikan item yang tidak match
SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
    local query = SearchBox.Text:lower()
    for _, child in ipairs(ScrollArea:GetChildren()) do
        if child:IsA("Frame") then
            if query == "" then
                child.Visible = true
            else
                child.Visible = child.Name:lower():find(query, 1, true) ~= nil
            end
        end
    end
end)

-- Render tab default
RenderTab("Main")

----------------------------------------------------------------
-- EXECUTE BUTTON (dengan animasi klik + loading pulse)
----------------------------------------------------------------
local ExecuteBtn = Instance.new("TextButton")
ExecuteBtn.Name = "ExecuteBtn"
ExecuteBtn.Size = UDim2.new(0, 110, 1, 0)
ExecuteBtn.BackgroundColor3 = Color3.fromRGB(90, 90, 255)
ExecuteBtn.Text = "EXECUTE"
ExecuteBtn.Font = Enum.Font.GothamBold
ExecuteBtn.TextSize = 15
ExecuteBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ExecuteBtn.AutoButtonColor = false
ExecuteBtn.LayoutOrder = 2
ExecuteBtn.Parent = BottomBar

local ExecuteCorner = Instance.new("UICorner")
ExecuteCorner.CornerRadius = UDim.new(0, 8)
ExecuteCorner.Parent = ExecuteBtn

local ExecuteGradient = Instance.new("UIGradient")
ExecuteGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(90, 90, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(150, 90, 255)),
})
ExecuteGradient.Rotation = 45
ExecuteGradient.Parent = ExecuteBtn

local executing = false
ExecuteBtn.MouseButton1Click:Connect(function()
    if executing then return end
    executing = true

    local originalText = ExecuteBtn.Text
    ExecuteBtn.Text = "RUNNING..."

    -- Pulse scale animasi
    local pulseUp = TweenService:Create(ExecuteBtn, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 100, 1, -4)})
    local pulseDown = TweenService:Create(ExecuteBtn, TweenInfo.new(0.12, Enum.EasingStyle.Quad), {Size = UDim2.new(0, 110, 1, 0)})
    pulseUp:Play()
    pulseUp.Completed:Wait()
    pulseDown:Play()

    -- Simulasikan proses (aman, tidak melakukan apapun berbahaya)
    task.wait(0.6)

    ExecuteBtn.Text = "DONE ✓"
    task.wait(0.6)
    ExecuteBtn.Text = originalText
    executing = false
end)

----------------------------------------------------------------
-- TOGGLE BUTTON UNTUK SHOW/HIDE UI (contoh: klik kanan atas)
----------------------------------------------------------------
local ToggleUIBtn = Instance.new("TextButton")
ToggleUIBtn.Name = "ToggleUIBtn"
ToggleUIBtn.Size = UDim2.new(0, 30, 0, 30)
ToggleUIBtn.Position = UDim2.new(1, -35, 0.5, 0)
ToggleUIBtn.AnchorPoint = Vector2.new(0, 0.5)
ToggleUIBtn.BackgroundColor3 = Color3.fromRGB(35, 35, 44)
ToggleUIBtn.Text = "—"
ToggleUIBtn.Font = Enum.Font.GothamBold
ToggleUIBtn.TextSize = 16
ToggleUIBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleUIBtn.AutoButtonColor = false
ToggleUIBtn.Parent = TopBar

local ToggleUICorner = Instance.new("UICorner")
ToggleUICorner.CornerRadius = UDim.new(0, 6)
ToggleUICorner.Parent = ToggleUIBtn

local bodyVisible = true
ToggleUIBtn.MouseButton1Click:Connect(function()
    bodyVisible = not bodyVisible
    local targetSize = bodyVisible and UDim2.new(0.55, 0, 0.6, 0) or UDim2.new(0.55, 0, 0, 40)
    TweenService:Create(MainFrame, TweenInfo.new(0.25, Enum.EasingStyle.Quad), {Size = targetSize}):Play()
end)

----------------------------------------------------------------
-- FLOATING SHOW BUTTON (buka lagi kalau UI ke-minimize penuh, opsional)
----------------------------------------------------------------
-- Draggable pada TopBar biar UX enak (drag whole window dari topbar)
do
    local dragging = false
    local dragInput, mousePos, framePos

    TopBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1
            or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            mousePos = input.Position
            framePos = MainFrame.Position

            input.Changed:Connect(function()
                if input.UserInputState == Enum.UserInputState.End then
                    dragging = false
                end
            end)
        end
    end)

    TopBar.InputChanged:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseMovement
            or input.UserInputType == Enum.UserInputType.Touch then
            dragInput = input
        end
    end)

    game:GetService("UserInputService").InputChanged:Connect(function(input)
        if input == dragInput and dragging then
            local delta = input.Position - mousePos
            MainFrame.Position = UDim2.new(
                framePos.X.Scale, framePos.X.Offset + delta.X,
                framePos.Y.Scale, framePos.Y.Offset + delta.Y
            )
        end
    end)
end
