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

 v = lib:CreateWindow({
        Title = "ZIK HUB",
        Subtitle = "Violance District",
        SubtitleColor = Color3.fromRGB(190, 140, 255),
        Logo = "rbxassetid://118755181202304",
        LogoSize = 32,
        SphereText = false,
        SphereWords = "ZKHUB",
        SphereImage = "rbxassetid://118755181202304",
        SphereIconSize = 38,
        Watermark = true,
        WatermarkText = "ZKHUB",
        WatermarkIcon = "rbxassetid://118755181202304",
    })

    Players = game:GetService("Players")
    localPlayer = Players.LocalPlayer
    RunService = game:GetService("RunService")
    UserInputService = game:GetService("UserInputService")
    VirtualInputManager = game:GetService("VirtualInputManager")
    local GuiService = game:GetService("GuiService")
    ReplicatedStorage = game:GetService("ReplicatedStorage")
    CoreGui = game:GetService("CoreGui")
    playerGui = localPlayer:WaitForChild("PlayerGui")
    currentCamera = workspace.CurrentCamera
    CollectionService = game:GetService("CollectionService")
    HttpService = game:GetService("HttpService")
    game:GetService("TeleportService")
    local TweenService = game:GetService("TweenService")
    _G.Ox = {}
    _G.Ox.AntiBlindEnabled = false
    _G.Ox.GotBlindedRemote = nil
    _G.Ox.NoSlowdownEnabled = false
    _G.Ox.BypassLeapEnabled = false
    _G.Ox.InfAbyssalEnabled = false
    _G.Ox.KILLER_SilentAimFlask = false
    _G.Ox.KILLER_FlaskLaser = false
    _G.Ox.NEX_CureFlaskLaserThread = nil
    _G.Ox.NEX_CureFlaskLaserPart = nil
    _G.Ox.InfiniteLungeEnabled = false

    local tbl5 = {
        ["122812055447896"] = "Veil lunge",
        ["133963973694098"] = "Mayers Basic",
        ["117042998468241"] = "Mayers lunge",
        ["135002183282873"] = "cure lunge",
        ["121216847022485"] = "cure Basic",
        ["132817836308238"] = "Jeff Basic",
        ["129784271201071"] = "Jeff lunge",
        ["82666958311998"] = "Jeff Frenzy",
        ["78432063483146"] = "Abyssal Basic",
        ["118907603246885"] = "Abyssal lunge",
        ["139369275981139"] = "Jason Basic",
        ["110355011987939"] = "Jason lunge",
        ["111920872708571"] = "Masked Basic",
        ["105374834496520"] = "Masked lunge",
        ["138720291317243"] = "Masked Tony",
        ["106871536134254"] = "Masked Alex",
        ["130593238885843"] = "Masked Cobra",
        ["115244153053858"] = "Masked Cobra lunge",
        ["74968262036854"] = "Hidden Basic",
        ["113255068724446"] = "Hidden lunge",
        ["98163597193511"] = "Hidden S1",
        ["80411309607666"] = "Abyssal S1",
    }

    _G.Ox.ParryConfig = {
        AutoParry = false,
        ParrySafety = false,
        ParryAggressive = false,
        ParryCircle = true,
        ParryRadius = 15,
        ParryFace = 0.7,
        AutoCrouch = false,
        Ignored_Skills = {},
    }

    _G.Ox.ParryV2 = {
        Enabled = false,
        SafetyParry = false,
        Mode = "Legit",
        Trigger = "Remote",
        Range = 12,
        KillerFace = 0.6,
        ShowCircle = true,
        IsOnCooldown = false,
        IsResolving = false,
        CooldownToken = 0,
        CooldownThread = nil,
        Attached = {},
        Gradients = {},
        Icon = nil,
        LockConnection = nil,
        ParryTrack = nil,
        RangeAdornment = nil,
        BtnCache = nil,
    }

    _G.Ox.ParryV2Anim = {
        Default = "rbxassetid://109133187196613",
        Shield = "rbxassetid://75939529748815",
        Robot = "rbxassetid://126894569253341",
        Katana = "rbxassetid://127096285501517",
        Fish = "rbxassetid://123307242865945",
        Watcher = "rbxassetid://81793464499285",
        Enten = "rbxassetid://127096285501517",
        BloodShield = "rbxassetid://75939529748815",
        Fih = "rbxassetid://123307242865945",
        Feedbacker = "rbxassetid://126894569253341",
        StopWatch = "rbxassetid://81793464499285",
    }

    _G.Ox.ParryV2AttackAnims = {
        ["rbxassetid://78432063483146"] = true,
        ["rbxassetid://121216847022485"] = true,
        ["rbxassetid://74968262036854"] = true,
        ["rbxassetid://132817836308238"] = true,
        ["rbxassetid://82666958311998"] = true,
        ["rbxassetid://111920872708571"] = true,
        ["rbxassetid://106871536134254"] = true,
        ["rbxassetid://109402730355822"] = true,
        ["rbxassetid://130593238885843"] = true,
        ["rbxassetid://138720291317243"] = true,
        ["rbxassetid://139369275981139"] = true,
        ["rbxassetid://133963973694098"] = true,
        ["rbxassetid://78935059863801"] = true,
        ["rbxassetid://118907603246885"] = true,
        ["rbxassetid://135002183282873"] = true,
        ["rbxassetid://113255068724446"] = true,
        ["rbxassetid://129784271201071"] = true,
        ["rbxassetid://105374834496520"] = true,
        ["rbxassetid://117070354890871"] = true,
        ["rbxassetid://115244153053858"] = true,
        ["rbxassetid://110355011987939"] = true,
        ["rbxassetid://117042998468241"] = true,
        ["rbxassetid://122812055447896"] = true,
    }

    _G.Ox._V2RayParams = RaycastParams.new()
    _G.Ox._V2RayParams.FilterType = Enum.RaycastFilterType.Exclude
    _G.Ox._V2ParryRangeRay = RaycastParams.new()
    _G.Ox._V2ParryRangeRay.FilterType = Enum.RaycastFilterType.Exclude
    _G.Ox._V2ParryLastRadius = -1
    _G.Ox._V2ParryLastRoot = nil
    _G.Ox.AttachedParry = {}

    if not _G.Ox.State then
        _G.Ox.State = {}
    end

    _G.Ox.State.ParryCooldown = false
    _G.Ox.State.ParryCooldownTime = 60
    _G.Ox.State.AutoParryAdornment = nil
    _G.Ox.State.ParryCooldownThread = nil
    _G.Ox.AutoParryCustom = {Gui = nil, IsActive = false, GuiVisible = false}
    local ox = _G.Ox
    local parryHUD = _G.Ox.ParryHUD
    local v3 = parryHUD

    if not parryHUD then
        local tbl6 = {}
        v3 = tbl6
        tbl6.gradients = {}
        tbl6.icon = nil
        tbl6.rescanConn = nil
        tbl6.cachedIconColor = nil
    end

    ox.ParryHUD = v3
    ParryHUD = _G.Ox.ParryHUD

    IsDowned = function(arg)
        if not arg then
            return false
        end
        local flag2 = arg:GetAttribute("Knocked") == true or arg:GetAttribute("IsHooked") == true
        return flag2
    end

    IsKiller = function(arg)
        local flag2 = arg and arg.Team and arg.Team.Name == "Killer"
        return flag2
    end

    TriggerCrouch = function()
        pcall(function()
            local playerGui2 = localPlayer:FindFirstChild("PlayerGui")

            for match in string.gmatch("Survivor-mob.Controls.crouch.icon", "[^%.]+") do
                if playerGui2 then
                    playerGui2 = playerGui2:FindFirstChild(match)
                end
            end

            if playerGui2 and playerGui2:IsA("GuiObject") and playerGui2.Visible and playerGui2.Parent and playerGui2.Parent:IsA("GuiButton") then
                local parent = playerGui2.Parent

                if UserInputService.TouchEnabled and type(firesignal) == "function" then
                    firesignal(parent.MouseButton1Click)
                    task.wait(1.4)
                    firesignal(parent.MouseButton1Click)
                else
                    VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
                    task.wait(1.4)
                    VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
                end
            else
                VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.LeftControl, false, game)
                task.wait(1.4)
                VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.LeftControl, false, game)
            end
        end)
    end

    IsSafeToParry = function(arg)
        if not _G.Ox.ParryConfig.ParrySafety then
            return true
        end

        if not arg then
            return false
        end
        local checkInterractable = arg:FindFirstChild("CheckInterractable")

        if checkInterractable then
            if checkInterractable:GetAttribute("isVaulting") == true then
                return false
            end

            if checkInterractable:GetAttribute("isRepairing") == true then
                return false
            end

            if checkInterractable:GetAttribute("isUnhooking") == true then
                return false
            end

            if checkInterractable:GetAttribute("isHealing") == true then
                return false
            end

            if checkInterractable:GetAttribute("isSliding") == true then
                return false
            end
        end

        return true
    end

    tapMobileParryButton = function()
        local playerGui2 = localPlayer:FindFirstChild("PlayerGui")
        if not playerGui2 then
            return
        end
        local survivorMob = playerGui2:FindFirstChild("Survivor-mob")
        local guiMob = survivorMob and survivorMob:FindFirstChild("Controls") and survivorMob.Controls:FindFirstChild("Gui-mob")

        if guiMob and guiMob.Visible then
            if firesignal then
                pcall(function()
                    firesignal(guiMob.MouseButton1Down)
                    task.wait(0.01)
                    firesignal(guiMob.MouseButton1Up)
                end)
            end
        else
            pcall(function()
                if not mouse2click then
                    if mouse2press and mouse2release then
                        mouse2press()
                        task.wait(0.01)
                        mouse2release()
                        return
                    end

                    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, true, game, 0)
                    task.wait(0.01)
                    VirtualInputManager:SendMouseButtonEvent(0, 0, 1, false, game, 0)
                    return
                end

                mouse2click()
            end)
        end
    end

    ExecuteParry = function()
        if _G.Ox.State.ParryCooldown then
            return
        end
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        local items = remotes and remotes:FindFirstChild("Items")
        local parryingDagger = items and items:FindFirstChild("Parrying Dagger")
        local parry = parryingDagger and parryingDagger:FindFirstChild("parry")

        if parry then
            for i = 1, 8 do
                parry:FireServer()
            end
        end

        task.spawn(tapMobileParryButton)
    end

    ParryHUD.Scan = function()
        local playerGui2 = localPlayer:FindFirstChild("PlayerGui")
        if not playerGui2 then
            return false
        end
        table.clear(ParryHUD.gradients)
        ParryHUD.icon = nil

        for i, v4 in ipairs({"Survivor", "Survivor-con"}) do
            local v5 = playerGui2:FindFirstChild(v4)

            if v5 then
                local gen = v5:FindFirstChild("Gen")
                local itemFrame = gen and gen:FindFirstChild("ItemFrame")

                if itemFrame then
                    local gui = itemFrame:FindFirstChild("Gui")
                    local bar = gui and gui:FindFirstChild("Bar")
                    local uiGradient = bar and bar:FindFirstChild("UIGradient")

                    if uiGradient then
                        table.insert(ParryHUD.gradients, uiGradient)
                    end

                    local icon = itemFrame:FindFirstChild("icon")

                    if icon then
                        ParryHUD.icon = icon
                    end
                end
            end
        end

        local survivorMob = playerGui2:FindFirstChild("Survivor-mob")
        local controls = survivorMob and survivorMob:FindFirstChild("Controls")

        if controls then
            for i, child in ipairs(controls:GetChildren()) do
                if child:IsA("ImageButton") and child.Name == "Gui-mob" then
                    local bar = child:FindFirstChild("Bar")
                    local uiGradient = bar and bar:FindFirstChild("UIGradient")

                    if uiGradient then
                        table.insert(ParryHUD.gradients, uiGradient)
                    end
                end
            end
        end

        local flag2 = #ParryHUD.gradients > 0 or ParryHUD.icon ~= nil
        return flag2
    end

    ParryHUD.SetColor = function(cachedIconColor)
        if #ParryHUD.gradients == 0 and not ParryHUD.icon then
            ParryHUD.Scan()
        end

        ParryHUD.cachedIconColor = cachedIconColor

        for i, gradient in ipairs(ParryHUD.gradients) do
            if gradient and gradient.Parent and gradient.Parent.Parent then
                local icon = gradient.Parent.Parent:FindFirstChild("icon")

                if icon then
                    icon.ImageColor3 = cachedIconColor
                end

                local gui = gradient.Parent.Parent:FindFirstChild("Gui")

                if gui then
                    gui.ImageColor3 = cachedIconColor
                end
            end
        end

        if ParryHUD.icon then
            ParryHUD.icon.ImageColor3 = cachedIconColor
        end
    end

    ParryHUD.Tween = function(arg)
        if #ParryHUD.gradients == 0 then
            ParryHUD.Scan()
        end

        for i, gradient in ipairs(ParryHUD.gradients) do
            if gradient and gradient.Parent then
                gradient.Offset = Vector2.new(0, 0.75)
                local tween = TweenService:Create(gradient, TweenInfo.new(arg, Enum.EasingStyle.Linear), {Offset = Vector2.new(0, 0.25)})
                tween:Play()

                tween.Completed:Connect(function()
                    if not _G.Ox.State.ParryCooldown then
                        ParryHUD.SetColor(Color3.fromRGB(255, 255, 255))
                    end
                end)
            end
        end
    end

    ParryHUD.Reset = function()
        ParryHUD.SetColor(Color3.fromRGB(255, 255, 255))

        for i, gradient in ipairs(ParryHUD.gradients) do
            if gradient and gradient.Parent then
                gradient.Offset = Vector2.new(0, 0.25)
            end
        end
    end

    ParryHUD.SetupWatcher = function()
        if ParryHUD.rescanConn then
            ParryHUD.rescanConn:Disconnect()
        end

        local playerGui2 = localPlayer:FindFirstChild("PlayerGui")
        if not playerGui2 then
            return
        end

        ParryHUD.rescanConn = playerGui2.ChildAdded:Connect(function(child)
            local name = child.Name

            if name == "Survivor" or name == "Survivor-con" or name == "Survivor-mob" then
                task.wait(0.3)
                ParryHUD.Scan()

                if _G.Ox.State.ParryCooldown and ParryHUD.cachedIconColor then
                    ParryHUD.SetColor(ParryHUD.cachedIconColor)
                end
            end
        end)

        task.spawn(function()
            local n = 0

            while n < 10 and not ParryHUD.Scan() do
                task.wait(0.5)
                n = n + 0.5
            end
        end)
    end

    ParryHUD.SetupWatcher()

    localPlayer.CharacterAdded:Connect(function()
        task.wait(1.5)
        ParryHUD.Scan()

        if _G.Ox.State.ParryCooldown and ParryHUD.cachedIconColor then
            ParryHUD.SetColor(ParryHUD.cachedIconColor)
        end
    end)

    ListenToParryResult = function()
        task.spawn(function()
            local remotes = ReplicatedStorage:WaitForChild("Remotes", 5)
            local parryingDagger = remotes and remotes:WaitForChild("Items", 5):WaitForChild("Parrying Dagger", 5)
            local parryResult = parryingDagger and parryingDagger:WaitForChild("parryResult", 5)

            if parryResult then
                parryResult.OnClientEvent:Connect(function(arg, arg2)
                    local num = tonumber(arg2)
                    local n = num or (arg == true and 90 or 60)
                    _G.Ox.State.ParryCooldown = true

                    if _G.Ox.State.ParryCooldownThread then
                        task.cancel(_G.Ox.State.ParryCooldownThread)
                    end

                    ParryHUD.SetColor(Color3.fromRGB(77, 77, 77))
                    ParryHUD.Tween(n)

                    _G.Ox.State.ParryCooldownThread = task.delay(n, function()
                        _G.Ox.State.ParryCooldown = false
                        ParryHUD.SetColor(Color3.fromRGB(255, 255, 255))
                    end)
                end)
            end
        end)
    end

    ListenToParryResult()

    IsInKillerPOV = function(arg, arg2, arg3)
        if not arg or not arg2 then
            return false
        end
        local n = arg2.Position - arg.Position
        local vector = Vector3.new(n.X, 0, n.Z)
        if vector.Magnitude < 0.15 then
            return true
        end
        local vector2 = Vector3.new(arg.CFrame.LookVector.X, 0, arg.CFrame.LookVector.Z)
        if vector2.Magnitude < 0.05 then
            return false
        end
        local v4 = vector2.Unit:Dot(vector.Unit)
        local n2 = arg3 or 0.35
        local flag2 = n2 <= v4
        return flag2
    end

    AttachParrySensor = function(arg)
        if not arg or _G.Ox.AttachedParry[arg] then
            return
        end
        _G.Ox.AttachedParry[arg] = true
        local humanoid = arg:WaitForChild("Humanoid", 5)
        if not humanoid then
            return
        end
        local animator = humanoid:FindFirstChildOfClass("Animator")
        local animator2 = animator or humanoid:WaitForChild("Animator", 5)
        if not animator2 then
            return
        end

        humanoid.ChildAdded:Connect(function(child)
            if child:IsA("Animator") then
                _G.Ox.AttachedParry[arg] = nil
                AttachParrySensor(arg)
            end
        end)

        arg.AncestryChanged:Connect(function(child, parent)
            if not parent then
                _G.Ox.AttachedParry[arg] = nil
            end
        end)

        animator2.AnimationPlayed:Connect(function(arg2)
            local animation = arg2.Animation
            local animationId = animation and arg2.Animation.AnimationId or ""
            local match = animationId:match("%d+")
            local v4 = tbl5[match]
            if not v4 then
                return
            end

            if match == "80411309607666" and _G.Ox.ParryConfig.AutoCrouch then
                local character = localPlayer.Character
                if IsDowned(character) then
                    return
                end
                local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                local humanoidRootPart2 = arg:FindFirstChild("HumanoidRootPart")

                if humanoidRootPart and humanoidRootPart2 and (humanoidRootPart.Position - humanoidRootPart2.Position).Magnitude <= 40 then
                    TriggerCrouch()
                end

                return
            end

            if not _G.Ox.ParryConfig.AutoParry then
                return
            end

            if _G.Ox.State.ParryCooldown then
                return
            end

            if _G.Ox.ParryConfig.Ignored_Skills and _G.Ox.ParryConfig.Ignored_Skills[v4] then
                return
            end
            local character = localPlayer.Character
            if IsDowned(character) or not IsSafeToParry(character) then
                return
            end
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            local humanoidRootPart2 = arg:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart or not humanoidRootPart2 then
                return
            end
            local magnitude = (humanoidRootPart.Position - humanoidRootPart2.Position).Magnitude
            local parryFace = _G.Ox.ParryConfig.ParryFace

            if parryFace < 0.2 then
                parryFace = 0.35
            end

            if _G.Ox.ParryConfig.ParryAggressive then
                if _G.Ox.ParryConfig.ParryRadius + 5 < magnitude then
                    return
                end

                local function fn12()
                    if _G.Ox.State.ParryCooldown or IsDowned(character) then
                        return true
                    end

                    if not humanoidRootPart or not humanoidRootPart2 or not humanoidRootPart.Parent or not humanoidRootPart2.Parent then
                        return true
                    end

                    if (humanoidRootPart.Position - humanoidRootPart2.Position).Magnitude > 12 or not IsInKillerPOV(humanoidRootPart2, humanoidRootPart, parryFace) then
                        return false
                    end
                    ExecuteParry()
                    return true
                end

                if fn12() then
                    return
                end
                local connection = nil
                local now = os.clock()

                connection = RunService.Heartbeat:Connect(function()
                    if (os.clock() - now >= 0.85 or fn12()) and connection then
                        connection:Disconnect()
                    end
                end)
            else
                local n = _G.Ox.ParryConfig.ParryRadius + 2
                if _G.Ox.ParryConfig.ParryRadius + 6 < magnitude then
                    return
                end

                if magnitude <= n and IsInKillerPOV(humanoidRootPart2, humanoidRootPart, parryFace) then
                    ExecuteParry()
                    return
                end
                local now = os.clock()
                local connection = nil

                connection = RunService.Heartbeat:Connect(function()
                    if os.clock() - now < 0.28 and not _G.Ox.State.ParryCooldown and humanoidRootPart and humanoidRootPart2 and humanoidRootPart.Parent and humanoidRootPart2.Parent and not IsDowned(character) then
                        if (humanoidRootPart.Position - humanoidRootPart2.Position).Magnitude <= n and IsInKillerPOV(humanoidRootPart2, humanoidRootPart, parryFace) then
                            ExecuteParry()

                            if connection then
                                connection:Disconnect()
                            end
                        end

                        return
                    end

                    if connection then
                        connection:Disconnect()
                    end
                end)
            end
        end)
    end

    TryAttachParry = function(arg)
        if arg ~= localPlayer and IsKiller(arg) and arg.Character then
            AttachParrySensor(arg.Character)
        end
    end

    SetupPlayerParry = function(arg)
        if arg == localPlayer then
            return
        end

        arg.CharacterAdded:Connect(function()
            TryAttachParry(arg)
        end)

        arg:GetPropertyChangedSignal("Team"):Connect(function()
            TryAttachParry(arg)
        end)

        if arg.Character then
            TryAttachParry(arg)
        end
    end

    for i, player in ipairs(Players:GetPlayers()) do
        SetupPlayerParry(player)
    end

    Players.PlayerAdded:Connect(SetupPlayerParry)

    V2_HasParryingDagger = function()
        local character = localPlayer.Character
        if not character then
            return false
        end

        if character:FindFirstChild("Parrying Dagger") then
            return true
        end

        for i, child in ipairs(character:GetChildren()) do
            if child.Name == "Parrying Dagger" and (child:IsA("Tool") or child:IsA("Accessory") or child:IsA("Model")) then
                return true
            end
        end

        return false
    end

    V2_IsBusy = function()
        local character = localPlayer.Character
        if not character then
            return true
        end

        if localPlayer:GetAttribute("IsDead") then
            return true
        end

        if character:GetAttribute("IsCarried") then
            return true
        end

        if character:GetAttribute("IsHooked") then
            return true
        end
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        if humanoidRootPart and CollectionService:HasTag(humanoidRootPart, "doing action") then
            return true
        end

        if IsDowned(character) then
            return true
        end
        local checkInterractable = character:FindFirstChild("CheckInterractable")

        if checkInterractable then
            if checkInterractable:GetAttribute("isVaulting") then
                return true
            end

            if checkInterractable:GetAttribute("isSliding") then
                return true
            end

            if checkInterractable:GetAttribute("isDroppingPallet") then
                return true
            end

            if checkInterractable:GetAttribute("isRepairing") then
                return true
            end

            if checkInterractable:GetAttribute("isHealing") then
                return true
            end

            if checkInterractable:GetAttribute("isUnhooking") then
                return true
            end

            if checkInterractable:GetAttribute("isExiting") then
                return true
            end
        end

        return false
    end

    V2_IsLowHealth = function()
        local character = localPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            return true
        end
        local flag2 = humanoid.Health < humanoid.MaxHealth * 0.5
        return flag2
    end

    V2_CanParry = function()
        local parryV2 = _G.Ox.ParryV2
        if not parryV2.Enabled then
            return false
        end

        if not V2_HasParryingDagger() then
            return false
        end

        if parryV2.IsOnCooldown then
            return false
        end

        if parryV2.IsResolving then
            return false
        end

        if parryV2.SafetyParry and V2_IsBusy() then
            return false
        end

        if not V2_IsLowHealth() then
            return true
        end
        return false
    end

    V2_HasLOS = function(arg)
        local character = localPlayer.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        local humanoidRootPart2 = arg and arg:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart or not humanoidRootPart2 then
            return false
        end
        local position = humanoidRootPart2.Position
        local n = humanoidRootPart.Position - position
        local magnitude = n.Magnitude
        if magnitude < 0.1 then
            return true
        end
        _G.Ox._V2RayParams.FilterDescendantsInstances = {arg, character}
        local flag2

        if workspace:Raycast(position, n.Unit * magnitude, _G.Ox._V2RayParams) then
            flag2 = false
        else
            flag2 = true
        end

        return flag2
    end

    V2_IsBtnValid = function(arg)
        if not arg or not arg.Parent then
            return false
        end

        local ok, result = pcall(function()
            if not arg:IsA("GuiButton") and not arg:IsA("ImageButton") and not arg:IsA("TextButton") then
                return false
            end

            if arg.Visible == false then
                return false
            end

            if arg.AbsoluteSize.X < 4 or arg.AbsoluteSize.Y < 4 then
                return false
            end
            local parent = arg.Parent
            local playerGui2 = localPlayer:FindFirstChild("PlayerGui")

            while parent and parent ~= playerGui2 do
                if parent:IsA("GuiObject") and parent.Visible == false then
                    return false
                end
                parent = parent.Parent
            end

            return true
        end)

        local flag2 = ok and result == true
        return flag2
    end

    V2_FindParryButton = function()
        local parryV2 = _G.Ox.ParryV2
        if parryV2.BtnCache and V2_IsBtnValid(parryV2.BtnCache) then
            return parryV2.BtnCache
        end
        local playerGui2 = localPlayer:FindFirstChild("PlayerGui")
        if not playerGui2 then
            return nil
        end

        local v4, v5, v6 = ipairs({
            {"Survivor-mob", "Controls", "Gui-mob"},
            {"SurvivorMob", "Controls", "GuiMob"},
            {"Survivor-mob", "Controls", "GuiMob"},
        })

        local v7 = v6
        local v8 = v4
        local v9 = v5

        while true do
            local v10, v11 = v8(v9, v7)
            if v10 == nil then
                break
            end
            local v12 = playerGui2

            for i, v13 in ipairs(v11) do
                local v14 = v12 and v12:FindFirstChild(v13)
                v12 = v14
            end

            v7 = v10
            if v12 and V2_IsBtnValid(v12) then
                parryV2.BtnCache = v12
                return v12
            end
        end

        return nil
    end

    V2_TriggerByButton = function()
        local v4 = V2_FindParryButton()

        if not v4 then
            pcall(function()
                local mouseLocation = UserInputService:GetMouseLocation()
                VirtualInputManager:SendMouseButtonEvent(mouseLocation.X, mouseLocation.Y, 1, true, game, 0)

                task.delay(0.06, function()
                    local mouseLocation2 = UserInputService:GetMouseLocation()
                    VirtualInputManager:SendMouseButtonEvent(mouseLocation2.X, mouseLocation2.Y, 1, false, game, 0)
                end)
            end)

            return false
        end

        pcall(function()
            if type(firesignal) == "function" then
                firesignal(v4.MouseButton1Down)

                task.delay(0.06, function()
                    pcall(function()
                        firesignal(v4.MouseButton1Up)

                        if v4.MouseButton1Click then
                            firesignal(v4.MouseButton1Click)
                        end
                    end)
                end)
            else
                local absolutePosition = v4.AbsolutePosition
                local absoluteSize = v4.AbsoluteSize
                local guiInset = GuiService:GetGuiInset()
                local n = absolutePosition.X + absoluteSize.X / 2 + guiInset.X
                local n2 = absolutePosition.Y + absoluteSize.Y / 2 + guiInset.Y
                local n3 = 9901 + math.random(1, 400)
                VirtualInputManager:SendTouchEvent(n3, 0, n, n2)

                task.delay(0.06, function()
                    pcall(function()
                        VirtualInputManager:SendTouchEvent(n3, 2, n, n2)
                    end)
                end)
            end
        end)

        return true
    end

    V2_SetIconsColor = function(imageColor3)
        local parryV2 = _G.Ox.ParryV2

        if #parryV2.Gradients == 0 then
            if ParryHUD and ParryHUD.Scan then
                ParryHUD.Scan()
            end

            local v4 = ParryHUD
            local gradients = v4 and ParryHUD.gradients or {}
            parryV2.Gradients = gradients
            local v5 = ParryHUD
            local icon = v5 and ParryHUD.icon or nil
            parryV2.Icon = icon
        end

        for i, gradient in ipairs(parryV2.Gradients) do
            if gradient and gradient.Parent and gradient.Parent.Parent then
                local icon = gradient.Parent.Parent:FindFirstChild("icon")

                if icon then
                    icon.ImageColor3 = imageColor3
                end

                local gui = gradient.Parent.Parent:FindFirstChild("Gui")

                if gui then
                    gui.ImageColor3 = imageColor3
                end
            end
        end

        if parryV2.Icon then
            parryV2.Icon.ImageColor3 = imageColor3
        end
    end

    V2_PlayCooldownTween = function(arg)
        local parryV2 = _G.Ox.ParryV2

        if #parryV2.Gradients == 0 then
            if ParryHUD and ParryHUD.Scan then
                ParryHUD.Scan()
            end

            local v4 = ParryHUD
            local gradients = v4 and ParryHUD.gradients or {}
            parryV2.Gradients = gradients
    end

    for i, gradient in ipairs(parryV2.Gradients) do
            if gradient and gradient.Parent then
                gradient.Offset = Vector2.new(0, 0.75)
                local tween = TweenService:Create(gradient, TweenInfo.new(arg, Enum.EasingStyle.Linear), {Offset = Vector2.new(0, 0.25)})
                tween:Play()

                tween.Completed:Connect(function()
                    if not parryV2.IsOnCooldown then
                        V2_SetIconsColor(Color3.fromRGB(255, 255, 255))
                    end
                end)
            end
        end
    end

    V2_StartCooldown = function(arg)
        local parryV2 = _G.Ox.ParryV2
        parryV2.CooldownToken = parryV2.CooldownToken + 1
        local cooldownToken = parryV2.CooldownToken
        parryV2.IsResolving = false
        parryV2.IsOnCooldown = true
        V2_SetIconsColor(Color3.fromRGB(77, 77, 77))
        V2_PlayCooldownTween(arg)

        if parryV2.CooldownThread then
            task.cancel(parryV2.CooldownThread)
        end

        parryV2.CooldownThread = task.delay(arg, function()
            if parryV2.CooldownToken == cooldownToken then
                parryV2.IsOnCooldown = false
                V2_SetIconsColor(Color3.fromRGB(255, 255, 255))
                parryV2.CooldownThread = nil
            end
        end)
    end

    V2_ResetCooldown = function()
        local parryV2 = _G.Ox.ParryV2

        if parryV2.CooldownThread then
            task.cancel(parryV2.CooldownThread)
            parryV2.CooldownThread = nil
        end

        parryV2.IsOnCooldown = false
        parryV2.IsResolving = false
        V2_SetIconsColor(Color3.fromRGB(255, 255, 255))
    end

    V2_FaceLookDirection = function()
        local currentCamera2 = workspace.CurrentCamera
        if not currentCamera2 then
            return
        end
        local character = localPlayer.Character
        local humanoidRootPart = character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart or not humanoidRootPart.Parent then
            return
        end
        local character2 = localPlayer.Character
        local humanoid = character2 and localPlayer.Character:FindFirstChildOfClass("Humanoid")
        local lookVector = currentCamera2.CFrame.LookVector
        local vector = Vector3.new(lookVector.X, 0, lookVector.Z)
        if vector.Magnitude <= 0 then
            return
        end
        local cframe = CFrame.new(humanoidRootPart.Position, humanoidRootPart.Position + vector.Unit)
        TweenService:Create(humanoidRootPart, TweenInfo.new(0.2, Enum.EasingStyle.Linear), {CFrame = cframe}):Play()

        if humanoid then
            humanoid.AutoRotate = false
        end

        local parryV2 = _G.Ox.ParryV2

        if parryV2.LockConnection then
            parryV2.LockConnection:Disconnect()
        end

        local now = tick()

        parryV2.LockConnection = RunService.Heartbeat:Connect(function()
            if tick() - now >= 0.8 then
                if parryV2.LockConnection then
                    parryV2.LockConnection:Disconnect()
                    parryV2.LockConnection = nil
                end

                if humanoid then
                    humanoid.AutoRotate = true
                end

                return
            end

            if humanoidRootPart and humanoidRootPart.Parent then
                humanoidRootPart.CFrame = CFrame.new(humanoidRootPart.Position, humanoidRootPart.Position + vector.Unit)
            elseif parryV2.LockConnection then
                parryV2.LockConnection:Disconnect()
                parryV2.LockConnection = nil
            end
        end)
    end

    V2_MatchParrySkin = function(arg)
        if type(arg) ~= "string" or arg == "" then
            return nil
        end
        local parryV2Anim = _G.Ox.ParryV2Anim
        if not parryV2Anim then
            return nil
        end

        if parryV2Anim[arg] then
            return parryV2Anim[arg]
        end
        local str = string.lower(arg):gsub("^equippedskin[_%-]?", ""):gsub("^skin[_%-]?", ""):gsub("[_%-]?parrying[_%-]?dagger", ""):gsub("[_%-]?dagger", ""):gsub("%s+", "")

        for k, v4 in pairs(parryV2Anim) do
            local v5 = string.lower(k)
            if v5 == str or string.find(str, v5, 1, true) or string.find(v5, str, 1, true) then
                return v4
            end
        end

        return nil
    end

    V2_ScanSkinFromInstance = function(arg)
        if not arg then
            return nil
        end

        for i, v4 in ipairs({
            "EquippedSkin_Parrying_Dagger",
            "EquippedSkin_ParryingDagger",
            "EquippedSkin",
            "ParryingDaggerSkin",
            "ParrySkin",
            "Skin",
            "SkinName",
            "CurrentSkin",
            "EquippedSkinName",
        }) do
            local attribute = arg:GetAttribute(v4)
            local v5 = V2_MatchParrySkin(attribute)
            if v5 then
                return v5
            end
        end

        local ok, result = pcall(function()
            return arg:GetAttributes()
        end)

        if ok and type(result) == "table" then
            for k, v4 in pairs(result) do
                if type(k) == "string" and type(v4) == "string" then
                    local v5 = string.lower(k)
                    if not v5:find("skin") and not v5:find("parry") then
                        continue
                    end
                    local v6 = V2_MatchParrySkin(v4)
                    if v6 then
                        return v6
                    end
                end
            end
        end

        return nil
    end

    V2_ResolveAnimId = function()
        local character = localPlayer.Character

        if character then
            local v4 = V2_ScanSkinFromInstance(character)
            if v4 then
                return v4
            end
            local parryingDagger = character:FindFirstChild("Parrying Dagger")
            local parryingDagger2 = parryingDagger or character:FindFirstChild("ParryingDagger") or character:FindFirstChild("parrying dagger")

            if parryingDagger2 then
                local v5 = V2_ScanSkinFromInstance(parryingDagger2)
                if v5 then
                    return v5
                end

                for i, descendant in ipairs(parryingDagger2:GetDescendants()) do
                    if not descendant:IsA("StringValue") and (not descendant:IsA("ValueBase") or type(descendant.Value) ~= "string") then
                        continue
                    end
                    local v6 = V2_MatchParrySkin(tostring(descendant.Value))
                    if v6 then
                        return v6
                    end
                end
            end

            local backpack = localPlayer:FindFirstChild("Backpack")

            if backpack then
                local parryingDagger3 = backpack:FindFirstChild("Parrying Dagger")
                local parryingDagger4 = parryingDagger3 or backpack:FindFirstChild("ParryingDagger")

                if parryingDagger4 then
                    local v5 = V2_ScanSkinFromInstance(parryingDagger4)
                    if v5 then
                        return v5
                    end
                end
            end
        end

        local v4 = V2_ScanSkinFromInstance(localPlayer)
        if not v4 then
            return _G.Ox.ParryV2Anim.Default
        end
        return v4
    end

    V2_PlayParryAnim = function()
        local character = localPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
        if not animator then
            return
        end
        local parryV2 = _G.Ox.ParryV2

        if parryV2.ParryTrack then
            pcall(function()
                parryV2.ParryTrack:Stop(0.05)
            end)
        end

        pcall(function()
            local animation = Instance.new("Animation")
            animation.AnimationId = V2_ResolveAnimId()
            parryV2.ParryTrack = animator:LoadAnimation(animation)
            parryV2.ParryTrack.Priority = Enum.AnimationPriority.Action4
            parryV2.ParryTrack:Play()
        end)
    end

    V2_DoParry = function()
        if not V2_CanParry() then
            return
        end
        local parryV2 = _G.Ox.ParryV2
        parryV2.IsResolving = true
        V2_SetIconsColor(Color3.fromRGB(77, 77, 77))
        local trigger = parryV2.Trigger
        local str = trigger or "Remote"
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")

        if str == "Button" then
            V2_TriggerByButton()
        else
            local parryingDagger = remotes and remotes:FindFirstChild("Items") and remotes.Items:FindFirstChild("Parrying Dagger")
            local parry = parryingDagger and parryingDagger:FindFirstChild("parry")

            if parry then
                pcall(function()
                    parry:FireServer()
                end)
            end

            V2_FaceLookDirection()
            local character = localPlayer.Character
            local humanoid = character and localPlayer.Character:FindFirstChildOfClass("Humanoid")

            if humanoid then
                humanoid.AutoRotate = false
            end

            V2_PlayParryAnim()
            local character2 = localPlayer.Character
            local humanoidRootPart = character2 and localPlayer.Character:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart then
                pcall(function()
                    CollectionService:AddTag(humanoidRootPart, "doing action")
                end)
            end

            local slow = remotes and remotes:FindFirstChild("Mechanics") and remotes.Mechanics:FindFirstChild("Slow")

            if slow then
                pcall(function()
                    slow:Fire(0, 1, 0)
                end)
            end
        end

        task.delay(2, function()
            if parryV2.IsResolving then
                parryV2.IsResolving = false
                local n = parryV2.Trigger == "Button" and 1.2 or 60
                V2_StartCooldown(n)
                local character = localPlayer.Character
                local humanoidRootPart = character and localPlayer.Character:FindFirstChild("HumanoidRootPart")

                if humanoidRootPart then
                    pcall(function()
                        CollectionService:RemoveTag(humanoidRootPart, "doing action")
                    end)
                end
            end
        end)
    end

    task.spawn(function()
        local remotes = ReplicatedStorage:WaitForChild("Remotes", 8)
        local items = remotes and remotes:WaitForChild("Items", 5)
        local parryingDagger = items and items:WaitForChild("Parrying Dagger", 5)
        local parryResult = parryingDagger and parryingDagger:WaitForChild("parryResult", 5)
        if not parryResult then
            return
        end

        parryResult.OnClientEvent:Connect(function(arg, arg2)
            local parryV2 = _G.Ox.ParryV2
            if not parryV2.IsResolving then
                return
            end
            parryV2.IsResolving = false
            local num = tonumber(arg2)

            if num and num > 0 then
                V2_StartCooldown(num)
            elseif arg == true then
                V2_StartCooldown(90)
            else
                V2_StartCooldown(60)
            end

            local character = localPlayer.Character
            local humanoidRootPart = character and localPlayer.Character:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart then
                pcall(function()
                    CollectionService:RemoveTag(humanoidRootPart, "doing action")
                end)
            end
        end)
    end)

    local cylinderHandleAdornment = Instance.new("CylinderHandleAdornment")
    cylinderHandleAdornment.Name = "OXIO_ParryRange_V2"
    local range = _G.Ox.ParryV2.Range
    local radius = range or 12
    cylinderHandleAdornment.Radius = radius
    local max = math.max
    local range2 = _G.Ox.ParryV2.Range
    local n = range2 or 12
    cylinderHandleAdornment.InnerRadius = max(0.1, n - 0.15)
    cylinderHandleAdornment.Height = 0.01
    cylinderHandleAdornment.Color3 = Color3.fromRGB(80, 80, 80)
    cylinderHandleAdornment.AlwaysOnTop = false
    cylinderHandleAdornment.Transparency = 1
    cylinderHandleAdornment.Adornee = workspace:FindFirstChildOfClass("Terrain")

    pcall(function()
        cylinderHandleAdornment.Parent = CoreGui
    end)

    if not cylinderHandleAdornment.Parent then
        pcall(function()
            cylinderHandleAdornment.Parent = localPlayer:WaitForChild("PlayerGui")
        end)
    end

    _G.Ox.ParryV2.RangeAdornment = cylinderHandleAdornment

    V2_UpdateRangeCircle = function()
        local parryV2 = _G.Ox.ParryV2
        local rangeAdornment = parryV2.RangeAdornment
        if not rangeAdornment then
            return
        end

        if parryV2.Enabled and parryV2.ShowCircle then
            local character = localPlayer.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

            if not humanoidRootPart then
                if rangeAdornment.Transparency ~= 1 then
                    rangeAdornment.Transparency = 1
                end

                return
            end

            local range3 = parryV2.Range
            local v2ParryLastRadius = range3 or 12
            if humanoidRootPart == _G.Ox._V2ParryLastRoot and v2ParryLastRadius == _G.Ox._V2ParryLastRadius then
                return
            end
            _G.Ox._V2ParryLastRoot = humanoidRootPart
            _G.Ox._V2ParryLastRadius = v2ParryLastRadius
            rangeAdornment.Transparency = 0.4
            rangeAdornment.Radius = v2ParryLastRadius
            rangeAdornment.InnerRadius = math.max(0.1, v2ParryLastRadius - 0.15)
            local v2ParryRangeRay = _G.Ox._V2ParryRangeRay
            v2ParryRangeRay.FilterDescendantsInstances = {character}
            local hit = workspace:Raycast(humanoidRootPart.Position, Vector3.new(0, -15, 0), v2ParryRangeRay)
            local position = hit and hit.Position or humanoidRootPart.Position - Vector3.new(0, 3, 0)
            rangeAdornment.CFrame = CFrame.new(position + Vector3.new(0, 0.05, 0)) * CFrame.Angles(math.pi / 2, 0, 0)
            return
        end

        if rangeAdornment.Transparency ~= 1 then
            rangeAdornment.Transparency = 1
        end
    end

    V2_AttachParrySensor = function(arg)
        if not arg or _G.Ox.ParryV2.Attached[arg] then
            return
        end
        _G.Ox.ParryV2.Attached[arg] = true
        local humanoid = arg:FindFirstChild("Humanoid")
        local v4 = humanoid

        if not humanoid then
            local humanoid2 = arg:WaitForChild("Humanoid", 5)
            v4 = humanoid2
            if not humanoid2 then
                return
            end
        end

        local animator = v4:FindFirstChildOfClass("Animator")
        local v5 = animator

        if not animator then
            local animator2 = v4:WaitForChild("Animator", 5)
            v5 = animator2
            if not animator2 then
                return
            end
        end

        v4.ChildAdded:Connect(function(child)
            if child:IsA("Animator") then
                _G.Ox.ParryV2.Attached[arg] = nil
                V2_AttachParrySensor(arg)
            end
        end)

        arg.AncestryChanged:Connect(function(child, parent)
            if not parent then
                _G.Ox.ParryV2.Attached[arg] = nil
            end
        end)

        v5.AnimationPlayed:Connect(function(arg2)
            local animation = arg2.Animation
            local animationId = animation and arg2.Animation.AnimationId or ""
            if not _G.Ox.ParryV2AttackAnims[animationId] then
                return
            end
            local parryV2 = _G.Ox.ParryV2
            if not parryV2.Enabled then
                return
            end

            if not V2_HasParryingDagger() then
                return
            end

            if parryV2.IsOnCooldown or parryV2.IsResolving then
                return
            end
            local character = localPlayer.Character
            if not character then
                return
            end
            local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
            local humanoidRootPart2 = arg:FindFirstChild("HumanoidRootPart")
            if not humanoidRootPart or not humanoidRootPart2 then
                return
            end
            local magnitude = (humanoidRootPart.Position - humanoidRootPart2.Position).Magnitude
            local mode = parryV2.Mode
            local str = mode or "Legit"
            local range3 = parryV2.Range
            local n2 = range3 or 12

            if str == "Aggressive" then
                if n2 + 3 < magnitude then
                    return
                end
                local num = tonumber(parryV2.KillerFace)
                local n3 = num or 0.6
                local n4 = math.clamp(n3, -1, 1)

                local function fn12()
                    local n5 = humanoidRootPart.Position - humanoidRootPart2.Position
                    local vector = Vector3.new(n5.X, 0, n5.Z)
                    if vector.Magnitude < 0.05 then
                        return true
                    end
                    local vector2 = Vector3.new(humanoidRootPart2.CFrame.LookVector.X, 0, humanoidRootPart2.CFrame.LookVector.Z)
                    if vector2.Magnitude < 0.05 then
                        return false
                    end
                    local v6 = vector2.Unit:Dot(vector.Unit)
                    local flag2 = n4 <= v6
                    return flag2
                end

                local function fn13()
                    if parryV2.IsOnCooldown or parryV2.IsResolving or not humanoidRootPart or not humanoidRootPart2 or not humanoidRootPart.Parent or not humanoidRootPart2.Parent then
                        return true
                    end

                    if (humanoidRootPart.Position - humanoidRootPart2.Position).Magnitude > n2 or not fn12() then
                        return false
                    end
                    V2_DoParry()
                    return true
                end

                if fn13() then
                    return
                end
                local connection = nil
                local now = os.clock()

                connection = RunService.Heartbeat:Connect(function()
                    if (os.clock() - now >= 1.5 or fn13()) and connection then
                        connection:Disconnect()
                    end
                end)
            else
                if n2 < magnitude then
                    return
                end

                if not V2_HasLOS(arg) then
                    return
                end
                local n3 = Vector3.new(humanoidRootPart.Position.X, 0, humanoidRootPart.Position.Z) - Vector3.new(humanoidRootPart2.Position.X, 0, humanoidRootPart2.Position.Z)

                if n3.Magnitude > 0 then
                    local unit = n3.Unit
                    local vector = Vector3.new(humanoidRootPart2.CFrame.LookVector.X, 0, humanoidRootPart2.CFrame.LookVector.Z)

                    if vector.Magnitude > 0 then
                        local unit2 = vector.Unit
                        local num = tonumber(parryV2.KillerFace)
                        local n4 = num or 0.6
                        local n5 = math.clamp(n4, -1, 1)
                        if unit2:Dot(unit) < n5 then
                            return
                        end
                    end

                    if str == "Strict" then
                        local currentCamera2 = workspace.CurrentCamera
                        local vector2 = nil

                        if currentCamera2 then
                            vector2 = Vector3.new(currentCamera2.CFrame.LookVector.X, 0, currentCamera2.CFrame.LookVector.Z)
                        end

                        if not vector2 or vector2.Magnitude < 0.05 then
                            vector2 = Vector3.new(humanoidRootPart.CFrame.LookVector.X, 0, humanoidRootPart.CFrame.LookVector.Z)
                        end

                        if vector2.Magnitude > 0 and vector2.Unit:Dot(-unit) < 0.5 then
                            return
                        end
                    end
                end

                V2_DoParry()
            end
        end)
    end

    V2_TryAttach = function(arg)
        if arg ~= localPlayer and arg.Team and arg.Team.Name == "Killer" and arg.Character then
            V2_AttachParrySensor(arg.Character)
        end
    end

    V2_SetupPlayer = function(arg)
        if arg == localPlayer then
            return
        end

        arg.CharacterAdded:Connect(function()
            V2_TryAttach(arg)
        end)

        arg:GetPropertyChangedSignal("Team"):Connect(function()
            V2_TryAttach(arg)
        end)

        if arg.Character then
            V2_TryAttach(arg)
        end
    end

    for k, player in pairs(Players:GetPlayers()) do
        V2_SetupPlayer(player)
    end

    Players.PlayerAdded:Connect(V2_SetupPlayer)

    RunService.Heartbeat:Connect(function()
        if _G.Ox.ParryV2 and _G.Ox.ParryV2.Enabled and _G.Ox.ParryV2.ShowCircle then
            _G.Ox._V2ParryLastRoot = nil
            V2_UpdateRangeCircle()
        elseif _G.Ox.ParryV2 and _G.Ox.ParryV2.RangeAdornment and _G.Ox.ParryV2.RangeAdornment.Transparency ~= 1 then
            _G.Ox.ParryV2.RangeAdornment.Transparency = 1
        end
    end)

    UpdateCustomParryGUI = function(arg)
        if not _G.Ox.AutoParryCustom.Gui then
            return
        end
        local frame = _G.Ox.AutoParryCustom.Gui:FindFirstChild("Frame")
        if not frame then
            return
        end
        local actionButton = frame:FindFirstChild("ActionButton")
        local uiStroke = frame:FindFirstChild("UIStroke")

        if arg then
            if actionButton then
                actionButton.Text = "PARRY [ON]"
                actionButton.TextColor3 = Color3.fromRGB(180, 255, 180)
                actionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            end

            if uiStroke then
                uiStroke.Color = Color3.fromRGB(100, 200, 100)
            end
        else
            if actionButton then
                actionButton.Text = "PARRY [OFF]"
                actionButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                actionButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            end

            if uiStroke then
                uiStroke.Color = Color3.fromRGB(90, 90, 95)
            end
        end
    end

    ToggleParryStatus = function()
        local parryConfig = _G.Ox.ParryConfig
        local autoParry

        if _G.Ox.ParryConfig.AutoParry then
            autoParry = false
        else
            autoParry = true
        end

        parryConfig.AutoParry = autoParry
        _G.Ox.AutoParryCustom.IsActive = _G.Ox.ParryConfig.AutoParry
        UpdateCustomParryGUI(_G.Ox.ParryConfig.AutoParry)
        local notify = lib.Notify
        local tbl6 = {Title = "Auto Parry"}
        local autoParry2 = _G.Ox.ParryConfig.AutoParry
        local description = autoParry2 and "Aktif" or "Nonaktif"
        tbl6.Description = description
        tbl6.Duration = 2
        notify(lib, tbl6)
    end

    CreateCustomParryGUI = function()
        if _G.Ox.AutoParryCustom.Gui then
            _G.Ox.AutoParryCustom.Gui:Destroy()
        end

        local screenGui = Instance.new("ScreenGui")
        screenGui.Name = "AutoParryCustomGui"
        screenGui.ResetOnSpawn = false
        screenGui.IgnoreGuiInset = true
        screenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        screenGui.Parent = CoreGui
        screenGui.Enabled = false
        _G.Ox.AutoParryCustom.Gui = screenGui
        _G.Ox.AutoParryCustom.GuiVisible = false
        local frame = Instance.new("Frame", screenGui)
        frame.Name = "Frame"
        frame.Size = UDim2.fromOffset(110, 36)
        frame.Position = UDim2.fromScale(0.85, 0.35)
        frame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        frame.BackgroundTransparency = 0.1
        frame.Active = true
        frame.BorderSizePixel = 0
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
        local uiStroke = Instance.new("UIStroke", frame)
        uiStroke.Name = "UIStroke"
        uiStroke.Color = Color3.fromRGB(90, 90, 95)
        uiStroke.Thickness = 1.5
        uiStroke.Transparency = 0.2
        local textButton = Instance.new("TextButton", frame)
        textButton.Name = "ActionButton"
        textButton.Size = UDim2.new(1, 0, 1, 0)
        textButton.Text = "PARRY [OFF]"
        textButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        textButton.Font = Enum.Font.GothamBold
        textButton.TextSize = 12
        textButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        textButton.BorderSizePixel = 0
        textButton.AutoButtonColor = false
        Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 8)
        local flag2 = false
        local flag3 = false
        local flag4 = false
        local position = nil
        local position2 = nil
        local thread = nil

        update = function(arg)
            if not flag2 or not flag4 or not position or not position2 then
                return
            end
            local n2 = arg.Position - position

            if not flag3 and (math.abs(n2.X) > 18 or math.abs(n2.Y) > 18) then
                flag3 = true
            end

            if flag3 then
                frame.Position = UDim2.new(position2.X.Scale, position2.X.Offset + n2.X, position2.Y.Scale, position2.Y.Offset + n2.Y)
            end
        end

        textButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                flag2 = true
                flag3 = false
                flag4 = false
                position = input.Position
                position2 = frame.Position

                if thread then
                    task.cancel(thread)
                end

                thread = task.delay(0.18, function()
                    if flag2 then
                        flag4 = true
                    end
                end)
            end
        end)

        textButton.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                if thread then
                    task.cancel(thread)
                end

                if flag2 and not flag3 then
                    ToggleParryStatus()
                end

                flag2 = false
                flag3 = false
                flag4 = false
                position = nil
                position2 = nil
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if flag2 and flag4 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                update(input)
            end
        end)

        if _G.Ox.AutoParryCustom._statusConn then
            _G.Ox.AutoParryCustom._statusConn:Disconnect()
        end

        _G.Ox.AutoParryCustom._statusConn = RunService.Heartbeat:Connect(function()
            if _G.Ox.AutoParryCustom.Gui and _G.Ox.AutoParryCustom.Gui.Parent then
                if _G.Ox.AutoParryCustom.IsActive ~= _G.Ox.ParryConfig.AutoParry then
                    _G.Ox.AutoParryCustom.IsActive = _G.Ox.ParryConfig.AutoParry
                    UpdateCustomParryGUI(_G.Ox.ParryConfig.AutoParry)
                end

                return
            end

            if _G.Ox.AutoParryCustom._statusConn then
                _G.Ox.AutoParryCustom._statusConn:Disconnect()
            end
        end)
    end

    localPlayer.CharacterAdded:Connect(function()
        task.wait(1)

        if _G.Ox.AutoParryCustom.GuiVisible and _G.Ox.AutoParryCustom.Gui then
            _G.Ox.AutoParryCustom.Gui.Enabled = true
            UpdateCustomParryGUI(_G.Ox.ParryConfig.AutoParry)
        end
    end)

    task.spawn(function()
        task.wait(1.5)
        CreateCustomParryGUI()
    end)

    _G.Ox.InstantTPGate = {
        Enabled = false,
        GateClientModule = nil,
        oldGateNew = nil,
        oldGateCanUse = nil,
    }

    _G.Ox.KorlessMorph = {Enabled = false, Connection = nil}
    _G.Ox.SelfHeal = {Enabled = false}
    _G.Ox.FlowstateNoCD = {Enabled = false, Connection = nil, CharAddedConn = nil}
    _G.Ox.NoFall = {Enabled = false}
    _G.Ox.BulletBlockConfig = {Enabled = false}
    _G.Ox.BypassGate = {Enabled = false}
    _G.Ox.NextKiller = {Enabled = false, IndicatorGui = nil}

    _G.Ox.CounterParry = {
        Enabled = false,
        Distance = 15,
        Interval = 0.3,
        AnimId = "rbxassetid://117042998468241",
        Thread = nil,
        Track = nil,
    }

    _G.Ox.AutoStalk = {Enabled = false, Range = 150, Conn = nil, LastFire = 0}

    _G.Ox.Crosshair = {
        Enabled = false,
        Size = 8,
        Thickness = 2,
        Color = Color3.fromRGB(255, 255, 255),
        Style = "Dot",
        OffsetX = 0,
        OffsetY = 0,
    }

    _G.Ox.Spectator = {Enabled = false, Gui = nil, Label = nil}

    _G.Ox.Moonwalk = {
        Enabled = false,
        GuiVisible = false,
        Gui = nil,
        IsActive = false,
    }

    _G.Ox.CrosshairGui = nil
    _G.Ox.CrosshairElements = {}
    _G.Ox.CrosshairCreated = false
    _G.Ox.LastCrosshairStyle = nil
    local ox2 = _G.Ox
    local config = _G.Ox.Config
    local config2 = config or {}
    ox2.Config = config2
    _G.Ox.Config.Surv_PerfectVault = false
    _G.Ox.autoVaultEnabled = false
    _G.Ox.autoPalletSlideEnabled = false
    _G.Ox.lastActionTime = 0
    _G.Ox.COOLDOWN = 1.5
    _G.Ox.StreamerMode = {Enabled = false, SpooferConns = {}}
    _G.Ox.InfinityZoom = {Enabled = false}
    _G.Ox.StretchRes = {Enabled = false, Amount = 0.67, Conn = nil}
    _G.Ox.CameraFOV = {Enabled = false, Value = 90, Connection = nil}
    _G.Ox.Auto = {SkillCheck = false, SkillCheckMode = "Legit"}
    _G.Ox.MapPredict = {Enabled = false}
    _G.Ox.KillerPerks = {Enabled = false, Gui = nil, Minimized = false}

    _G.Ox.Stun = {
        Enabled = false,
        Data = {},
        HitSoundEnabled = false,
        HitSoundVolume = 1,
        HitSoundId = "rbxassetid://106225491596534",
        HitSoundCooldown = 0.3,
        HitSoundLastTime = 0,
    }

    _G.Ox.GodMode = false
    _G.Ox.BypassGenEnabled = false
    _G.Ox.BypassGenMode = "Manual Repair"
    _G.Ox.RepairAnimTrack = nil
    _G.Ox.ProcessedGens = {}
    _G.Ox.AutoRepairEnabled = false
    _G.Ox.AutoRepairThread = nil
    _G.Ox.AutoCurrentPoint = nil
    _G.Ox.AutoCurrentGenModel = nil
    _G.Ox.LastFireTime = 0
    _G.Ox.AutoFireInterval = 0.5
    _G.Ox.ScriptAlive = true
    _G.Ox.BypassToggleValue = false
    _G.Ox.UnlimitedVaultEnabled = false
    local ox3 = _G.Ox
    local state = _G.Ox.State
    local state2 = state or {}
    ox3.State = state2
    _G.Ox.State.busy = false
    _G.Ox.State.RandomMode_IsNormal = false
    _G.Ox.Connections = {SkillHeartbeat = nil}
    _G.Ox.Speed = {Enabled = false, Value = 0.1, Connection = nil, Loop = nil}
    _G.Ox.AutoRun = {PC = false, Mobile = false, MobileThread = nil}

    _G.Ox.Utility = {
        InvisEnabled = false,
        BandageEnabled = false,
        BandageSpeed = 50,
    }

    _G.Ox.AntiHook = {
        Enabled = false,
        OffsetY = -250,
        Hz = 44,
        Interval = 0.022727272727272728,
        Remote = nil,
        Connection = nil,
        Accumulator = 0,
        SendCounter = 0,
        LastCounterTime = os.clock(),
    }

    _G.Ox.ConfigData = {Surv_SkillFrequency = 10, Surv_SkillSpeed = 1}

    _G.Ox.Teleport = {
        GenIndex = 1,
        HookIndex = 1,
        GateIndex = 1,
        PalletIndex = 1,
        WindowIndex = 1,
    }

    tbl = {
        Generators = {},
        Hooks = {},
        Gates = {},
        Pallets = {},
        Windows = {},
    }

    tbl2 = {Enabled = false, Conn = nil}

    if not _G.Ox.State then
        _G.Ox.State = {}
    end

    _G.Ox.State.ThirdPersonConn = nil

    tbl3 = {
        ["Left Arm"] = true,
        ["Right Arm"] = true,
        LeftHand = true,
        RightHand = true,
        LeftLowerArm = true,
        RightLowerArm = true,
        LeftUpperArm = true,
        RightUpperArm = true,
    }

    _G.Ox.FakePerks = {
        QuickRecoveryEnabled = false,
        PerfectLandingEnabled = false,
        FlowstateEnabled = false,
        FakeAdrenalineRush = false,
        PerkCooldown = 10,
        boostActive = false,
        perfectLandingBoostActive = false,
        fsOnCooldown = false,
        lastQRTime = 0,
        lastPLTime = 0,
        lastFSTime = 0,
        qrConnection = nil,
        plConnection = nil,
        fsConnection = nil,
        fsAnimConnection = nil,
        adrenalineOn = false,
        adrenalineConns = {},
        lastARTime = 0,
    }

    _G.Ox.AutoPallet = {
        Enabled = false,
        Safety = true,
        Distance = 10,
        Cooldown = 2.5,
        LastDrop = 0,
        UsedPallets = {},
        Connection = nil,
    }

    _G.Ox.FullBright = false
    _G.Ox.NoFog = false
    _G.Ox.NoShadow = false
    _G.Ox.TimeOfDayValue = 14

    _G.Ox.LowGFX = {
        Enabled = false,
        Textures = true,
        VisualEffects = true,
        Particles = true,
        Parts = true,
        Sky = false,
        Saved = {},
    }

    _G.Ox.AimConfig = {
        Aim_SilentVeilV2 = false,
        Veil_ShowFOV = true,
        SpearSmart_enable = false,
        Veil_FOV = 150,
        SPEAR_Speed = 165,
        SPEAR_Gravity = 103,
        SPEAR_AuraSpeed = 165,
        SPEAR_AuraGravity = 96.5,
        SPEAR_MaxDist = 500,
        Veil_LeadMultiplier = 1.4,
        AIM_TargetPart = "Torso",
        Pistol_BlockKnocked = false,
        LockAim = false,
        Flash_Silent = false,
        Flash_YOffset = 1.5,
    }

    _G.Ox.SurvivorFOVFrame = nil
    _G.Ox.SurvivorFOVGui = nil
    _G.Ox.isAimbotHolding = false
    _G.Ox.lockedAimbotTarget = nil
    _G.Ox.survivorAimbotHighlight = nil
    _G.Ox.isKillerAimbotHolding = false
    _G.Ox.lockedKillerAimbotTarget = nil
    _G.Ox.killerAimbotHighlight = nil

    _G.Ox.Config = {
        SpearSmart_enable = false,
        Surv_Aimbot_Enabled = false,
        Surv_Aimbot_ShowFOV = true,
        Surv_Aimbot_Radius = 150,
        Surv_Aimbot_MaxDist = 300,
        Surv_Aimbot_Smoothness = 0.5,
        Surv_Aimbot_Predict = 0.01,
        Killer_Aimbot_Enabled = false,
        Killer_Aimbot_MaxDist = 12,
        Killer_Aimbot_Smoothness = 0.5,
}

local flag2 = false
    local flag3 = false
    flag = false

    _G.Ox.ESPConfig = {
        Master = false,
        Player = false,
        Killer = false,
        Outline = false,
        Name = false,
        Distance = false,
        KillerWarn = false,
        ItemIcon = false,
        Generator = false,
        GeneratorName = true,
        Pallet = false,
        Hook = false,
        Gate = false,
        Window = false,
        SCP = false,
        HookCount = false,
        Status = false,
        MaxDistance = 1000,
    }

    _G.Ox.ESPColors = {
        Player = Color3.fromRGB(60, 255, 60),
        Killer = Color3.fromRGB(255, 60, 60),
        Generator = Color3.fromRGB(255, 255, 0),
        GeneratorDone = Color3.fromRGB(0, 255, 0),
        Pallet = Color3.fromRGB(60, 255, 255),
        Hook = Color3.fromRGB(255, 105, 180),
        Gate = Color3.fromRGB(255, 255, 255),
        Window = Color3.fromRGB(60, 255, 255),
        SCP = Color3.fromRGB(255, 0, 255),
        Injured = Color3.fromRGB(255, 140, 0),
        Downed = Color3.fromRGB(255, 40, 40),
        Hooked = Color3.fromRGB(240, 240, 255),
    }

    tbl4 = {
        Generators = {},
        Windows = {},
        Pallets = {},
        Hooks = {},
        Gates = {},
        SCPs = {},
    }

    GetRole = function()
        if not localPlayer.Team then
            return "Unknown"
        end
        local name = localPlayer.Team.Name
        if name == "Killer" then
            return "Killer"
        end

        if name == "Survivors" then
            return "Survivor"
        end
        return "Spectator"
    end

    GetDistance = function(arg)
        local character = localPlayer.Character
        local humanoidRootPart = character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then
            return math.huge
        end
        return (arg - humanoidRootPart.Position).Magnitude
    end

    fn = function(arg, arg2)
        if arg and type(arg.SetValue) == "function" then
            pcall(function()
                arg:SetValue(arg2)
            end)
        end
    end

    ClearCrosshair = function()
        if _G.Ox.CrosshairGui then
            _G.Ox.CrosshairGui:Destroy()
            _G.Ox.CrosshairGui = nil
        end

        _G.Ox.CrosshairElements = {}
        _G.Ox.CrosshairCreated = false
        _G.Ox.LastCrosshairStyle = nil
    end

    DrawCrosshair = function()
        if not _G.Ox.Crosshair.Enabled then
            if _G.Ox.CrosshairGui then
                _G.Ox.CrosshairGui.Enabled = false
            end

            return
        end

        if _G.Ox.CrosshairGui then
            _G.Ox.CrosshairGui.Enabled = true
        end

        if _G.Ox.LastCrosshairStyle ~= _G.Ox.Crosshair.Style or not _G.Ox.CrosshairGui then
            ClearCrosshair()
            _G.Ox.LastCrosshairStyle = _G.Ox.Crosshair.Style
        end

        if not _G.Ox.CrosshairCreated then
            _G.Ox.CrosshairCreated = true
            _G.Ox.CrosshairGui = Instance.new("ScreenGui")
            _G.Ox.CrosshairGui.Name = "CrosshairUI"
            _G.Ox.CrosshairGui.IgnoreGuiInset = true
            _G.Ox.CrosshairGui.ResetOnSpawn = false
            _G.Ox.CrosshairGui.DisplayOrder = 999
            _G.Ox.CrosshairGui.Parent = CoreGui

            local function createFrame(size, position)
                local frame = Instance.new("Frame")
                frame.BackgroundColor3 = _G.Ox.Crosshair.Color
                frame.BorderSizePixel = 0
                frame.AnchorPoint = Vector2.new(0.5, 0.5)
                frame.Size = size
                frame.Position = position
                frame.Parent = _G.Ox.CrosshairGui
                return frame
            end

            local udim2 = UDim2.new(0.5, _G.Ox.Crosshair.OffsetX, 0.5, _G.Ox.Crosshair.OffsetY)

            if _G.Ox.Crosshair.Style == "Plus" then
                _G.Ox.CrosshairElements[1] = createFrame(UDim2.new(0, _G.Ox.Crosshair.Size * 2, 0, _G.Ox.Crosshair.Thickness), udim2)
                _G.Ox.CrosshairElements[2] = createFrame(UDim2.new(0, _G.Ox.Crosshair.Thickness, 0, _G.Ox.Crosshair.Size * 2), udim2)
            elseif _G.Ox.Crosshair.Style == "Dot" then
                local frame = Instance.new("Frame")
                frame.BackgroundColor3 = _G.Ox.Crosshair.Color
                frame.BorderSizePixel = 0
                frame.AnchorPoint = Vector2.new(0.5, 0.5)
                frame.Size = UDim2.new(0, _G.Ox.Crosshair.Size, 0, _G.Ox.Crosshair.Size)
                frame.Position = udim2
                Instance.new("UICorner", frame).CornerRadius = UDim.new(1, 0)
                frame.Parent = _G.Ox.CrosshairGui
                _G.Ox.CrosshairElements[1] = frame
            elseif _G.Ox.Crosshair.Style == "Circle" then
                local frame = Instance.new("Frame")
                frame.BackgroundTransparency = 1
                frame.BorderSizePixel = 0
                frame.AnchorPoint = Vector2.new(0.5, 0.5)
                frame.Size = UDim2.new(0, _G.Ox.Crosshair.Size * 2, 0, _G.Ox.Crosshair.Size * 2)
                frame.Position = udim2
                frame.Parent = _G.Ox.CrosshairGui
                local uiStroke = Instance.new("UIStroke")
                uiStroke.Color = _G.Ox.Crosshair.Color
                uiStroke.Thickness = _G.Ox.Crosshair.Thickness
                uiStroke.Parent = frame
                Instance.new("UICorner", frame).CornerRadius = UDim.new(1, 0)
                _G.Ox.CrosshairElements[1] = frame
            end
        end

        local udim2 = UDim2.new(0.5, _G.Ox.Crosshair.OffsetX, 0.5, _G.Ox.Crosshair.OffsetY)

        if _G.Ox.Crosshair.Style == "Plus" then
            if _G.Ox.CrosshairElements[1] then
                _G.Ox.CrosshairElements[1].Size = UDim2.new(0, _G.Ox.Crosshair.Size * 2, 0, _G.Ox.Crosshair.Thickness)
                _G.Ox.CrosshairElements[1].Position = udim2
                _G.Ox.CrosshairElements[1].BackgroundColor3 = _G.Ox.Crosshair.Color
            end

            if _G.Ox.CrosshairElements[2] then
                _G.Ox.CrosshairElements[2].Size = UDim2.new(0, _G.Ox.Crosshair.Thickness, 0, _G.Ox.Crosshair.Size * 2)
                _G.Ox.CrosshairElements[2].Position = udim2
                _G.Ox.CrosshairElements[2].BackgroundColor3 = _G.Ox.Crosshair.Color
            end
        elseif _G.Ox.Crosshair.Style == "Dot" then
            if _G.Ox.CrosshairElements[1] then
                _G.Ox.CrosshairElements[1].Size = UDim2.new(0, _G.Ox.Crosshair.Size, 0, _G.Ox.Crosshair.Size)
                _G.Ox.CrosshairElements[1].Position = udim2
                _G.Ox.CrosshairElements[1].BackgroundColor3 = _G.Ox.Crosshair.Color
            end
        elseif _G.Ox.Crosshair.Style == "Circle" and _G.Ox.CrosshairElements[1] then
            _G.Ox.CrosshairElements[1].Size = UDim2.new(0, _G.Ox.Crosshair.Size * 2, 0, _G.Ox.Crosshair.Size * 2)
            _G.Ox.CrosshairElements[1].Position = udim2
            local uiStroke = _G.Ox.CrosshairElements[1]:FindFirstChildOfClass("UIStroke")

            if uiStroke then
                uiStroke.Color = _G.Ox.Crosshair.Color
                uiStroke.Thickness = _G.Ox.Crosshair.Thickness
            end
        end
    end

    local function fn12()
        for i, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and (not player.Team or player.Team.Name ~= "Survivors") then
                local character = player.Character
                if not character then
                    continue
                end
                local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                if humanoidRootPart then
                    return humanoidRootPart
                end
            end
        end

        return nil
    end

    local function fn13(arg)
        if not _G.Ox.AutoPallet.Safety then
            return true
        end

        if not arg then
            return false
        end

        if arg:GetAttribute("Knocked") == true then
            return false
        end

        if arg:GetAttribute("IsCarried") == true then
            return false
        end

        if arg:GetAttribute("IsHooked") == true then
            return false
        end
        local checkInterractable = arg:FindFirstChild("CheckInterractable")

        if checkInterractable then
            if checkInterractable:GetAttribute("isVaulting") == true then
                return false
            end

            if checkInterractable:GetAttribute("isRepairing") == true then
                return false
            end

            if checkInterractable:GetAttribute("isUnhooking") == true then
                return false
            end

            if checkInterractable:GetAttribute("isHealing") == true then
                return false
            end

            if checkInterractable:GetAttribute("isSliding") == true then
                return false
            end

            if checkInterractable:GetAttribute("isCarrying") == true then
                return false
            end
        end

        local humanoid = arg:FindFirstChildOfClass("Humanoid")
        if humanoid and humanoid.Health <= 0 then
            return false
        end
        return true
    end

    local function fn14(arg)
        local v4 = nil
        local distance = _G.Ox.AutoPallet.Distance
        local v5 = ipairs
        local pallets = tbl4.Pallets
        local tbl6 = pallets or {}

        for k, v6 in v5(tbl6) do
            if v6 and v6.Parent and not _G.Ox.AutoPallet.UsedPallets[v6] then
                local primaryPartPallet = v6:FindFirstChild("PrimaryPartPallet")
                local palletPoint = primaryPartPallet or v6:FindFirstChild("PalletPoint") or v6:FindFirstChild("PalletPointSlide") or v6:FindFirstChildWhichIsA("BasePart")

                if palletPoint then
                    local ok, result = pcall(function()
                        return palletPoint.Position
                    end)

                    if ok and result then
                        local magnitude = (arg.Position - result).Magnitude

                        if magnitude < distance then
                            distance = magnitude
                            v4 = v6
                        end
                    end
                end
            end
        end

        return v4
    end

    local function fn15(arg)
        if not arg then
            return false
        end
        local palletPointSlide = arg:FindFirstChild("PalletPointSlide")
        local palletPoint = palletPointSlide or arg:FindFirstChild("PalletPoint") or arg:FindFirstChildWhichIsA("BasePart")
        if not palletPoint then
            return false
        end
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        local palletDropEvent = remotes and remotes:FindFirstChild("Pallet") and remotes.Pallet:FindFirstChild("PalletDropEvent")
        if not palletDropEvent then
            return false
        end

        pcall(function()
            palletDropEvent:FireServer(palletPoint)
        end)

        _G.Ox.AutoPallet.UsedPallets[arg] = true
        _G.Ox.AutoPallet.LastDrop = tick()
        return true
    end

    StartAutoPallet = function()
        if _G.Ox.AutoPallet.Connection then
            return
        end

        _G.Ox.AutoPallet.Connection = task.spawn(function()
            while _G.Ox.AutoPallet.Enabled do
                task.wait(0.3)

                if GetRole() == "Survivor" and tick() - _G.Ox.AutoPallet.LastDrop >= _G.Ox.AutoPallet.Cooldown then
                    pcall(function()
                        local character = localPlayer.Character
                        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
                        if not humanoidRootPart or not humanoid or humanoid.Health <= 0 then
                            return
                        end

                        if not fn13(character) then
                            return
                        end
                        local v4 = fn12()
                        if not v4 then
                            return
                        end

                        if _G.Ox.AutoPallet.Distance < (humanoidRootPart.Position - v4.Position).Magnitude then
                            return
                        end
                        local v5 = fn14(humanoidRootPart)

                        if v5 then
                            fn15(v5)
                        end
                    end)
                end
            end
        end)
    end

    StopAutoPallet = function()
        if _G.Ox.AutoPallet.Connection then
            task.cancel(_G.Ox.AutoPallet.Connection)
            _G.Ox.AutoPallet.Connection = nil
        end

        _G.Ox.AutoPallet.UsedPallets = {}
    end

    ToggleAutoPallet = function(enabled)
        _G.Ox.AutoPallet.Enabled = enabled

        if enabled then
            if GetRole() ~= "Survivor" then
                lib:Notify({
                    Title = "Auto Drop Pallet",
                    Description = "Kamu harus Survivor!",
                    Duration = 3,
                })

                _G.Ox.AutoPallet.Enabled = false

                if AutoPalletToggle then
                    fn(AutoPalletToggle, false)
                end

                return
            end

            _G.Ox.AutoPallet.UsedPallets = {}
            StartAutoPallet()

            lib:Notify({
                Title = "Auto Drop Pallet",
                Description = "AKTIF",
                Duration = 2,
            })
        else
            StopAutoPallet()

            lib:Notify({
                Title = "Auto Drop Pallet",
                Description = "NONAKTIF",
                Duration = 2,
            })
        end
    end

    localPlayer.CharacterAdded:Connect(function()
        _G.Ox.AutoPallet.UsedPallets = {}
        _G.Ox.AutoPallet.LastDrop = 0
    end)

    DropAllPallets = function()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        local palletDropEvent = remotes and remotes:FindFirstChild("Pallet") and remotes.Pallet:FindFirstChild("PalletDropEvent")

        if not palletDropEvent then
            lib:Notify({
                Title = "Drop All Pallet",
                Description = "Remote tidak ditemukan!",
                Duration = 2,
            })

            return
        end

        local tbl6 = {}
        local map = workspace:FindFirstChild("Map")

        if not map then
            lib:Notify({
                Title = "Drop All Pallet",
                Description = "Map tidak ditemukan!",
                Duration = 2,
            })

            return
        end

        for i, descendant in ipairs(map:GetDescendants()) do
            if descendant.Name == "PalletPoint" and descendant:IsA("BasePart") then
                local model = descendant:FindFirstAncestorWhichIsA("Model")

                if model then
                    if not tbl6[model] then
                        tbl6[model] = {}
                    end

                    table.insert(tbl6[model], descendant)
                end
            end
        end

        local n2 = 0
        local v4, v5, v6 = pairs(tbl6)
        local v7 = v6
        local v8 = v4
        local v9 = v5

        while true do
            local v10, v11 = v8(v9, v7)
            if v10 == nil then
                break
            end

            for i, v12 in ipairs(v11) do
                pcall(function()
                    palletDropEvent:FireServer(v12)
                    n2 = n2 + 1
                end)
            end

            v7 = v10
        end

        lib:Notify({
            Title = "Drop All Pallet",
            Description = string.format("Berhasil menjatuhkan %d pallet!", n2),
            Duration = 3,
        })
    end

    local n2 = 0

    fn2 = function(arg)
        if not arg and tick() - n2 < 2 then
            return
        end
        n2 = tick()
        table.clear(tbl.Generators)
        table.clear(tbl.Windows)
        table.clear(tbl.Pallets)
        table.clear(tbl.Hooks)
        table.clear(tbl.Gates)
        table.clear(tbl4.Generators)
        table.clear(tbl4.Windows)
        table.clear(tbl4.Pallets)
        table.clear(tbl4.Hooks)
        table.clear(tbl4.Gates)
        table.clear(tbl4.SCPs)
        local map = workspace:FindFirstChild("Map")
        local v4 = map or workspace
        local descendants = v4:GetDescendants()

        for i, descendant in ipairs(descendants) do
            if i % 200 == 0 then
                task.wait()
            end

            if descendant:IsA("Model") then
                local v5 = string.lower(descendant.Name)

                if v5 == "generator" then
                    local generatorBody = descendant:FindFirstChild("GeneratorBody")
                    local basePart = generatorBody or descendant:FindFirstChildWhichIsA("BasePart")

                    if basePart then
                        local tbl6 = {model = descendant, part = basePart}
                        table.insert(tbl.Generators, tbl6)
                        table.insert(tbl4.Generators, tbl6)
                    end
                elseif v5 == "hook" and descendant:FindFirstChild("HookPoint") then
                    table.insert(tbl.Hooks, descendant)
                    table.insert(tbl4.Hooks, descendant)
                elseif v5 == "gate" and descendant:FindFirstChild("ExitLever") then
                    table.insert(tbl.Gates, descendant)
                    table.insert(tbl4.Gates, descendant)
                elseif v5 == "window" then
                    table.insert(tbl.Windows, descendant)
                    table.insert(tbl4.Windows, descendant)
                end
            elseif descendant:IsA("BasePart") and descendant.Name == "PrimaryPartPallet" then
                local parent = descendant.Parent

                if parent and not table.find(tbl.Pallets, parent) then
                    table.insert(tbl.Pallets, parent)
                    table.insert(tbl4.Pallets, parent)
                end
            end
    end

    local descendants2 = workspace:GetDescendants()

        for i, v5 in ipairs(descendants2) do
            if i % 200 == 0 then
                task.wait()
            end

            if v5:IsA("Model") and string.match(string.lower(v5.Name), "^scp") and not table.find(tbl4.SCPs, v5) then
                table.insert(tbl4.SCPs, v5)
            end
        end
    end

    fn3 = function(arg)
        if not arg then
            return
        end
        local character = localPlayer.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart then
            local vector = Vector3.new(0, 3, 0)

            if arg:IsA("BasePart") then
                humanoidRootPart.CFrame = arg.CFrame + vector
            elseif arg:IsA("Model") then
                local basePart = arg:FindFirstChildWhichIsA("BasePart")

                if basePart then
                    humanoidRootPart.CFrame = basePart.CFrame + vector
                end
            end

            lib:Notify({
                Title = "Teleport",
                Description = "Berhasil!",
                Duration = 1,
            })
        end
    end

    ApplyFullBright = function()
        local Lighting = game:GetService("Lighting")
        if not Lighting then
            return
        end

        if _G.Ox.FullBright then
            Lighting.Brightness = 2.8
            Lighting.ClockTime = _G.Ox.TimeOfDayValue
            Lighting.FogEnd = 100000
            Lighting.Ambient = Color3.fromRGB(200, 200, 200)
            Lighting.OutdoorAmbient = Color3.fromRGB(200, 200, 200)
        end
    end

    ApplyNoFog = function()
        local Lighting = game:GetService("Lighting")
        if not Lighting then
            return
        end

        if _G.Ox.NoFog then
            Lighting.FogStart = 0
            Lighting.FogEnd = 100000
            Lighting.FogColor = Color3.fromRGB(255, 255, 255)
            local atmosphere = Lighting:FindFirstChildOfClass("Atmosphere")

            if atmosphere then
                atmosphere.Density = 0
                atmosphere.Offset = 0
                atmosphere.Glare = 0
                atmosphere.Haze = 0
            end
        end
    end

    ApplyNoShadow = function()
        local Lighting = game:GetService("Lighting")
        if not Lighting then
            return
        end
        local globalShadows

        if _G.Ox.NoShadow then
            globalShadows = false
        else
            globalShadows = true
        end

        Lighting.GlobalShadows = globalShadows
    end

    ReapplyPerformance = function()
        ApplyFullBright()
        ApplyNoFog()
        ApplyNoShadow()
    end

    ReapplyPerformanceDelayed = function()
        task.spawn(function()
            ReapplyPerformance()
            task.wait(1.2)
            ReapplyPerformance()
            task.wait(2)
            ReapplyPerformance()
            task.wait(3)
            ReapplyPerformance()
        end)
    end

    StartLightingGuard = function()
        if _G.Ox.LightingGuardConn then
            return
        end
        local n3 = 0

        _G.Ox.LightingGuardConn = RunService.Heartbeat:Connect(function()
            if not _G.Ox.FullBright and not _G.Ox.NoFog and not _G.Ox.NoShadow then
                return
            end
            local now = tick()
            if now - n3 < 0.4 then
                return
            end
            n3 = now
            ReapplyPerformance()
        end)
    end

    StopLightingGuard = function()
        if _G.Ox.FullBright or _G.Ox.NoFog or _G.Ox.NoShadow then
            return
        end

        if _G.Ox.LightingGuardConn then
            _G.Ox.LightingGuardConn:Disconnect()
            _G.Ox.LightingGuardConn = nil
        end
    end

    if not _G.Ox.LightingChildConn then
        _G.Ox.LightingChildConn = game:GetService("Lighting").ChildAdded:Connect(function(child)
            if not _G.Ox.FullBright and not _G.Ox.NoFog then
                return
            end

            task.defer(function()
                if child:IsA("Atmosphere") and _G.Ox.NoFog then
                    child.Density = 0
                    child.Offset = 0
                    child.Glare = 0
                    child.Haze = 0
                end

                ReapplyPerformance()
            end)
        end)
    end

    local function fn16(arg, arg2, arg3)
        table.insert(_G.Ox.LowGFX.Saved, {obj = arg, kind = arg2, extra = arg3})
    end

    LowGFX_ProcessOne = function(arg)
        if not _G.Ox.LowGFX.Enabled or not arg then
            return
        end
        local lowGFX = _G.Ox.LowGFX

        if lowGFX.Parts and (arg:IsA("BasePart") or arg:IsA("UnionOperation") or arg:IsA("MeshPart")) and arg.Material ~= Enum.Material.SmoothPlastic then
            fn16(arg, "Part", arg.Material)
            arg.Material = Enum.Material.SmoothPlastic
        end

        if lowGFX.Particles and (arg:IsA("ParticleEmitter") or arg:IsA("Smoke") or arg:IsA("Explosion") or arg:IsA("Sparkles") or arg:IsA("Fire")) and arg.Enabled ~= false then
            fn16(arg, "Particle", true)
            arg.Enabled = false
        end

        if lowGFX.VisualEffects and (arg:IsA("BloomEffect") or arg:IsA("BlurEffect") or arg:IsA("DepthOfFieldEffect") or arg:IsA("SunRaysEffect") or arg:IsA("ColorCorrectionEffect")) and arg.Enabled ~= false then
            fn16(arg, "VFX", true)
            arg.Enabled = false
        end

        if lowGFX.Textures and (arg:IsA("Decal") or arg:IsA("Texture")) and arg.Texture ~= "" then
            fn16(arg, "Texture", arg.Texture)
            arg.Texture = ""
        end

        if lowGFX.Sky and arg:IsA("Sky") then
            fn16(arg, "Sky", arg.Parent)
            arg.Parent = nil
        end
    end

    ApplyLowGFX = function()
        if not _G.Ox.LowGFX.Enabled then
            return
        end
        local tbl6 = {workspace, game:GetService("Lighting")}
        local v4, v5, v6 = ipairs(tbl6)
        local v7 = v6
        local v8 = v4
        local v9 = v5

        while true do
            local v10, v11 = v8(v9, v7)
            if v10 == nil then
                break
            end
            local descendants = v11:GetDescendants()

            for i, descendant in ipairs(descendants) do
                if i % 250 == 0 then
                    task.wait()
                end

                LowGFX_ProcessOne(descendant)
            end

            v7 = v10
        end
    end

    RestoreLowGFX = function()
        for i, v4 in ipairs(_G.Ox.LowGFX.Saved) do
            local obj = v4.obj

            if obj and obj.Parent then
                pcall(function()
                    if v4.kind == "Part" then
                        obj.Material = v4.extra
                    elseif v4.kind ~= "Particle" and v4.kind ~= "VFX" then
                        if v4.kind == "Texture" then
                            obj.Texture = v4.extra
                        elseif v4.kind == "Sky" and v4.extra then
                            obj.Parent = v4.extra
                        end
                    else
                        obj.Enabled = v4.extra
                    end
                end)
            end
        end

        table.clear(_G.Ox.LowGFX.Saved)
    end

    ToggleLowGFX = function(enabled)
        _G.Ox.LowGFX.Enabled = enabled

        if enabled then
            task.spawn(ApplyLowGFX)

            lib:Notify({
                Title = "Remove Texture",
                Description = "AKTIF - Low GFX",
                Duration = 2,
            })
        else
            RestoreLowGFX()

            lib:Notify({
                Title = "Remove Texture",
                Description = "NONAKTIF - texture dikembalikan",
                Duration = 2,
            })
        end
    end

    if not _G.Ox.LowGFX.StreamConn then
        _G.Ox.LowGFX.StreamConn = workspace.DescendantAdded:Connect(function(descendant)
            if not _G.Ox.LowGFX.Enabled then
                return
            end

            task.defer(function()
                LowGFX_ProcessOne(descendant)
            end)
        end)
    end

    CreateSpectatorUI = function()
        if _G.Ox.Spectator.Gui then
            _G.Ox.Spectator.Gui:Destroy()
            _G.Ox.Spectator.Gui = nil
        end

        _G.Ox.Spectator.Gui = Instance.new("ScreenGui")
        _G.Ox.Spectator.Gui.Name = "SpectatorCounter"
        _G.Ox.Spectator.Gui.ResetOnSpawn = false
        _G.Ox.Spectator.Gui.Parent = localPlayer:WaitForChild("PlayerGui")
        local frame = Instance.new("Frame")
        frame.Name = "MainBox"
        frame.AnchorPoint = Vector2.new(0.5, 1)
        frame.Position = UDim2.new(0.5, 0, 0, -10)
        frame.Size = UDim2.new(0, 68, 0, 22)
        frame.BackgroundColor3 = Color3.fromRGB(16, 16, 18)
        frame.BackgroundTransparency = 0.25
        frame.BorderSizePixel = 0
        frame.Parent = _G.Ox.Spectator.Gui
        Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)
        local uiGradient = Instance.new("UIGradient")

        uiGradient.Transparency = NumberSequence.new({
            NumberSequenceKeypoint.new(0, 1),
            NumberSequenceKeypoint.new(0.3, 0.4),
            NumberSequenceKeypoint.new(1, 1),
        })

        uiGradient.Parent = frame
        local uiListLayout = Instance.new("UIListLayout", frame)
        uiListLayout.FillDirection = Enum.FillDirection.Horizontal
        uiListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
        uiListLayout.VerticalAlignment = Enum.VerticalAlignment.Center
        uiListLayout.Padding = UDim.new(0, 6)
        local imageLabel = Instance.new("ImageLabel", frame)
        imageLabel.Size = UDim2.new(0, 15, 0, 15)
        imageLabel.BackgroundTransparency = 1
        imageLabel.Image = "rbxassetid://13321848320"
        imageLabel.ImageColor3 = Color3.fromRGB(225, 225, 225)
        _G.Ox.Spectator.Label = Instance.new("TextLabel", frame)
        _G.Ox.Spectator.Label.BackgroundTransparency = 1
        _G.Ox.Spectator.Label.Font = Enum.Font.GothamMedium
        _G.Ox.Spectator.Label.Text = "0"
        _G.Ox.Spectator.Label.TextColor3 = Color3.fromRGB(240, 240, 240)
        _G.Ox.Spectator.Label.TextSize = 13
        _G.Ox.Spectator.Label.AutomaticSize = Enum.AutomaticSize.X
    end

    UpdateSpectatorCount = function()
        if not _G.Ox.Spectator.Enabled or not _G.Ox.Spectator.Label then
            return
        end
        local n3 = 0

        for i, player in ipairs(Players:GetPlayers()) do
            if player.Team and player.Team.Name == "Spectator" then
                n3 = n3 + 1
            end
        end

        _G.Ox.Spectator.Label.Text = tostring(n3)
        local gui = _G.Ox.Spectator.Gui
        local mainBox = gui and _G.Ox.Spectator.Gui:FindFirstChild("MainBox")

        if mainBox then
            local udim2 = UDim2.new
            local n4 = n3 >= 10 and 8 or 0
            local n5 = 55 + n4
            local n6 = n3 >= 100 and 8 or 0
            mainBox.Size = udim2(0, n5 + n6, 0, 22)
        end
    end

    StartSpectatorInfo = function()
        if _G.Ox.Spectator.Enabled then
            return
        end
        _G.Ox.Spectator.Enabled = true
        CreateSpectatorUI()
        UpdateSpectatorCount()

        task.spawn(function()
            while _G.Ox.Spectator.Enabled do
                UpdateSpectatorCount()
                task.wait(1.2)
            end
        end)

        lib:Notify({
            Title = "Spectator Info",
            Description = "✅ Display aktif di pojok atas",
            Duration = 3,
        })
    end

    StopSpectatorInfo = function()
        _G.Ox.Spectator.Enabled = false

        if _G.Ox.Spectator.Gui then
            _G.Ox.Spectator.Gui:Destroy()
            _G.Ox.Spectator.Gui = nil
            _G.Ox.Spectator.Label = nil
        end

        lib:Notify({
            Title = "Spectator Info",
            Description = "Display dimatikan",
            Duration = 2,
        })
    end

    fn4 = function(arg)
        if arg then
            StartSpectatorInfo()
        else
            StopSpectatorInfo()
        end
    end

    ScanMapESP = function(arg)
        fn2(arg)
    end

    ForceRefreshMap = function()
        fn2(true)

        if _G.Ox.ESPConfig.Master then
            ClearAllESP()
            task.wait(0.1)
            UpdatePlayerESP()
            UpdateSCPESP()
            UpdateStaticESP()
        end
end
task.spawn(function()
        task.wait(2)
        ScanMapESP()
    end)

    localPlayer.CharacterAdded:Connect(function()
        task.wait(1.5)
        ScanMapESP()

        if _G.Ox.ESPConfig.Master then
            task.spawn(function()
                task.wait(0.5)
                ClearAllESP()
                task.wait(0.2)
                UpdatePlayerESP()
                UpdateSCPESP()
                UpdateStaticESP()
            end)
        end
    end)

    workspace.ChildAdded:Connect(function(child)
        if child.Name == "Map" then
            task.wait(1)
            ScanMapESP(true)

            if _G.Ox.ESPConfig.Master then
                pcall(UpdatePlayerESP)
                pcall(UpdateSCPESP)
                pcall(UpdateStaticESP)
            end

            ReapplyPerformanceDelayed()

            if _G.Ox.LowGFX.Enabled then
                table.clear(_G.Ox.LowGFX.Saved)
                task.wait(1.5)
                ApplyLowGFX()
                task.wait(2.5)

                if _G.Ox.LowGFX.Enabled then
                    ApplyLowGFX()
                end
            end
        end
    end)

    task.spawn(function()
        while _G.Ox.ScriptAlive do
            task.wait(40)

            if _G.Ox.ESPConfig.Master then
                ScanMapESP()

                if _G.Ox.ESPConfig.Master then
                    pcall(UpdateStaticESP)
                    pcall(UpdatePlayerESP)
                    pcall(UpdateSCPESP)
                end
            end
        end
    end)

    local function fn17()
        local playerGui2 = localPlayer:FindFirstChild("PlayerGui")
        if not playerGui2 then
            return nil
        end
        local survivorMob = playerGui2:FindFirstChild("Survivor-mob")
        if not survivorMob then
            return nil
        end
        local controls = survivorMob:FindFirstChild("Controls")
        if not controls then
            return nil
        end
        local sprint = controls:FindFirstChild("sprint")
        if not sprint then
            return nil
        end

        if sprint:IsA("GuiButton") then
            return sprint
        end
        local icon = sprint:FindFirstChild("icon")
        if icon and icon:IsA("GuiButton") then
            return icon
        end

        if icon and icon.Parent and icon.Parent:IsA("GuiButton") then
            return icon.Parent
        end

        if sprint.Parent and sprint.Parent:IsA("GuiButton") then
            return sprint.Parent
        end
        return sprint
    end

    local function fn18()
        local v4 = fn17()
        if not v4 then
            return false
        end

        pcall(function()
            if type(firesignal) == "function" then
                firesignal(v4.MouseButton1Click)
                firesignal(v4.MouseButton1Down)
                task.wait(0.04)
                firesignal(v4.MouseButton1Up)
            else
                local absolutePosition = v4.AbsolutePosition
                local absoluteSize = v4.AbsoluteSize
                local guiInset = GuiService:GetGuiInset()
                local n3 = absolutePosition.X + absoluteSize.X / 2 + guiInset.X
                local n4 = absolutePosition.Y + absoluteSize.Y / 2 + guiInset.Y
                VirtualInputManager:SendTouchEvent(9901, 0, n3, n4)
                task.wait(0.04)
                VirtualInputManager:SendTouchEvent(9901, 2, n3, n4)
            end
        end)

        return true
    end

    local function fn19()
        local character = localPlayer.Character
        if not character then
            return false
        end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if not humanoid then
            return false
        end

        if humanoid.MoveDirection.Magnitude > 0.12 then
            return true
        end
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart then
            local assemblyLinearVelocity = humanoidRootPart.AssemblyLinearVelocity
            if Vector3.new(assemblyLinearVelocity.X, 0, assemblyLinearVelocity.Z).Magnitude > 1.5 then
                return true
            end
        end

        return false
    end

    local function fn20()
        local character = localPlayer.Character
        if not character then
            return false
        end
        local flag4 = character:GetAttribute("Crouching") == true or character:GetAttribute("Crouchingserver") == true
        return flag4
    end

    local function fn21()
        local character = localPlayer.Character
        if not character then
            return false
        end
        local flag4 = character:GetAttribute("Sprinting") == true or character:GetAttribute("IsRunning") == true
        return flag4
    end

    fn5 = function()
        if _G.Ox.AutoRun.MobileThread then
            return
        end

        _G.Ox.AutoRun.MobileThread = task.spawn(function()
            while _G.Ox.AutoRun.Mobile do
                local v4 = fn19()
                local v5 = fn20()
                local v6 = fn21()

                if v5 then
                    if v6 then
                        fn18()
                    end
                elseif v4 and not v6 then
                    fn18()
                elseif not v4 and v6 then
                    fn18()
                end

                task.wait(0.12)
            end

            _G.Ox.AutoRun.MobileThread = nil
        end)
    end

    fn6 = function()
        _G.Ox.AutoRun.Mobile = false

        if _G.Ox.AutoRun.MobileThread then
            task.cancel(_G.Ox.AutoRun.MobileThread)
            _G.Ox.AutoRun.MobileThread = nil
        end

        if fn21() then
            fn18()
        end
    end

    task.spawn(function()
        while _G.Ox.ScriptAlive do
            task.wait(0.1)
            if not _G.Ox.ScriptAlive then
                break
            end

            if not UserInputService.TouchEnabled and tick() - _G.Ox.lastActionTime >= _G.Ox.COOLDOWN then
                local autoVaultEnabled = _G.Ox.autoVaultEnabled
                local autoPalletSlideEnabled = _G.Ox.autoPalletSlideEnabled

                if autoVaultEnabled or autoPalletSlideEnabled then
                    local pcprompts = playerGui:FindFirstChild("pcprompts")
                    local frame = pcprompts and pcprompts:FindFirstChild("Frame")

                    if frame then
                        local vaultPromptGui = frame:FindFirstChild("VaultPromptGui")
                        local palletSlidePromptGui = frame:FindFirstChild("PalletSlidePromptGui")
                        local visible = vaultPromptGui and vaultPromptGui.Visible
                        local visible2 = palletSlidePromptGui and palletSlidePromptGui.Visible

                        if autoVaultEnabled and visible or autoPalletSlideEnabled and visible2 then
                            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
                            task.wait(0.01)
                            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
                            _G.Ox.lastActionTime = tick()
                        end
                    end
                end
            end
        end
    end)

    local function fn22()
        if not UserInputService.TouchEnabled then
            return
        end
        local survivorMob = playerGui:FindFirstChild("Survivor-mob")
        local survivorMob2 = survivorMob or playerGui:WaitForChild("Survivor-mob", 8)
        if not survivorMob2 then
            return
        end
        local controls = survivorMob2:FindFirstChild("Controls")
        local controls2 = controls or survivorMob2:WaitForChild("Controls", 5)
        local action = controls2

        if controls2 then
            local action2 = controls2:FindFirstChild("action")
            action = action2 or controls2:WaitForChild("action", 5)
        end

        if not action then
            return
        end

        local tbl6 = {
            vault = true,
            palletvault = true,
            palletslide = true,
            slide = true,
        }

        local function fn23(arg)
            if not arg:IsA("ImageLabel") and not arg:IsA("ImageButton") then
                return
            end
            local str = arg.Name:lower()
            if not tbl6[str] then
                return
            end

            arg:GetPropertyChangedSignal("Visible"):Connect(function()
                if not arg.Visible then
                    return
                end

                if tick() - _G.Ox.lastActionTime < _G.Ox.COOLDOWN then
                    return
                end
                local pos = str:find("vault")
                local flag4 = pos

                if pos then
                    if str:find("pallet") then
                        flag4 = false
                    else
                        flag4 = true
                    end
                end

                local pos2 = str:find("pallet")
                local pos3 = pos2 or str:find("slide")

                if flag4 and _G.Ox.autoVaultEnabled or pos3 and _G.Ox.autoPalletSlideEnabled then
                    pcall(function()
                        firesignal(action.MouseButton1Down)
                        task.wait(0.01)
                        firesignal(action.MouseButton1Up)
                    end)

                    _G.Ox.lastActionTime = tick()
                end
            end)
        end

        for k, child in pairs(action:GetChildren()) do
            fn23(child)
        end

        action.ChildAdded:Connect(function(child)
            task.wait()
            fn23(child)
        end)
    end

    task.spawn(fn22)

    localPlayer.CharacterAdded:Connect(function()
        task.wait(2)
        fn22()
    end)

    playerGui.ChildAdded:Connect(function(child)
        if child.Name == "Survivor-mob" then
            task.wait(1)
            fn22()
        end
    end);

    (function()
        task.spawn(function()
            local remotes = ReplicatedStorage:WaitForChild("Remotes", 10)
            local killerPerks = remotes and remotes:WaitForChild("KillerPerks", 5)
            local kingscourge = killerPerks and killerPerks:WaitForChild("kingscourge", 5)
            local kingScourgeStart = kingscourge and kingscourge:WaitForChild("KingScourgeStart", 5)

            if kingScourgeStart then
                kingScourgeStart.OnClientEvent:Connect(function()
                    if _G.Ox.Auto.SkillCheckMode == "Random" then
                        _G.Ox.State.RandomMode_IsNormal = true
                    end
                end)
            end
        end)
    end)()

    local function fn23()
        if not playerGui then
            return nil
        end
        local survivorMob = playerGui:FindFirstChild("Survivor-mob")
        if not survivorMob then
            return nil
        end
        local controls = survivorMob:FindFirstChild("Controls")
        if not controls then
            return nil
        end
        local action = controls:FindFirstChild("action")
        local check = action or controls:FindFirstChild("check")
        return check
    end

    local function fn24()
        local v4 = fn23()

        if v4 and v4:IsA("GuiObject") and v4.Visible and type(firesignal) == "function" then
            pcall(function()
                firesignal(v4.MouseButton1Down)
                task.wait(0.005)
                firesignal(v4.MouseButton1Up)
            end)

            return true
        end

        if v4 and v4:IsA("GuiObject") and v4.Visible then
            pcall(function()
                local absolutePosition = v4.AbsolutePosition
                local absoluteSize = v4.AbsoluteSize
                local guiInset = GuiService:GetGuiInset()
                local n3 = 8822 + math.random(1, 9999)
                VirtualInputManager:SendTouchEvent(n3, 0, absolutePosition.X + absoluteSize.X / 2 + guiInset.X, absolutePosition.Y + absoluteSize.Y / 2 + guiInset.Y)
                task.wait(0.005)
                VirtualInputManager:SendTouchEvent(n3, 2, absolutePosition.X + absoluteSize.X / 2 + guiInset.X, absolutePosition.Y + absoluteSize.Y / 2 + guiInset.Y)
            end)

            return true
        end

        pcall(function()
            VirtualInputManager:SendKeyEvent(true, Enum.KeyCode.Space, false, game)
            task.wait(0.005)
            VirtualInputManager:SendKeyEvent(false, Enum.KeyCode.Space, false, game)
        end)

        return true
    end

    fn7 = function()
        if _G.Ox.Connections.SkillHeartbeat then
            _G.Ox.Connections.SkillHeartbeat:Disconnect()
            _G.Ox.Connections.SkillHeartbeat = nil
        end

        _G.Ox.Connections.SkillHeartbeat = RunService.Heartbeat:Connect(function()
            if not _G.Ox.Auto.SkillCheck or _G.Ox.State.busy then
                return
            end
            local skillCheckPromptGui = playerGui:FindFirstChild("SkillCheckPromptGui")
            if not skillCheckPromptGui then
                return
            end
            local check = skillCheckPromptGui:FindFirstChild("Check")

            if check and check.Visible then
                local line = check:FindFirstChild("Line")
                local goal = check:FindFirstChild("Goal")
                if not line or not goal then
                    return
                end
                local flag4 = _G.Ox.Auto.SkillCheckMode == "Instant"

                if not flag4 then
                    flag4 = _G.Ox.Auto.SkillCheckMode == "Random"

                    if flag4 then
                        if _G.Ox.State.RandomMode_IsNormal then
                            flag4 = false
                        else
                            flag4 = true
                        end
                    end
                end

                if flag4 then
                    line.Rotation = goal.Rotation + 109
                    _G.Ox.State.busy = true

                    task.spawn(function()
                        fn24()
                        task.wait(0.05)
                        _G.Ox.State.busy = false
                    end)
                else
                    local randomModeIsNormal = _G.Ox.Auto.SkillCheckMode == "Normal" or _G.Ox.Auto.SkillCheckMode == "Random" and _G.Ox.State.RandomMode_IsNormal
                    local n3 = line.Rotation % 360
                    local n4 = goal.Rotation % 360
                    local n5, n6

                    if randomModeIsNormal then
                        n5 = (n4 + 116) % 360
                        n6 = (n4 + 140) % 360
                    else
                        n5 = (n4 + 102) % 360
                        n6 = (n4 + 116) % 360
                    end

                    local v4

                    if n6 < n5 then
                        local flag5 = n5 <= n3 or n3 <= n6
                        v4 = flag5
                    else
                        local flag5 = n5 <= n3 and n3 <= n6
                        v4 = flag5
                    end

                    if v4 then
                        _G.Ox.State.busy = true

                        task.spawn(function()
                            fn24()
                            task.wait(0.05)
                            _G.Ox.State.busy = false
                        end)
                    end
                end

                return
            end

            _G.Ox.State.RandomMode_IsNormal = false
        end)
    end

    local repairEvent = game:GetService("ReplicatedStorage").Remotes.Generator.RepairEvent
    local tbl6 = {}
    local n3 = 0

    GetAllGenerators = function()
        local now = tick()
        if now - n3 < 5 then
            return tbl6
        end
        tbl6 = {}
        n3 = now
        local map = workspace:FindFirstChild("Map")
        if not map then
            return tbl6
        end

        pcall(function()
            for k, descendant in pairs(map:GetDescendants()) do
                if descendant:IsA("Model") and descendant.Name == "Generator" then
                    local flag4 = descendant:GetAttribute("RepairProgress") ~= nil or descendant:GetAttribute("kickcount") ~= nil or descendant:GetAttribute("ProgressRepair") ~= nil

                    if flag4 then
                        table.insert(tbl6, descendant)
                    end
                end
            end
        end)

        return tbl6
    end

    _G.Ox.PlayRepairAnim = function()
        local character = localPlayer.Character
        if not character then
            return
        end
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        local animator = humanoid and humanoid:FindFirstChildOfClass("Animator")
        if not animator then
            return
        end

        if _G.Ox.RepairAnimTrack and _G.Ox.RepairAnimTrack.IsPlaying then
            return
        end

        pcall(function()
            local animation = Instance.new("Animation")
            animation.AnimationId = "rbxassetid://92960319113695"
            _G.Ox.RepairAnimTrack = animator:LoadAnimation(animation)
            _G.Ox.RepairAnimTrack.Priority = Enum.AnimationPriority.Action
            _G.Ox.RepairAnimTrack:Play()
        end)
    end

    _G.Ox.StopRepairAnim = function()
        if _G.Ox.RepairAnimTrack and _G.Ox.RepairAnimTrack.IsPlaying then
            pcall(function()
                _G.Ox.RepairAnimTrack:Stop()
            end)
        end

        _G.Ox.RepairAnimTrack = nil
    end

    GetGeneratorPoints = function(arg)
        local tbl7 = {}

        pcall(function()
            for k, child in pairs(arg:GetChildren()) do
                if child.Name:find("GeneratorPoint") and child:IsA("BasePart") then
                    table.insert(tbl7, child)
                end
            end
        end)

        return tbl7
    end

    _G.Ox.StopAutoRepair = function()
        _G.Ox.StopRepairAnim()
        local autoCurrentPoint = _G.Ox.AutoCurrentPoint
        _G.Ox.AutoCurrentPoint = nil

        if autoCurrentPoint then
            pcall(function()
                repairEvent:FireServer(autoCurrentPoint, false)
            end)
        end
    end

    _G.Ox.StartAutoRepairLoop = function(autoCurrentGenModel)
        _G.Ox.AutoCurrentGenModel = autoCurrentGenModel

        if _G.Ox.AutoRepairThread then
            task.cancel(_G.Ox.AutoRepairThread)
            _G.Ox.AutoRepairThread = nil
        end

        _G.Ox.StopAutoRepair()

        _G.Ox.AutoRepairThread = task.spawn(function()
            while _G.Ox.AutoRepairEnabled and _G.Ox.BypassGenEnabled do
                local character = localPlayer.Character
                local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                if not humanoidRootPart then
                    task.wait(0.1)
                    continue
                end
                local v4 = nil
                local v5, v6, v7 = pairs(GetAllGenerators())
                local v8 = v7
                local v9 = v5
                local v10 = v6
                local v11, v12

                repeat
                    v11, v12 = v9(v10, v8)
                    if v11 == nil then
                        break
                    end

                    for k, v13 in pairs(GetGeneratorPoints(v12)) do
                        if (humanoidRootPart.Position - v13.Position).Magnitude <= 5 then
                            v4 = v13
                            break
                        end
                    end

                    v8 = v11
                until v4

                if v4 then
                    _G.Ox.AutoCurrentPoint = v4
                    local now = tick()

                    if _G.Ox.AutoFireInterval <= now - _G.Ox.LastFireTime then
                        _G.Ox.PlayRepairAnim()

                        pcall(function()
                            repairEvent:FireServer(v4, true)
                        end)
                        _G.Ox.LastFireTime = now
                    end
                elseif _G.Ox.AutoCurrentPoint then
                    _G.Ox.StopAutoRepair()
                    _G.Ox.AutoRepairEnabled = false

                    if _G.Ox.AutoCurrentGenModel then
                        _G.Ox.ProcessedGens[_G.Ox.AutoCurrentGenModel] = nil
                        _G.Ox.AutoCurrentGenModel = nil
                    end

                    break
                end

                task.wait(0.1)
            end

            _G.Ox.StopAutoRepair()
        end)
    end

    waitForRepairing = function(arg, arg2)
        local now = tick()

        while true do
            local n4 = tick() - now
            local n5 = arg2 or 1
            if n4 >= n5 then
                break
            end

            if arg:GetAttribute("IsRepairing") == true then
                return true
            end
            task.wait(0.05)
        end

        return false
    end

    RecreateBypassButton = function()
        local bypassGenUI = CoreGui:FindFirstChild("BypassGenUI")

        if bypassGenUI then
            bypassGenUI:Destroy()
        end

        _G.Ox.BypassUI = Instance.new("ScreenGui")
        _G.Ox.BypassUI.Name = "BypassGenUI"
        _G.Ox.BypassUI.ResetOnSpawn = false
        _G.Ox.BypassUI.IgnoreGuiInset = true
        _G.Ox.BypassUI.Parent = CoreGui
        _G.Ox.BypassButton = Instance.new("ImageButton")
        _G.Ox.BypassButton.Name = "BypassGenButton"
        _G.Ox.BypassButton.Size = UDim2.new(0, 55, 0, 55)
        _G.Ox.BypassButton.Position = UDim2.new(0.88, 0, 0.55, 0)
        _G.Ox.BypassButton.AnchorPoint = Vector2.new(0.5, 0.5)
        _G.Ox.BypassButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        _G.Ox.BypassButton.BackgroundTransparency = 0.15
        _G.Ox.BypassButton.AutoButtonColor = true
        _G.Ox.BypassButton.Visible = false
        _G.Ox.BypassButton.ZIndex = 10
        _G.Ox.BypassButton.Parent = _G.Ox.BypassUI
        local uiCorner = Instance.new("UICorner")
        uiCorner.CornerRadius = UDim.new(1, 0)
        uiCorner.Parent = _G.Ox.BypassButton
        local uiStroke = Instance.new("UIStroke")
        uiStroke.Color = Color3.fromRGB(255, 255, 255)
        uiStroke.Thickness = 1.5
        uiStroke.Transparency = 0.4
        uiStroke.Parent = _G.Ox.BypassButton
        local textLabel = Instance.new("TextLabel")
        textLabel.Size = UDim2.new(1, 0, 1, 0)
        textLabel.BackgroundTransparency = 1
        textLabel.Text = "GEN"
        textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        textLabel.TextScaled = true
        textLabel.Font = Enum.Font.GothamBold
        textLabel.ZIndex = 11
        textLabel.Parent = _G.Ox.BypassButton
        local bypassButton = _G.Ox.BypassButton
        local bypassToggleValue = _G.Ox.BypassToggleValue
        local touchEnabled = bypassToggleValue and UserInputService.TouchEnabled

        if touchEnabled then
            if UserInputService.KeyboardEnabled then
                touchEnabled = false
            else
                touchEnabled = true
            end
        end

        bypassButton.Visible = touchEnabled
    end

    RecreateBypassButton()

    _G.Ox.DoMultiRepairPlain = function(arg)
        local parent = arg.Parent
        if _G.Ox.ProcessedGens[parent] then
            return
        end
        _G.Ox.ProcessedGens[parent] = true
        local v4 = GetGeneratorPoints(parent)
        local character = localPlayer.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then
            _G.Ox.ProcessedGens[parent] = nil
            return
        end
        local cFrame = humanoidRootPart.CFrame

        pcall(function()
            for k, v5 in pairs(v4) do
                if v5 ~= arg and v5.Parent then
                    humanoidRootPart.Anchored = true
                    humanoidRootPart.CFrame = v5.CFrame
                    task.wait(0.15)

                    pcall(function()
                        repairEvent:FireServer(v5, true)
                    end)

                    if not waitForRepairing(v5, 0.8) then
                        pcall(function()
                            repairEvent:FireServer(v5, false)
                        end)

                        task.wait(0.1)
                        humanoidRootPart.CFrame = v5.CFrame
                        task.wait(0.15)

                        pcall(function()
                            repairEvent:FireServer(v5, true)
                        end)

                        waitForRepairing(v5, 0.5)
                    end

                    humanoidRootPart.Anchored = false
                    task.wait(0.05)
                end
            end
        end)

        pcall(function()
            if humanoidRootPart and humanoidRootPart.Parent then
                humanoidRootPart.Anchored = false
                humanoidRootPart.CFrame = cFrame
            end
        end)

        task.wait(0.1)

        if _G.Ox.BypassGenMode == "Manual Repair" then
            pcall(function()
                repairEvent:FireServer(arg, false)
            end)
        elseif _G.Ox.BypassGenMode == "Auto Repair" then
            _G.Ox.AutoRepairEnabled = true
            _G.Ox.StartAutoRepairLoop(parent)
        end
    end

    _G.Ox.BypassButton.MouseButton1Click:Connect(function()
        if not _G.Ox.BypassGenEnabled then
            return
        end
        local character = localPlayer.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then
            return
        end
        local v4 = nil
        local huge = math.huge
        local v5, v6, v7 = pairs(GetAllGenerators())
        local v8 = v7
        local v9 = v5
        local v10 = v6

        while true do
            local v11, v12 = v9(v10, v8)
            if v11 == nil then
                break
            end

            for k, v13 in pairs(GetGeneratorPoints(v12)) do
                local magnitude = (humanoidRootPart.Position - v13.Position).Magnitude

                if magnitude < huge then
                    huge = magnitude
                    v4 = v13
                end
            end

            v8 = v11
        end

        if v4 and huge <= 8 then
            _G.Ox.DoMultiRepairPlain(v4)
        else
            lib:Notify({
                Title = "Gen Boost",
                Description = "Ga deket generator manapun!",
                Duration = 2,
            })
        end
    end)

    isGeneratorPromptVisible = function()
        local ok, result = pcall(function()
            return localPlayer.PlayerGui.pcprompts.Frame.GeneratorRepair
        end)

        local visible = ok and result and result.Visible
        return visible
    end

    getNearestGenPoint = function()
        local character = localPlayer.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then
            return nil
        end
        local v4 = nil
        local huge = math.huge
        local v5, v6, v7 = pairs(GetAllGenerators())
        local v8 = v7
        local v9 = v5
        local v10 = v6

        while true do
            local v11, v12 = v9(v10, v8)
            if v11 == nil then
                break
            end

            for k, v13 in pairs(GetGeneratorPoints(v12)) do
                local magnitude = (humanoidRootPart.Position - v13.Position).Magnitude

                if magnitude < huge then
                    huge = magnitude
                    v4 = v13
                end
            end

            v8 = v11
        end

        return v4, huge
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then
            return
        end

        if input.UserInputType ~= Enum.UserInputType.MouseButton1 then
            return
        end

        if not _G.Ox.BypassGenEnabled then
            return
        end

        if not isGeneratorPromptVisible() then
            return
        end
        local v4, v5 = getNearestGenPoint()
        if not v4 or v5 > 8 then
            return
        end

        if _G.Ox.ProcessedGens[v4.Parent] then
            return
        end
        _G.Ox.DoMultiRepairPlain(v4)
    end)

    startProcessedGensWatcher = function()
        task.spawn(function()
            local character, humanoidRootPart, v4, v5, v6, v7, v8, v9, v10, flag4, v11, v12, v13, v14, v15, v16, v17, v18, v19, n4
            n4 = 1

            while true do
                if n4 == 1 then
                    if _G.Ox.ScriptAlive then
                        n4 = 2
                    else
                        n4 = 16
                    end
                elseif n4 == 2 then
                    task.wait(2)

                    if _G.Ox.ScriptAlive then
                        n4 = 3
                    else
                        n4 = 16
                    end
                elseif n4 == 3 then
                    character = localPlayer.Character
                    humanoidRootPart = character

                    if character then
                        n4 = 4
                    else
                        n4 = 5
                    end
                elseif n4 == 4 then
                    humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
                    n4 = 5
                elseif n4 == 5 then
                    if humanoidRootPart then
                        n4 = 6
                    else
                        n4 = 1
                    end
                elseif n4 == 6 then
                    v4, v5, v6 = pairs(_G.Ox.ProcessedGens)
                    v7 = v6
                    v8 = v4
                    v9 = v5
                    n4 = 7
                elseif n4 == 7 then
                    v10 = v8(v9, v7)

                    if v10 == nil then
                        n4 = 1
                    else
                        n4 = 8
                    end
                elseif n4 == 8 then
                    v7 = v10

                    if v10 and v10.Parent then
                        n4 = 10
                    else
                        n4 = 9
                    end
                elseif n4 == 9 then
                    _G.Ox.ProcessedGens[v10] = nil
                    n4 = 7
                elseif n4 == 10 then
                    flag4 = false
                    v11 = GetGeneratorPoints(v10)
                    v12, v13, v14 = pairs(v11)
                    v15 = v8
                    v16 = v9
                    v17 = v14
                    n4 = 11
                elseif n4 == 11 then
                    v18, v19 = v12(v13, v17)

                    if v18 == nil then
                        n4 = 14
                    else
                        n4 = 12
                    end
                elseif n4 == 12 then
                    v17 = v18

                    if v19.Parent and (humanoidRootPart.Position - v19.Position).Magnitude <= 10 then
                        n4 = 13
                    else
                        n4 = 11
                    end
                elseif n4 == 13 then
                    flag4 = true
                    n4 = 14
                elseif n4 == 14 then
                    v7 = v10
                    v8 = v15
                    v9 = v16

                    if flag4 then
                        n4 = 7
                    else
                        n4 = 15
                    end
                elseif n4 == 15 then
                    _G.Ox.ProcessedGens[v10] = nil
                    n4 = 7
                elseif n4 == 16 then
                    return
                end
            end
        end)
end

startProcessedGensWatcher()
    INVIS_URL = "https://script.panduhub.com/invisibility.lua"
    local v4 = nil
    local flag4 = false
    local touchEnabled = UserInputService.TouchEnabled
    local flag5 = touchEnabled

    if touchEnabled then
        if UserInputService.KeyboardEnabled then
            flag5 = false
        else
            flag5 = true
        end
    end

    local function fn25()
        if flag4 then
            return true
        end

        local ok, result = pcall(function()
            return loadstring(game:HttpGet(INVIS_URL))()
        end)

        if not ok or not result then
            return false
        end
        v4 = result
        flag4 = true
        return true
    end

    fn8 = function(arg)
        if arg then
            if not flag4 then
                fn25()
            end

            if v4 then
                if flag5 then
                    v4.ShowGUI()
                else
                    v4.Enable()
                end
            end
        elseif v4 then
            if flag5 then
                v4.HideGUI()
            end

            v4.Disable()
        end
    end

    v2 = nil
    local flag6 = false

    local function fn26()
        if flag6 then
            return true
        end

        local ok, result = pcall(function()
            return loadstring(game:HttpGet("https://script.panduhub.com/BoostBandage.lua"))()
        end)

        if not ok or not result then
            return false
        end
        v2 = result
        flag6 = true
        return true
    end

    fn9 = function(arg)
        if arg then
            if not flag6 then
                fn26()
            end

            if v2 then
                if flag5 then
                    v2.ShowGUI()
                elseif not v2.Start() then
                    _G.Ox.Utility.BandageEnabled = false
                end
            end
        elseif v2 then
            if flag5 then
                v2.HideGUI()
            end

            v2.Stop()
        end
    end

    local v5 = nil
    local flag7 = false

    local function fn27()
        if flag7 then
            return true
        end

        local ok, result = pcall(function()
            return loadstring(game:HttpGet("https://pastefy.app/Pu94U00g/raw"))()
        end)

        if not ok or not result then
            return false
        end
        v5 = result
        flag7 = true
        return true
    end

    fn10 = function(arg)
        if arg then
            if not flag7 then
                fn27()
            end

            if v5 then
                if flag5 then
                    v5.ShowGUI()
                else
                    v5.Enable()
                end

                lib:Notify({
                    Title = "Dash Lock",
                    Description = "AKTIF - Klik kanan untuk lock",
                    Duration = 3,
                })
            end
        elseif v5 then
            if flag5 then
                v5.HideGUI()
            end

            v5.Disable()

            lib:Notify({
                Title = "Dash Lock",
                Description = "NONAKTIF",
                Duration = 2,
            })
        end
    end

    task.spawn(function()
        task.wait(2)
        fn27()
    end)

    local v6 = nil
    local flag8 = false

    local function fn28()
        if flag8 then
            return true
        end

        local ok, result = pcall(function()
            return loadstring(game:HttpGet("https://pastefy.app/NKuKyY5i/raw"))()
        end)

        if not ok or not result then
            return false
        end
        v6 = result
        flag8 = true
        return true
    end

    fn11 = function(arg)
        if arg then
            if not fn28() then
                lib:Notify({
                    Title = "Mask GUI",
                    Description = "Gagal load script!",
                    Duration = 3,
                })

                return
            end

            local v7, v8 = v6.Toggle(true)

            if v7 then
                local notify = lib.Notify
                local tbl7 = {Title = "Mask GUI"}
                local description = v8 or "Dimuat! (Tombol M)"
                tbl7.Description = description
                tbl7.Duration = 3
                notify(lib, tbl7)
            else
                local notify = lib.Notify
                local tbl7 = {Title = "Mask GUI"}
                local description = v8 or "Kamu bukan The Masked!"
                tbl7.Description = description
                tbl7.Duration = 3
                notify(lib, tbl7)
            end
        elseif flag8 and v6 then
            v6.Toggle(false)

            lib:Notify({
                Title = "Mask GUI",
                Description = "Disembunyikan",
                Duration = 2,
            })
        end
    end

    task.spawn(function()
        task.wait(2)
        fn28()
    end)

    getTargetPartObject = function(arg)
        if _G.Ox.AimConfig.AIM_TargetPart == "Head" then
            return arg:FindFirstChild("Head")
        end

        if _G.Ox.AimConfig.AIM_TargetPart == "Root" or _G.Ox.AimConfig.AIM_TargetPart == "HumanoidRootPart" then
            return arg:FindFirstChild("HumanoidRootPart")
        end
        local torso = arg:FindFirstChild("Torso")
        local upperTorso = torso or arg:FindFirstChild("UpperTorso") or arg:FindFirstChild("HumanoidRootPart")
        return upperTorso
    end

    getClosestSurvivor = function()
        local character = localPlayer.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then
            return nil
        end
        local veilFov = _G.Ox.AimConfig.Veil_FOV
        local v7 = nil
        local currentCamera2 = workspace.CurrentCamera
        local vector2 = Vector2.new(currentCamera2.ViewportSize.X / 2, currentCamera2.ViewportSize.Y / 2)

        for i, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Team and player.Team.Name == "Survivors" and player.Character then
                local character2 = player.Character
                local humanoid = character2:FindFirstChildOfClass("Humanoid")
                local v8 = getTargetPartObject(character2)

                if humanoid and humanoid.Health > 0 and v8 and (v8.Position - humanoidRootPart.Position).Magnitude <= _G.Ox.AimConfig.SPEAR_MaxDist then
                    local v9, v10 = currentCamera2:WorldToViewportPoint(v8.Position)

                    if v10 then
                        local magnitude = (Vector2.new(v9.X, v9.Y) - vector2).Magnitude

                        if magnitude <= veilFov then
                            veilFov = magnitude
                            v7 = v8
                        end
                    end
                end
            end
        end

        return v7
    end

    getBestAimbotTarget = function()
        local v7 = nil
        local v8 = GetRole()
        local survAimbotRadius = _G.Ox.Config.Surv_Aimbot_Radius
        local huge = math.huge
        local vector2 = Vector2.new(currentCamera.ViewportSize.X / 2, currentCamera.ViewportSize.Y / 2)

        for i, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
                local flag9 = false

                if v8 == "Survivor" and _G.Ox.Config.Surv_Aimbot_Enabled and IsKiller(player) then
                    flag9 = true
                elseif v8 == "Killer" and _G.Ox.Config.Killer_Aimbot_Enabled and not IsKiller(player) then
                    local humanoid = player.Character:FindFirstChild("Humanoid")

                    if humanoid and humanoid.Health > 0 and not IsDowned(player.Character) then
                        flag9 = true
                    end
                end

                if flag9 then
                    local humanoidRootPart = player.Character.HumanoidRootPart
                    local v9 = GetDistance(humanoidRootPart.Position)

                    if v8 == "Survivor" and v9 <= _G.Ox.Config.Surv_Aimbot_MaxDist then
                        local v10, v11 = currentCamera:WorldToViewportPoint(humanoidRootPart.Position)

                        if v11 then
                            local magnitude = (Vector2.new(v10.X, v10.Y) - vector2).Magnitude

                            if magnitude < survAimbotRadius then
                                survAimbotRadius = magnitude
                                v7 = humanoidRootPart
                            end
                        end
                    elseif v8 == "Killer" and v9 <= _G.Ox.Config.Killer_Aimbot_MaxDist and v9 < huge then
                        huge = v9
                        v7 = humanoidRootPart
                    end
                end
            end
        end

        return v7
    end

    getBestKillerAimbotTarget = function()
        local v7 = nil
        local huge = math.huge
        local character = localPlayer.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then
            return nil
        end

        for i, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Team and player.Team.Name == "Survivors" and player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                local humanoidRootPart2 = player.Character:FindFirstChild("HumanoidRootPart")

                if humanoid and humanoid.Health > 0 and humanoidRootPart2 and not IsDowned(player.Character) then
                    local magnitude = (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude

                    if magnitude < huge and magnitude <= _G.Ox.Config.Killer_Aimbot_MaxDist then
                        huge = magnitude
                        v7 = humanoidRootPart2
                    end
                end
            end
        end

        return v7
    end

    getKillerTargetForFlash = function()
        local v7 = nil
        local huge = math.huge
        local character = localPlayer.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then
            return nil
        end

        for i, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Team and player.Team.Name == "Killer" and player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                local humanoidRootPart2 = player.Character:FindFirstChild("HumanoidRootPart")

                if humanoid and humanoid.Health > 0 and humanoidRootPart2 and not IsDowned(player.Character) then
                    local magnitude = (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude

                    if magnitude < huge then
                        huge = magnitude
                        v7 = humanoidRootPart2
                    end
                end
            end
        end

        return v7
    end

    NEX_UpdateCureFlaskLaser = function()
        local character = localPlayer.Character
        if not character then
            return
        end
        local position = nil
        local v7 = nil
        local v8 = nil
        local huge = math.huge
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

        if humanoidRootPart then
            local leftHand = character:FindFirstChild("LeftHand")
            local leftArm = leftHand or character:FindFirstChild("Left Arm")
            local position2 = leftArm and leftArm.Position or humanoidRootPart.Position
            v7 = position2

            for k, player in pairs(Players:GetPlayers()) do
                if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and not IsKiller(player) then
                    local magnitude = (player.Character.HumanoidRootPart.Position - humanoidRootPart.Position).Magnitude

                    if magnitude < huge then
                        huge = magnitude
                        v8 = player
                    end
                end
            end
        end

        if v8 then
            position = v8.Character.HumanoidRootPart.Position
        end

        local flag9 = false

        for k, child in pairs(character:GetChildren()) do
            if child:IsA("LocalScript") and child:GetAttribute("action") == true then
                flag9 = true
                break
            end
        end

        if v7 and position and flag9 then
            if not _G.Ox.NEX_CureFlaskLaserPart then
                local part = Instance.new("Part")
                part.Name = "FlaskSilentAimLaser"
                part.Anchored = true
                part.CanCollide = false
                part.CanTouch = false
                part.CastShadow = false
                part.Material = Enum.Material.Neon
                part.Color = Color3.fromRGB(255, 50, 50)
                part.Transparency = 0
                part.Parent = workspace
                _G.Ox.NEX_CureFlaskLaserPart = part
            end

            local magnitude = (position - v7).Magnitude

            if magnitude > 0.1 then
                local nexCureFlaskLaserPart = _G.Ox.NEX_CureFlaskLaserPart
                nexCureFlaskLaserPart.Size = Vector3.new(0.16, 0.16, magnitude)
                nexCureFlaskLaserPart.CFrame = CFrame.new((v7 + position) / 2, position)
                nexCureFlaskLaserPart.Transparency = 0
            end
        elseif _G.Ox.NEX_CureFlaskLaserPart then
            _G.Ox.NEX_CureFlaskLaserPart.Transparency = 1
        end
    end

    NEX_StartCureFlaskLaser = function()
        if _G.Ox.NEX_CureFlaskLaserThread then
            return
        end

        _G.Ox.NEX_CureFlaskLaserThread = RunService.RenderStepped:Connect(function()
            if not _G.Ox.KILLER_FlaskLaser then
                if _G.Ox.NEX_CureFlaskLaserPart then
                    pcall(function()
                        _G.Ox.NEX_CureFlaskLaserPart:Destroy()
                    end)

                    _G.Ox.NEX_CureFlaskLaserPart = nil
                end

                if _G.Ox.NEX_CureFlaskLaserThread then
                    _G.Ox.NEX_CureFlaskLaserThread:Disconnect()
                    _G.Ox.NEX_CureFlaskLaserThread = nil
                end

                return
            end

            pcall(NEX_UpdateCureFlaskLaser)
        end)
    end

    setupSpearInterceptor = function()
        if flag3 then
            return
        end

        if not getrawmetatable or not setreadonly then
            return
        end
        local spearthrow = nil

        pcall(function()
            spearthrow = ReplicatedStorage.Remotes.Killers.Veil.Spearthrow
        end)

        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        local fall = remotes and ReplicatedStorage.Remotes:FindFirstChild("Mechanics") and ReplicatedStorage.Remotes.Mechanics:FindFirstChild("Fall")

        local function fn29(arg, arg2, arg3, arg4)
            local n4 = math.max(arg3, 0.1)
            local n5 = arg * arg
            local n6 = n5 * n5 - arg2 * (arg2 * n4 * n4 + 2 * arg4 * n5)
            local n7 = n6

            if n6 < 0 then
                n7 = 0
            end

            local n8 = (n5 - math.sqrt(n7)) / (arg2 * n4)
            local v7 = math.atan(n8)
            return v7, n4 / (arg * math.cos(v7))
        end

        local v7 = getrawmetatable(game)
        setreadonly(v7, false)
        local namecall = v7.__namecall

        v7.__namecall = newcclosure(function(arg, ...)
            local v8 = getnamecallmethod()
            local flag9 = v8 == "FireServer" or v8 == "fireServer" or v8 == "InvokeServer"

            if flag9 and not checkcaller() and typeof(arg) == "Instance" then
                if _G.Ox.NoFall.Enabled and fall and arg == fall then
                    local tbl7 = {...}
                    tbl7[1] = 0
                    return namecall(arg, unpack(tbl7))
                end

                if _G.Ox.AntiBlindEnabled and _G.Ox.GotBlindedRemote and arg == _G.Ox.GotBlindedRemote and localPlayer.Team and localPlayer.Team.Name == "Killer" then
                    return nil
                end

                if _G.Ox.BulletBlockConfig.Enabled and arg.Name == "Fire" then
                    local parent = arg.Parent
                    if parent and parent.Name == "Twist of Fate" then
                        return nil
                    end
                end

                if _G.Ox.KILLER_SilentAimFlask and arg.Name == "ThrowFlask" then
                    local tbl7 = {...}
                    local v9 = nil
                    local huge = math.huge
                    local character = localPlayer.Character
                    local position = character and localPlayer.Character:FindFirstChild("HumanoidRootPart") and localPlayer.Character.HumanoidRootPart.Position

                    if position then
                        for k, player in pairs(Players:GetPlayers()) do
                            if player ~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") and not IsKiller(player) then
                                local magnitude = (player.Character.HumanoidRootPart.Position - position).Magnitude

                                if magnitude < huge then
                                    huge = magnitude
                                    v9 = player
                                end
                            end
                        end
                    end

                    if v9 and tbl7[2] and typeof(tbl7[2]) == "Vector3" then
                        tbl7[1] = (v9.Character.HumanoidRootPart.Position - tbl7[2]).Unit
                        setnamecallmethod(v8)
                        return namecall(arg, unpack(tbl7))
                    end
                end

                if v8 == "FireServer" and typeof(arg) == "Instance" and string.lower(tostring(arg.Name)) == "updatecharacterlook" then
                    local ox4 = _G.Ox
                    local invisEnabled = ox4 and _G.Ox.Utility and _G.Ox.Utility.InvisEnabled

                    if invisEnabled then
                        local tbl7 = {}

                        for i, v9 in ipairs({...}) do
                            if typeof(v9) == "CFrame" then
                                tbl7[i] = v9 * CFrame.new(0, 5000, 0)
                            else
                                tbl7[i] = v9
                            end
                        end

                        return namecall(arg, unpack(tbl7))
                    end
                end

                if arg.ClassName == "RemoteEvent" and arg.Name == "Spearthrow" and _G.Ox.AimConfig.Aim_SilentVeilV2 and not flag2 then
                    local character = localPlayer.Character
                    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                    local v9 = character

                    if character then
                        local head = character:FindFirstChild("Head")
                        v9 = head or humanoidRootPart
                    end

                    local flag10 = character and character:GetAttribute("special") == true
                    local v10, v11

                    if flag10 then
                        local spearAuraSpeed = _G.Ox.AimConfig.SPEAR_AuraSpeed
                        local n4 = spearAuraSpeed or 165
                        v10 = n4
                        local spearAuraGravity = _G.Ox.AimConfig.SPEAR_AuraGravity
                        local n5 = spearAuraGravity or 96.5
                        v11 = n5
                    else
                        local spearSpeed = _G.Ox.AimConfig.SPEAR_Speed
                        local n4 = spearSpeed or 165
                        v10 = n4
                        local spearGravity = _G.Ox.AimConfig.SPEAR_Gravity
                        local n5 = spearGravity or 103
                        v11 = n5
                    end

                    local v12 = v10
                    local value = (select(3, ...))

                    if not (select(3, ...)) then
                        local spearSmartEnable = _G.Ox.Config.SpearSmart_enable
                        value = spearSmartEnable and humanoidRootPart and humanoidRootPart.Position
                    end

                    if not value then
                        value = v9 and v9.Position
                    end

                    local v13 = value
                    local n4 = (...)
                    local v14 = getClosestSurvivor()

                    if v14 and v13 then
                        local isModel = v14:IsA("Model")
                        local humanoidRootPart2 = isModel and v14:FindFirstChild("HumanoidRootPart") or v14
                        local position = humanoidRootPart2.Position
                        local vector = Vector3.new(0, 0, 0)
                        local parent = v14.Parent
                        local humanoid = parent and v14.Parent:FindFirstChildOfClass("Humanoid")

                        if humanoid and humanoid.MoveDirection.Magnitude > 0 then
                            vector = humanoid.MoveDirection * humanoid.WalkSpeed
                        elseif humanoidRootPart2:IsA("BasePart") then
                            vector = humanoidRootPart2.AssemblyLinearVelocity
                        end

                        local vector2 = Vector3.new(vector.X, 0, vector.Z)
                        local n5 = position - v13
                        local magnitude = n5.Magnitude
                        local magnitude2 = Vector3.new(n5.X, 0, n5.Z).Magnitude
                        local y = n5.Y

                        if magnitude > 0.1 then
                            local spearMaxDist = _G.Ox.AimConfig.SPEAR_MaxDist
                            local n6 = spearMaxDist or 1000

                            if magnitude <= n6 then
                                local veilLeadMultiplier = _G.Ox.AimConfig.Veil_LeadMultiplier
                                local n7 = veilLeadMultiplier or 1.4
                                local v15, v16 = fn29(v10, v11, magnitude2, y)

                                if _G.Ox.Config.SpearSmart_enable and vector2.Magnitude > 0.5 then
                                    local n8 = vector2 * (v16 * n7)
                                    local n9 = n8
                                    local n10 = math.clamp(magnitude * 0.6, 3, 45)

                                    if n10 < n8.Magnitude then
                                        n9 = n8.Unit * n10
                                    end

                                    local n11 = position + n9 - v13
                                    local magnitude3 = Vector3.new(n11.X, 0, n11.Z).Magnitude
                                    local value2 = select(1, fn29(v10, v11, math.max(magnitude3, 0.1), n11.Y))

                                    if magnitude3 > 0.001 then
                                        n4 = Vector3.new(n11.X, 0, n11.Z).Unit * math.cos(value2) + Vector3.new(0, math.sin(value2), 0)
                                    else
                                        n4 = n11.Unit
                                    end
                                else
                                    local value2 = select(1, fn29(v10, v11, math.max(magnitude2, 0.1), y))

                                    if magnitude2 > 0.001 then
                                        n4 = Vector3.new(n5.X, 0, n5.Z).Unit * math.cos(value2) + Vector3.new(0, math.sin(value2), 0)
                                    else
                                        n4 = n5.Unit
                                    end
                                end
                            end
                        end
                    end

                    flag2 = true

                    pcall(function()
                        if spearthrow then
                            spearthrow:FireServer(n4, v12, v13)
                        else
                            arg:FireServer(n4, v12, v13)
                        end
                    end)

                    flag2 = false
                    return
                end
            end

            return namecall(arg, ...)
        end)

        setreadonly(v7, true)
        flag3 = true
    end

    local function fn29()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        local items = remotes and ReplicatedStorage.Remotes:FindFirstChild("Items")
        local flashlight = items and items:FindFirstChild("Flashlight")

        if flashlight then
            _G.Ox.GotBlindedRemote = flashlight:FindFirstChild("GotBlinded")
        end
    end

    task.spawn(function()
        task.wait(1)
        fn29()
        setupSpearInterceptor()
    end)

    localPlayer.CharacterAdded:Connect(function()
        task.wait(1)
        fn29()
    end)
end

local tbl5, fn12, fn13, fn14, fn15, fn16, fn17, fn18, fn19, fn20, fn21, fn22

do
    local v3 = Connections
    tbl5 = v3 or {}

    fn12 = function()
        if tbl5.LeapBypass then
            task.cancel(tbl5.LeapBypass)
            tbl5.LeapBypass = nil
        end

        tbl5.LeapBypass = task.spawn(function()
            local v4, v5, v6, v7, v8, v9, v10, v11, v12, v13, v14, v15, v16, v17, v18, v19, v20, v21, v22, v23
            local v24, v25, v26, v27, v28, n
            n = 1

            while true do
                if n == 1 then
                    v4 = nil
                    v5 = nil
                    v6, v7, v8 = pairs(getgc(true))
                    v9 = v8
                    n = 2
                elseif n == 2 then
                    v10, v11 = v6(v7, v9)

                    if v10 == nil then
                        n = 9
                    else
                        n = 3
                    end
                elseif n == 3 then
                    v9 = v10

                    if type(v11) == "function" and islclosure(v11) then
                        n = 4
                    else
                        n = 2
                    end
                elseif n == 4 then
                    v12 = debug.getinfo(v11)

                    if v12.name == "tryActivate" then
                        n = 5
                    else
                        n = 6
                    end
                elseif n == 5 then
                    v4 = v11
                    n = 6
                elseif n == 6 then
                    if v12.name == "playM2Animation" then
                        n = 7
                    else
                        n = 8
                    end
                elseif n == 7 then
                    v5 = v11
                    n = 8
                elseif n == 8 then
                    if v4 and v5 then
                        n = 9
                    else
                        n = 2
                    end
                elseif n == 9 then
                    if not v4 and not v5 then
                        n = 20
                    else
                        n = 10
                    end
                elseif n == 10 then
                    if task.wait(0.1) and _G.Ox.BypassLeapEnabled then
                        n = 12
                    else
                        n = 11
                    end
                elseif n == 11 then
                    return
                elseif n == 12 then
                    v13, v14, v15 = pairs({v4, v5})
                    v16 = v15
                    v17 = v13
                    v18 = v14
                    n = 13
                elseif n == 13 then
                    v19, v20 = v17(v18, v16)

                    if v19 == nil then
                        n = 10
                    else
                        n = 14
                    end
                elseif n == 14 then
                    v16 = v19

                    if v20 then
                        n = 15
                    else
                        n = 13
                    end
                elseif n == 15 then
                    v21, v22, v23 = pairs(debug.getupvalues(v20))
                    v24 = v17
                    v25 = v18
                    v26 = v23
                    n = 16
                elseif n == 16 then
                    v27, v28 = v21(v22, v26)

                    if v27 == nil then
                        n = 19
                    else
                        n = 17
                    end
                elseif n == 17 then
                    v26 = v27

                    if type(v28) == "boolean" and v28 == true then
                        n = 18
                    else
                        n = 16
                    end
                elseif n == 18 then
                    debug.setupvalue(v20, v27, false)
                    n = 16
                elseif n == 19 then
                    v16 = v19
                    v17 = v24
                    v18 = v25
                    n = 13
                elseif n == 20 then
                    warn("[BypassLeap] Function tidak ditemukan.")
                    return
                end
            end
        end)
    end

    local flag2 = false

    local function fn23()
        if GetRole() ~= "Killer" then
            return
        end
        local selectedKiller = localPlayer:FindFirstChild("SelectedKiller")
        local attribute = selectedKiller and selectedKiller.Value or localPlayer:GetAttribute("SelectedKiller")

        if attribute and string.find(string.lower(tostring(attribute)), "abyss") then
            pcall(function()
                local corrupt = ReplicatedStorage:FindFirstChild("Remotes"):FindFirstChild("Killers"):FindFirstChild("Abysswalker"):FindFirstChild("corrupt")

                if corrupt then
                    corrupt:FireServer()
                end
            end)
        end
    end

    local function fn24()
        if flag2 then
            return
        end
        flag2 = true

        task.spawn(function()
            while flag2 and _G.Ox.InfAbyssalEnabled and GetRole() == "Killer" do
                fn23()
                task.wait(0.5)
            end
        end)
    end

    fn13 = function()
        flag2 = false
    end

    UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if gameProcessed then
            return
        end

        if _G.Ox.InfAbyssalEnabled and input.KeyCode == Enum.KeyCode.Q then
            fn24()
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.KeyCode == Enum.KeyCode.Q then
            fn13()
        end
    end)

    task.spawn(function()
        while _G.Ox.ScriptAlive do
            task.wait(0.5)
            if not _G.Ox.ScriptAlive then
                break
            end

            if _G.Ox.InfAbyssalEnabled and GetRole() == "Killer" then
                local playerGui2 = localPlayer:FindFirstChild("PlayerGui")

                if playerGui2 then
                    local v4 = nil

                    for k, child in pairs(playerGui2:GetChildren()) do
                        if string.sub(child.Name, -4) == "-mob" and child.Name ~= "Survivor-mob" then
                            v4 = child
                            break
                        end
                    end

                    if v4 then
                        local controls = v4:FindFirstChild("Controls")

                        if controls then
                            local move2 = controls:FindFirstChild("move2")

                            if move2 and move2.Visible then
                                fn24()
                            else
                                fn13()
                            end
                        end
                    end
                end
            else
                fn13()
            end
        end
    end)

    EnableInfiniteLunge = function()
        _G.Ox.InfiniteLungeEnabled = true
        local character = localPlayer.Character

        if character then
            character:SetAttribute("lungeboost", 999)

            if _G.Ox.InfLungeAttrConn then
                _G.Ox.InfLungeAttrConn:Disconnect()
            end

            _G.Ox.InfLungeAttrConn = character:GetAttributeChangedSignal("lungeboost"):Connect(function()
                if _G.Ox.InfiniteLungeEnabled and character:GetAttribute("lungeboost") ~= 999 then
                    character:SetAttribute("lungeboost", 999)
                end
            end)
        end

        lib:Notify({
            Title = "Infinite Lunge",
            Description = "AKTIF (999x)",
            Duration = 3,
        })
    end

    DisableInfiniteLunge = function()
        _G.Ox.InfiniteLungeEnabled = false

        if _G.Ox.InfLungeAttrConn then
            _G.Ox.InfLungeAttrConn:Disconnect()
            _G.Ox.InfLungeAttrConn = nil
        end

        local character = localPlayer.Character

        if character then
            character:SetAttribute("lungeboost", 1)
    end

    lib:Notify({
            Title = "Infinite Lunge",
            Description = "NONAKTIF",
            Duration = 2,
        })
    end

    localPlayer.CharacterAdded:Connect(function(character)
        task.wait(0.8)

        if _G.Ox.InfiniteLungeEnabled and character then
            character:SetAttribute("lungeboost", 999)
        end
    end)

    StopCounterParry = function()
        _G.Ox.CounterParry.Enabled = false

        if _G.Ox.CounterParry.Thread then
            task.cancel(_G.Ox.CounterParry.Thread)
            _G.Ox.CounterParry.Thread = nil
        end

        if _G.Ox.CounterParry.Track then
            pcall(function()
                _G.Ox.CounterParry.Track:Stop()
            end)

            _G.Ox.CounterParry.Track = nil
        end
    end

    StartCounterParry = function()
        if _G.Ox.CounterParry.Thread then
            return
        end

        _G.Ox.CounterParry.Thread = task.spawn(function()
            local character, humanoid, animator, humanoidRootPart, animation, ok, track, flag3, distance, v4, v5, v6, v7, v8, v9, character2, humanoidRootPart2, n
            n = 1

            while true do
                if n == 1 then
                    if _G.Ox.CounterParry.Enabled and _G.Ox.ScriptAlive then
                        n = 3
                    else
                        n = 2
                    end
                elseif n == 2 then
                    _G.Ox.CounterParry.Thread = nil
                    return
                elseif n == 3 then
                    character = localPlayer.Character

                    if character and character.Parent and GetRole() == "Killer" then
                        n = 5
                    else
                        n = 4
                    end
                elseif n == 4 then
                    task.wait(0.4)
                    n = 1
                elseif n == 5 then
                    humanoid = character:FindFirstChildOfClass("Humanoid")
                    animator = humanoid

                    if humanoid then
                        n = 6
                    else
                        n = 7
                    end
                elseif n == 6 then
                    animator = humanoid:FindFirstChildOfClass("Animator")
                    n = 7
                elseif n == 7 then
                    humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                    if animator and humanoidRootPart then
                        n = 9
                    else
                        n = 8
                    end
                elseif n == 8 then
                    task.wait(0.3)
                    n = 1
                elseif n == 9 then
                    if _G.Ox.CounterParry.Track and _G.Ox.CounterParry.Track.Parent ~= nil then
                        n = 13
                    else
                        n = 10
                    end
                elseif n == 10 then
                    animation = Instance.new("Animation")
                    animation.AnimationId = _G.Ox.CounterParry.AnimId

                    ok, track = pcall(function()
                        return animator:LoadAnimation(animation)
                    end)

                    if ok and track then
                        n = 12
                    else
                        n = 11
                    end
                elseif n == 11 then
                    task.wait(0.5)
                    n = 1
                elseif n == 12 then
                    _G.Ox.CounterParry.Track = track
                    n = 13
                elseif n == 13 then
                    flag3 = false
                    distance = _G.Ox.CounterParry.Distance
                    v4, v5, v6 = ipairs(Players:GetPlayers())
                    v7 = v6
                    n = 14
                elseif n == 14 then
                    v8, v9 = v4(v5, v7)

                    if v8 == nil then
                        n = 20
                    else
                        n = 15
                    end
                elseif n == 15 then
                    v7 = v8

                    if v9 ~= localPlayer and v9.Team and v9.Team.Name == "Survivors" then
                        n = 16
                    else
                        n = 14
                    end
                elseif n == 16 then
                    character2 = v9.Character
                    humanoidRootPart2 = character2

                    if character2 then
                        n = 17
                    else
                        n = 18
                    end
                elseif n == 17 then
                    humanoidRootPart2 = v9.Character:FindFirstChild("HumanoidRootPart")
                    n = 18
                elseif n == 18 then
                    if humanoidRootPart2 and (humanoidRootPart.Position - humanoidRootPart2.Position).Magnitude <= distance then
                        n = 19
                    else
                        n = 14
                    end
                elseif n == 19 then
                    flag3 = true
                    n = 20
                elseif n == 20 then
                    if flag3 and _G.Ox.CounterParry.Track then
                        n = 21
                    else
                        n = 22
                    end
                elseif n == 21 then
                    pcall(function()
                        _G.Ox.CounterParry.Track:Play()
                        _G.Ox.CounterParry.Track:AdjustWeight(0)
                    end)

                    task.wait(0.05)

                    pcall(function()
                        _G.Ox.CounterParry.Track:Stop()
                    end)

                    n = 22
                elseif n == 22 then
                    task.wait(_G.Ox.CounterParry.Interval)
                    n = 1
                end
            end
        end)
    end

    ToggleCounterParry = function(arg)
        if arg then
            if GetRole() ~= "Killer" then
                lib:Notify({
                    Title = "Counter Auto Parry",
                    Description = "Khusus Killer!",
                    Duration = 3,
                })

                _G.Ox.CounterParry.Enabled = false

                if CounterParryToggle then
                    fn(CounterParryToggle, false)
                end

                return
            end

            _G.Ox.CounterParry.Enabled = true
            StartCounterParry()

            lib:Notify({
                Title = "Counter Auto Parry",
                Description = "AKTIF",
                Duration = 2,
            })
        else
            StopCounterParry()

            lib:Notify({
                Title = "Counter Auto Parry",
                Description = "NONAKTIF",
                Duration = 2,
            })
        end
    end

    localPlayer.CharacterAdded:Connect(function()
        _G.Ox.CounterParry.Track = nil
        task.wait(1)

        if _G.Ox.CounterParry.Enabled then
            StartCounterParry()
        end
    end)

    local function fn25()
        local remotes = ReplicatedStorage:FindFirstChild("Remotes")
        local killers = remotes and remotes:FindFirstChild("Killers")
        local stalker = killers and killers:FindFirstChild("Stalker")
        local startStalking = stalker and stalker:FindFirstChild("StartStalking")
        return startStalking
    end

    local function fn26()
        local character = localPlayer.Character
        local humanoidRootPart = character and localPlayer.Character:FindFirstChild("HumanoidRootPart")
        if not humanoidRootPart then
            return nil
        end
        local v4 = nil
        local huge = math.huge
        local range = _G.Ox.AutoStalk.Range

        for i, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character then
                local humanoid = player.Character:FindFirstChildOfClass("Humanoid")
                local humanoidRootPart2 = player.Character:FindFirstChild("HumanoidRootPart")

                if humanoid and humanoidRootPart2 and humanoid.Health > 30 then
                    local magnitude = (humanoidRootPart2.Position - humanoidRootPart.Position).Magnitude

                    if magnitude <= range and magnitude < huge then
                        huge = magnitude
                        v4 = player
                    end
                end
            end
        end

        return v4
    end

    StopAutoStalk = function()
        _G.Ox.AutoStalk.Enabled = false

        if _G.Ox.AutoStalk.Conn then
            _G.Ox.AutoStalk.Conn:Disconnect()
            _G.Ox.AutoStalk.Conn = nil
        end
    end

    StartAutoStalk = function()
        if _G.Ox.AutoStalk.Conn then
            return
        end

        _G.Ox.AutoStalk.Conn = RunService.Heartbeat:Connect(function()
            if not _G.Ox.AutoStalk.Enabled or not _G.Ox.ScriptAlive then
                return
            end

            if GetRole() ~= "Killer" then
                return
            end
            local now = tick()
            local lastFire = _G.Ox.AutoStalk.LastFire
            local n = lastFire or 0
            if now - n < 0.35 then
                return
            end
            local v4 = fn26()
            if not v4 or not v4.Character then
                return
            end
            local v5 = fn25()

            if v5 then
                _G.Ox.AutoStalk.LastFire = now

                pcall(function()
                    v5:FireServer(v4)
                end)
            end
        end)
    end

    ToggleAutoStalk = function(arg)
        if arg then
            if GetRole() ~= "Killer" then
                lib:Notify({
                    Title = "Auto Stalk",
                    Description = "Khusus Killer!",
                    Duration = 3,
                })

                _G.Ox.AutoStalk.Enabled = false

                if AutoStalkToggle then
                    fn(AutoStalkToggle, false)
                end

                return
            end

            _G.Ox.AutoStalk.Enabled = true
            StartAutoStalk()
            lib:Notify({Title = "Auto Stalk", Description = "AKTIF", Duration = 2})
        else
            StopAutoStalk()

            lib:Notify({
                Title = "Auto Stalk",
                Description = "NONAKTIF",
                Duration = 2,
            })
        end
    end

    local screenGui = Instance.new("ScreenGui")
    screenGui.Name = "FOVCircleGui_Standalone"
    screenGui.ResetOnSpawn = false
    screenGui.IgnoreGuiInset = true
    screenGui.Parent = CoreGui
    local frame = Instance.new("Frame")
    frame.BackgroundTransparency = 1
    frame.AnchorPoint = Vector2.new(0.5, 0.5)
    frame.Position = UDim2.new(0.5, 0, 0.5, 0)
    frame.Visible = false
    frame.Parent = screenGui
    Instance.new("UICorner", frame).CornerRadius = UDim.new(1, 0)
    local uiStroke = Instance.new("UIStroke", frame)
    uiStroke.Color = Color3.fromRGB(255, 255, 255)
    uiStroke.Thickness = 1.5
    local highlight = Instance.new("Highlight")
    highlight.Name = "VD_VeilTarget"
    highlight.FillColor = Color3.fromRGB(255, 0, 0)
    highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
    highlight.FillTransparency = 0.5
    highlight.OutlineTransparency = 0
    local v4 = nil

    local function fn27()
        if v4 then
            pcall(function()
                v4:Destroy()
            end)

            v4 = nil
        end
    end

    local function fn28(arg, arg2)
        if arg and arg2 then
            local magnitude = (arg2 - arg).Magnitude

            if magnitude < 0.2 then
                if v4 then
                    v4.Transparency = 1
                end

                return
            end

            if not v4 then
                local part = Instance.new("Part")
                part.Name = "VeilTrackerLine"
                part.Anchored = true
                part.CanCollide = false
                part.CanTouch = false
                part.CanQuery = false
                part.CastShadow = false
                part.Material = Enum.Material.Neon
                part.Color = Color3.fromRGB(255, 255, 255)
                part.Parent = workspace
                v4 = part
            end

            local vector = Vector3.new(0.08, 0.08, magnitude)
            v4.Size = vector
            local cframe = CFrame.new((arg + arg2) / 2, arg2)
            v4.CFrame = cframe
            v4.Transparency = 0.15
            return
        end

        if v4 then
            v4.Transparency = 1
        end
    end

    _G.Ox.SurvivorFOVGui = Instance.new("ScreenGui")
    _G.Ox.SurvivorFOVGui.Name = "SurvivorAimbotFOV"
    _G.Ox.SurvivorFOVGui.ResetOnSpawn = false
    _G.Ox.SurvivorFOVGui.IgnoreGuiInset = true
    _G.Ox.SurvivorFOVGui.Parent = CoreGui
    _G.Ox.SurvivorFOVFrame = Instance.new("Frame")
    _G.Ox.SurvivorFOVFrame.BackgroundTransparency = 1
    _G.Ox.SurvivorFOVFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    _G.Ox.SurvivorFOVFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    _G.Ox.SurvivorFOVFrame.Visible = false
    _G.Ox.SurvivorFOVFrame.Parent = _G.Ox.SurvivorFOVGui
    Instance.new("UICorner", _G.Ox.SurvivorFOVFrame).CornerRadius = UDim.new(1, 0)
    local uiStroke2 = Instance.new("UIStroke", _G.Ox.SurvivorFOVFrame)
    uiStroke2.Color = Color3.fromRGB(255, 255, 255)
    uiStroke2.Thickness = 1.5
    uiStroke2.Transparency = 0.5
    _G.Ox.survivorAimbotHighlight = Instance.new("Highlight")
    _G.Ox.survivorAimbotHighlight.Name = "SurvivorAimbotTarget"
    _G.Ox.survivorAimbotHighlight.FillColor = Color3.fromRGB(255, 0, 0)
    _G.Ox.survivorAimbotHighlight.OutlineColor = Color3.fromRGB(255, 255, 0)
    _G.Ox.survivorAimbotHighlight.FillTransparency = 0.4
    _G.Ox.survivorAimbotHighlight.OutlineTransparency = 0.2
    _G.Ox.killerAimbotHighlight = Instance.new("Highlight")
    _G.Ox.killerAimbotHighlight.Name = "KillerAimbotTarget"
    _G.Ox.killerAimbotHighlight.FillColor = Color3.fromRGB(255, 0, 0)
    _G.Ox.killerAimbotHighlight.OutlineColor = Color3.fromRGB(255, 255, 0)
    _G.Ox.killerAimbotHighlight.FillTransparency = 0.4
    _G.Ox.killerAimbotHighlight.OutlineTransparency = 0.2

    StopMoonwalk = function()
        _G.Ox.Moonwalk.Enabled = false
        local character = localPlayer.Character
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")

        if humanoid then
            humanoid.AutoRotate = true
        end
    end

    StartMoonwalk = function()
        local character = localPlayer.Character
        local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        if not humanoidRootPart or not humanoid then
            return
        end
        humanoid.AutoRotate = false
        _G.Ox.Moonwalk.Enabled = true
    end

    UpdateMoonwalkGUI = function(arg)
        if not _G.Ox.Moonwalk.Gui then
            return
        end
        local frame2 = _G.Ox.Moonwalk.Gui:FindFirstChild("Frame")
        if not frame2 then
            return
        end
        local actionButton = frame2:FindFirstChild("ActionButton")
        local uiStroke3 = frame2:FindFirstChild("UIStroke")

        if arg then
            if actionButton then
                actionButton.Text = "MOON [ON]"
                actionButton.TextColor3 = Color3.fromRGB(180, 255, 180)
                actionButton.BackgroundColor3 = Color3.fromRGB(40, 40, 45)
            end

            if uiStroke3 then
                uiStroke3.Color = Color3.fromRGB(100, 200, 100)
            end
        else
            if actionButton then
                actionButton.Text = "MOON [OFF]"
                actionButton.TextColor3 = Color3.fromRGB(200, 200, 200)
                actionButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
            end

            if uiStroke3 then
                uiStroke3.Color = Color3.fromRGB(90, 90, 95)
            end
        end
    end

    ToggleMoonwalkStatus = function()
        if _G.Ox.Moonwalk.Enabled then
            StopMoonwalk()
        else
            StartMoonwalk()
        end

        _G.Ox.Moonwalk.IsActive = _G.Ox.Moonwalk.Enabled
        UpdateMoonwalkGUI(_G.Ox.Moonwalk.Enabled)

        if MoonwalkPCToggle then
            fn(MoonwalkPCToggle, _G.Ox.Moonwalk.Enabled)
        end

        local notify = lib.Notify
        local tbl6 = {Title = "Moonwalk"}
        local enabled = _G.Ox.Moonwalk.Enabled
        local description = enabled and "AKTIF" or "NONAKTIF"
        tbl6.Description = description
        tbl6.Duration = 2
        notify(lib, tbl6)
    end

    CreateMoonwalkGUI = function()
        if _G.Ox.Moonwalk.Gui then
            _G.Ox.Moonwalk.Gui:Destroy()
        end

        local screenGui2 = Instance.new("ScreenGui")
        screenGui2.Name = "MoonwalkCustomGui"
        screenGui2.ResetOnSpawn = false
        screenGui2.IgnoreGuiInset = true
        screenGui2.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
        screenGui2.Parent = CoreGui
        screenGui2.Enabled = false
        _G.Ox.Moonwalk.Gui = screenGui2
        _G.Ox.Moonwalk.GuiVisible = false
        local frame2 = Instance.new("Frame", screenGui2)
        frame2.Name = "Frame"
        frame2.Size = UDim2.fromOffset(110, 36)
        frame2.Position = UDim2.fromScale(0.85, 0.45)
        frame2.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
        frame2.BackgroundTransparency = 0.1
        frame2.Active = true
        frame2.BorderSizePixel = 0
        Instance.new("UICorner", frame2).CornerRadius = UDim.new(0, 8)
        local uiStroke3 = Instance.new("UIStroke", frame2)
        uiStroke3.Name = "UIStroke"
        uiStroke3.Color = Color3.fromRGB(90, 90, 95)
        uiStroke3.Thickness = 1.5
        uiStroke3.Transparency = 0.2
        local textButton = Instance.new("TextButton", frame2)
        textButton.Name = "ActionButton"
        textButton.Size = UDim2.new(1, 0, 1, 0)
        textButton.Text = "MOON [OFF]"
        textButton.BackgroundColor3 = Color3.fromRGB(30, 30, 35)
        textButton.Font = Enum.Font.GothamBold
        textButton.TextSize = 12
        textButton.TextColor3 = Color3.fromRGB(200, 200, 200)
        textButton.BorderSizePixel = 0
        textButton.AutoButtonColor = false
        Instance.new("UICorner", textButton).CornerRadius = UDim.new(0, 8)
        local flag3 = false
        local flag4 = false
        local flag5 = false
        local position = nil
        local position2 = nil
        local thread = nil

        local function fn29(arg)
            if not flag3 or not flag5 or not position or not position2 then
                return
            end
            local n = arg.Position - position

            if not flag4 and (math.abs(n.X) > 18 or math.abs(n.Y) > 18) then
                flag4 = true
            end

            if flag4 then
                frame2.Position = UDim2.new(position2.X.Scale, position2.X.Offset + n.X, position2.Y.Scale, position2.Y.Offset + n.Y)
            end
        end

        textButton.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                flag3 = true
                flag4 = false
                flag5 = false
                position = input.Position
                position2 = frame2.Position

                if thread then
                    task.cancel(thread)
                end

                thread = task.delay(0.18, function()
                    if flag3 then
                        flag5 = true
                    end
                end)
            end
        end)

        textButton.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then if thread then
                    task.cancel(thread)
                end

                if flag3 and not flag4 then
                    ToggleMoonwalkStatus()
                end

                flag3 = false
                flag4 = false
                flag5 = false
                position = nil
                position2 = nil
            end
        end)

    UserInputService.InputChanged:Connect(function(input)
            if flag3 and flag5 and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                fn29(input)
            end
        end)

        if _G.Ox.Moonwalk._statusConn then
            _G.Ox.Moonwalk._statusConn:Disconnect()
        end

        _G.Ox.Moonwalk._statusConn = RunService.Heartbeat:Connect(function()
            if _G.Ox.Moonwalk.Gui and _G.Ox.Moonwalk.Gui.Parent then
                if _G.Ox.Moonwalk.IsActive ~= _G.Ox.Moonwalk.Enabled then
                    _G.Ox.Moonwalk.IsActive = _G.Ox.Moonwalk.Enabled
                    UpdateMoonwalkGUI(_G.Ox.Moonwalk.Enabled)
                end

                return
            end

            if _G.Ox.Moonwalk._statusConn then
                _G.Ox.Moonwalk._statusConn:Disconnect()
            end
        end)
    end

    localPlayer.CharacterAdded:Connect(function()
        task.wait(1)

        if _G.Ox.Moonwalk.Enabled then
            StartMoonwalk()
        end

        if _G.Ox.Moonwalk.GuiVisible and _G.Ox.Moonwalk.Gui then
            _G.Ox.Moonwalk.Gui.Enabled = true
            UpdateMoonwalkGUI(_G.Ox.Moonwalk.Enabled)
        end
    end)

    task.spawn(function()
        task.wait(1.5)
        CreateMoonwalkGUI()
    end)

    RunService.RenderStepped:Connect(function(deltaTime)
        if not _G.Ox.Speed.Enabled and not _G.Ox.Moonwalk.Enabled and not _G.Ox.Crosshair.Enabled and not _G.Ox.StretchRes.Enabled and not _G.Ox.Config.Surv_Aimbot_Enabled and (not _G.Ox.Config.Killer_Aimbot_Enabled or not _G.Ox.isKillerAimbotHolding) and not _G.Ox.AimConfig.Aim_SilentVeilV2 and (not flag or not _G.Ox.AimConfig.Flash_Silent) then
            return
        end

        if _G.Ox.Crosshair.Enabled then
            DrawCrosshair()
        end

        if _G.Ox.Speed.Enabled then
            local character = localPlayer.Character

            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")

                if humanoid then
                    local moveDirection = humanoid.MoveDirection

                    if moveDirection.Magnitude > 0 then
                        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")

                        if humanoidRootPart then
                            local n = (_G.Ox.Speed.Value - 0.1) * 10

                            if n > 0 then
                                humanoidRootPart.CFrame = humanoidRootPart.CFrame + moveDirection * n * deltaTime
                            end
                        end
                    end
                end
            end
        end

        if _G.Ox.Moonwalk.Enabled then
            local character = localPlayer.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
            local humanoid = character and character:FindFirstChildOfClass("Humanoid")
            local currentCamera2 = workspace.CurrentCamera

            if humanoidRootPart and humanoid and currentCamera2 then
                if humanoid.AutoRotate ~= false then
                    humanoid.AutoRotate = false
                end

                local vector = Vector3.new(currentCamera2.CFrame.LookVector.X, 0, currentCamera2.CFrame.LookVector.Z)
                local unit = vector
                local vector2 = Vector3.new(currentCamera2.CFrame.RightVector.X, 0, currentCamera2.CFrame.RightVector.Z)
                local unit2 = vector2

                if vector.Magnitude > 0.001 then
                    unit = vector.Unit
                end

                if vector2.Magnitude > 0.001 then
                    unit2 = vector2.Unit
                end

                local v5 = math.sin(tick() * 35)
                local n = CFrame.Angles(0, math.rad(30 * v5), 0) * unit
                humanoidRootPart.CFrame = CFrame.lookAt(humanoidRootPart.Position, humanoidRootPart.Position + n)
                humanoid:Move(-unit * 1.2 + unit2 * (v5 * 1.05), false)
            end
        end

        if _G.Ox.StretchRes.Enabled and currentCamera then
            currentCamera.CFrame = currentCamera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, _G.Ox.StretchRes.Amount, 0, 0, 0, 1)
        end

        if flag and _G.Ox.AimConfig.Flash_Silent then
            local v5 = getKillerTargetForFlash()

            if v5 then
                local character = localPlayer.Character
                local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                local n = v5.Position + Vector3.new(0, _G.Ox.AimConfig.Flash_YOffset, 0)
                local currentCamera2 = workspace.CurrentCamera
                currentCamera2.CFrame = currentCamera2.CFrame:Lerp(CFrame.lookAt(currentCamera2.CFrame.Position, n), 0.5)

                if humanoidRootPart then
                    local cframe = CFrame.lookAt(humanoidRootPart.Position, Vector3.new(n.X, humanoidRootPart.Position.Y, n.Z))
                    humanoidRootPart.CFrame = humanoidRootPart.CFrame:Lerp(cframe, 0.5)
                end
            end
        end

        if _G.Ox.Config.Surv_Aimbot_Enabled then
            if GetRole() == "Survivor" then
                if _G.Ox.Config.Surv_Aimbot_ShowFOV then
                    _G.Ox.SurvivorFOVFrame.Visible = true
                    _G.Ox.SurvivorFOVFrame.Size = UDim2.new(0, _G.Ox.Config.Surv_Aimbot_Radius * 2, 0, _G.Ox.Config.Surv_Aimbot_Radius * 2)
                else
                    _G.Ox.SurvivorFOVFrame.Visible = false
                end

                local v5 = getBestAimbotTarget()

                if v5 then
                    _G.Ox.survivorAimbotHighlight.Parent = v5.Parent
                    local position = v5.Position
                    local n = position
                    local v6 = GetDistance(position)

                    if v6 < 100 then
                        n = position + currentCamera.CFrame.RightVector * ((100 - v6) * _G.Ox.Config.Surv_Aimbot_Predict)
                    end

                    local cframe = CFrame.new(currentCamera.CFrame.Position, n)
                    currentCamera.CFrame = currentCamera.CFrame:Lerp(cframe, _G.Ox.Config.Surv_Aimbot_Smoothness)
                    local character = localPlayer.Character
                    local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

                    if humanoidRootPart then
                        local cframe2 = CFrame.new(humanoidRootPart.Position, Vector3.new(n.X, humanoidRootPart.Position.Y, n.Z))
                        humanoidRootPart.CFrame = humanoidRootPart.CFrame:Lerp(cframe2, _G.Ox.Config.Surv_Aimbot_Smoothness)
                    end
                else
                    _G.Ox.survivorAimbotHighlight.Parent = nil
                end
            end
        else
            _G.Ox.SurvivorFOVFrame.Visible = false
            _G.Ox.survivorAimbotHighlight.Parent = nil
        end

        if _G.Ox.Config.Killer_Aimbot_Enabled and _G.Ox.isKillerAimbotHolding then
            if GetRole() == "Killer" then
                if _G.Ox.lockedKillerAimbotTarget then
                    local parent = _G.Ox.lockedKillerAimbotTarget.Parent
                    local humanoid = parent and parent:FindFirstChild("Humanoid")

                    if not humanoid or humanoid.Health <= 0 or IsDowned(parent) then
                        _G.Ox.lockedKillerAimbotTarget = getBestKillerAimbotTarget()
                    end

                    if _G.Ox.lockedKillerAimbotTarget then
                        local position = _G.Ox.lockedKillerAimbotTarget.Position
                        local v5 = GetDistance(position)

                        if _G.Ox.Config.Killer_Aimbot_MaxDist < v5 then
                            _G.Ox.lockedKillerAimbotTarget = getBestKillerAimbotTarget()
                        else
                            _G.Ox.killerAimbotHighlight.Parent = parent
                            local cframe = CFrame.new(currentCamera.CFrame.Position, position)
                            currentCamera.CFrame = currentCamera.CFrame:Lerp(cframe, _G.Ox.Config.Killer_Aimbot_Smoothness)
                            local character = localPlayer.Character
                            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

                            if humanoidRootPart then
                                local cframe2 = CFrame.new(humanoidRootPart.Position, Vector3.new(position.X, humanoidRootPart.Position.Y, position.Z))
                                humanoidRootPart.CFrame = humanoidRootPart.CFrame:Lerp(cframe2, _G.Ox.Config.Killer_Aimbot_Smoothness)
                            end
                        end
                    end
                else
                    _G.Ox.lockedKillerAimbotTarget = getBestKillerAimbotTarget()
                end
            end
        elseif _G.Ox.killerAimbotHighlight then
            _G.Ox.killerAimbotHighlight.Parent = nil
        end

        local character = localPlayer.Character
        local flag3 = character and character:GetAttribute("spearmode") == true
        local aimSilentVeilV2 = _G.Ox.AimConfig.Aim_SilentVeilV2
        local v5 = aimSilentVeilV2 and flag3
        local veilShowFOV = v5 and _G.Ox.AimConfig.Veil_ShowFOV

        if veilShowFOV then
            frame.Visible = true
            frame.Size = UDim2.new(0, _G.Ox.AimConfig.Veil_FOV * 2, 0, _G.Ox.AimConfig.Veil_FOV * 2)
        else
            frame.Visible = false
        end

        if veilShowFOV then
            local v6 = getClosestSurvivor()

            if v6 and v6.Parent then
                highlight.Parent = v6.Parent
                local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")
                local v7 = character

                if character then
                    local head = character:FindFirstChild("Head")
                    v7 = head or humanoidRootPart
                end

                local position = v7 and v7.Position
                fn28(position, v6.Position)
            else
                highlight.Parent = nil
                fn28(nil, nil)
            end
        else
            highlight.Parent = nil
            fn28(nil, nil)

            if not v5 then
                fn27()
            end
        end
    end)

    local n = 0

    RunService.Heartbeat:Connect(function()
        if _G.Ox.ParryConfig.ParryCircle and _G.Ox.ParryConfig.AutoParry then
            local character = localPlayer.Character
            local humanoidRootPart = character and character:FindFirstChild("HumanoidRootPart")

            if humanoidRootPart then
                if not _G.Ox.State.AutoParryAdornment or _G.Ox.State.AutoParryAdornment.Parent ~= humanoidRootPart then
                    if _G.Ox.State.AutoParryAdornment then
                        _G.Ox.State.AutoParryAdornment:Destroy()
                    end

                    _G.Ox.State.AutoParryAdornment = Instance.new("CylinderHandleAdornment")
                    _G.Ox.State.AutoParryAdornment.Name = "AutoParryCircleESP"
                    _G.Ox.State.AutoParryAdornment.Height = 0.05
                    _G.Ox.State.AutoParryAdornment.Transparency = 0.3
                    _G.Ox.State.AutoParryAdornment.Adornee = humanoidRootPart
                    _G.Ox.State.AutoParryAdornment.Parent = humanoidRootPart
                    _G.Ox.State.AutoParryAdornment.ZIndex = 0
                    _G.Ox.State.AutoParryAdornment.AlwaysOnTop = false
                end

                local parryRadius = _G.Ox.ParryConfig.ParryRadius
                _G.Ox.State.AutoParryAdornment.Radius = parryRadius
                _G.Ox.State.AutoParryAdornment.InnerRadius = math.max(0.1, parryRadius - 0.15)
                _G.Ox.State.AutoParryAdornment.CFrame = CFrame.new(0, -3, 0) * CFrame.Angles(math.rad(90), 0, 0)

                if _G.Ox.State.ParryCooldown then
                    _G.Ox.State.AutoParryAdornment.Color3 = Color3.fromRGB(255, 128, 0)
                elseif _G.Ox.ParryConfig.ParryAggressive then
                    _G.Ox.State.AutoParryAdornment.Color3 = Color3.fromRGB(255, 0, 0)
                else
                    _G.Ox.State.AutoParryAdornment.Color3 = Color3.fromRGB(255, 255, 255)
                end
            elseif _G.Ox.State.AutoParryAdornment then
                _G.Ox.State.AutoParryAdornment:Destroy()
                _G.Ox.State.AutoParryAdornment = nil
            end
        elseif _G.Ox.State.AutoParryAdornment then
            _G.Ox.State.AutoParryAdornment:Destroy()
            _G.Ox.State.AutoParryAdornment = nil
        end

        if _G.Ox.GodMode then
            local character = localPlayer.Character

            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")

                if humanoid and humanoid.Health < humanoid.MaxHealth then
                    humanoid.Health = humanoid.MaxHealth
                end
            end
        end

        if _G.Ox.AutoPallet.Enabled then
            for k in pairs(_G.Ox.AutoPallet.UsedPallets) do
                if not k or not k.Parent then
                    _G.Ox.AutoPallet.UsedPallets[k] = nil
                end
            end
        end

        if _G.Ox.CameraFOV.Enabled then
            currentCamera.FieldOfView = _G.Ox.CameraFOV.Value
        end

        if _G.Ox.NoSlowdownEnabled then
            local character = localPlayer.Character

            if character then
                local humanoid = character:FindFirstChildOfClass("Humanoid")

                if humanoid and GetRole() == "Killer" and humanoid.WalkSpeed < 16 then
                    humanoid.WalkSpeed = 16
                end
            end
        end

        if _G.Ox.ESPConfig.Master and tick() - n >= 2 then
            n = tick()
            UpdatePlayerESP()
            UpdateSCPESP()
            UpdateStaticESP()
        end
    end)

    local items = ReplicatedStorage:WaitForChild("Items", 5)

    extractAssetId = function(arg)
        return tostring(arg):match("%d+")
    end

    getItemIcon = function(arg)
        if not items then
            return nil
        end
        local v5 = items:FindFirstChild(arg)
        if not v5 then
            return nil
        end
        local v6 = nil

        pcall(function()
            local texture = v5.Texture
            local image = texture or v5.Image
            v6 = image
        end)

        if v6 and v6 ~= "" then
            local v7 = extractAssetId(v6)
            if v7 then
                return string.format("rbxthumb://type=Asset&id=%s&w=420&h=420", v7)
            end
        end

        return nil
end
   
