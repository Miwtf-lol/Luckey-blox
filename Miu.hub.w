-- VM HUB - Bản mô phỏng UI (Chỉ hiển thị giao diện)
-- Dành cho mục đích kiểm thử

pcall(function() script.Parent = nil end)

local player = game:GetService("Players").LocalPlayer
local userId = player.UserId
local zaloNumber = "0974516980"

-- Hàm kiểm tra file (mô phỏng)
local function isDeviceBanned()
    local s, d = pcall(function() return readfile("VM_HUB_BAN_" .. userId .. ".json") end)
    if s and d and #d > 0 then
        local decoded = game:GetService("HttpService"):JSONDecode(d)
        if decoded and decoded.banned == true then return true end
    end
    return false
end

local function writeDeviceBan()
    local data = {
        banned = true, userId = userId, username = player.Name,
        banTime = os.time(), banDate = os.date("%Y-%m-%d %H:%M:%S"),
        banId = "VM-PERM-" .. os.date("%Y%m%d") .. "-" .. math.random(10000, 99999),
        unbanContact = zaloNumber
    }
    local json = game:GetService("HttpService"):JSONEncode(data)
    pcall(function() writefile("VM_HUB_BAN_" .. userId .. ".json", json) end)
    pcall(function() writefile("VM_HUB_BAN_BACKUP_" .. userId .. ".txt", json) end)
end

-- Hàm hiển thị màn hình ban
local function showBanScreen()
    pcall(function()
        for _, v in pairs(player.PlayerGui:GetChildren()) do v:Destroy() end
    end)
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "VMBanGUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")
    gui.DisplayOrder = 99999
    gui.IgnoreGuiInset = true
    
    local bg = Instance.new("Frame")
    bg.Size = UDim2.new(1, 0, 1, 0)
    bg.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    bg.BackgroundTransparency = 0.5
    bg.BorderSizePixel = 0
    bg.ZIndex = 99999
    bg.Parent = gui
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 420, 0, 420)
    frame.Position = UDim2.new(0.5, -210, 0.5, -210)
    frame.BackgroundColor3 = Color3.fromRGB(15, 5, 5)
    frame.BackgroundTransparency = 0.05
    frame.BorderSizePixel = 0
    frame.ZIndex = 100000
    frame.Parent = gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 15)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(255, 0, 0)
    stroke.Thickness = 4
    stroke.ZIndex = 100000
    stroke.Parent = frame
    
    -- Icon
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(1, 0, 0, 50)
    icon.Position = UDim2.new(0, 0, 0, 10)
    icon.BackgroundTransparency = 1
    icon.Text = "💀"
    icon.TextColor3 = Color3.fromRGB(255, 0, 0)
    icon.TextSize = 45
    icon.Font = Enum.Font.GothamBold
    icon.ZIndex = 100000
    icon.Parent = frame
    
    -- Title VM HUB
    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35)
    title.Position = UDim2.new(0, 0, 0, 60)
    title.BackgroundTransparency = 1
    title.Text = "VM HUB"
    title.TextColor3 = Color3.fromRGB(255, 50, 50)
    title.TextSize = 28
    title.Font = Enum.Font.GothamBlack
    title.ZIndex = 100000
    title.Parent = frame
    
    -- Ban text
    local banText = Instance.new("TextLabel")
    banText.Size = UDim2.new(1, 0, 0, 30)
    banText.Position = UDim2.new(0, 0, 0, 95)
    banText.BackgroundTransparency = 1
    banText.Text = "🚫 BẠN ĐÃ BỊ CẤM VĨNH VIỄN"
    banText.TextColor3 = Color3.fromRGB(255, 30, 30)
    banText.TextSize = 20
    banText.Font = Enum.Font.GothamBlack
    banText.ZIndex = 100000
    banText.Parent = frame
    
    local permLabel = Instance.new("TextLabel")
    permLabel.Size = UDim2.new(1, 0, 0, 25)
    permLabel.Position = UDim2.new(0, 0, 0, 125)
    permLabel.BackgroundTransparency = 1
    permLabel.Text = "⛔ PERMANENT BAN ⛔"
    permLabel.TextColor3 = Color3.fromRGB(255, 200, 0)
    permLabel.TextSize = 14
    permLabel.Font = Enum.Font.GothamBold
    permLabel.ZIndex = 100000
    permLabel.Parent = frame
    
    local banId = "VM-PERM-" .. os.date("%Y%m%d") .. "-" .. math.random(10000, 99999)
    local idLabel = Instance.new("TextLabel")
    idLabel.Size = UDim2.new(1, -40, 0, 22)
    idLabel.Position = UDim2.new(0, 20, 0, 152)
    idLabel.BackgroundTransparency = 1
    idLabel.Text = "Mã: " .. banId
    idLabel.TextColor3 = Color3.fromRGB(255, 100, 100)
    idLabel.TextSize = 13
    idLabel.Font = Enum.Font.Gotham
    idLabel.ZIndex = 100000
    idLabel.Parent = frame
    
    local reasonLabel = Instance.new("TextLabel")
    reasonLabel.Size = UDim2.new(1, -40, 0, 40)
    reasonLabel.Position = UDim2.new(0, 20, 0, 175)
    reasonLabel.BackgroundTransparency = 1
    reasonLabel.Text = "Lý do: Phát hiện hành vi gian lận (VM Hub)\nThiết bị và tài khoản đã bị khóa vĩnh viễn"
    reasonLabel.TextColor3 = Color3.fromRGB(255, 150, 150)
    reasonLabel.TextSize = 12
    reasonLabel.Font = Enum.Font.Gotham
    reasonLabel.TextWrapped = true
    reasonLabel.TextXAlignment = Enum.TextXAlignment.Center
    reasonLabel.ZIndex = 100000
    reasonLabel.Parent = frame
    
    -- Khung Zalo
    local zf = Instance.new("Frame")
    zf.Size = UDim2.new(1, -60, 0, 70)
    zf.Position = UDim2.new(0, 30, 0, 225)
    zf.BackgroundColor3 = Color3.fromRGB(0, 100, 50)
    zf.BackgroundTransparency = 0.3
    zf.BorderSizePixel = 0
    zf.ZIndex = 100000
    zf.Parent = frame
    
    local zc = Instance.new("UICorner")
    zc.CornerRadius = UDim.new(0, 8)
    zc.Parent = zf
    
    local zi = Instance.new("TextLabel")
    zi.Size = UDim2.new(0, 30, 1, 0)
    zi.Position = UDim2.new(0, 5, 0, 0)
    zi.BackgroundTransparency = 1
    zi.Text = "💬"
    zi.TextColor3 = Color3.fromRGB(255, 255, 255)
    zi.TextSize = 20
    zi.Font = Enum.Font.Gotham
    zi.ZIndex = 100001
    zi.Parent = zf
    
    local zt = Instance.new("TextLabel")
    zt.Size = UDim2.new(1, -40, 0, 22)
    zt.Position = UDim2.new(0, 38, 0, 5)
    zt.BackgroundTransparency = 1
    zt.Text = "LIÊN HỆ MỞ BAN"
    zt.TextColor3 = Color3.fromRGB(255, 255, 255)
    zt.TextSize = 14
    zt.Font = Enum.Font.GothamBold
    zt.TextXAlignment = Enum.TextXAlignment.Left
    zt.ZIndex = 100001
    zt.Parent = zf
    
    local zn = Instance.new("TextLabel")
    zn.Size = UDim2.new(1, -40, 0, 25)
    zn.Position = UDim2.new(0, 38, 0, 28)
    zn.BackgroundTransparency = 1
    zn.Text = "Zalo: " .. zaloNumber
    zn.TextColor3 = Color3.fromRGB(255, 255, 100)
    zn.TextSize = 18
    zn.Font = Enum.Font.GothamBlack
    zn.TextXAlignment = Enum.TextXAlignment.Left
    zn.ZIndex = 100001
    zn.Parent = zf
    
    -- Nút copy
    local copyBtn = Instance.new("TextButton")
    copyBtn.Size = UDim2.new(0, 180, 0, 32)
    copyBtn.Position = UDim2.new(0.5, -90, 0, 308)
    copyBtn.BackgroundColor3 = Color3.fromRGB(0, 150, 80)
    copyBtn.Text = "📋 SAO CHÉP SỐ ZALO"
    copyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    copyBtn.TextSize = 12
    copyBtn.Font = Enum.Font.GothamBold
    copyBtn.ZIndex = 100000
    copyBtn.Parent = frame
    
    local cc = Instance.new("UICorner")
    cc.CornerRadius = UDim.new(0, 6)
    cc.Parent = copyBtn
    
    copyBtn.MouseButton1Click:Connect(function()
        pcall(function() setclipboard(zaloNumber) end)
        copyBtn.Text = "✅ ĐÃ SAO CHÉP!"
        task.delay(2, function()
            if copyBtn and copyBtn.Parent then copyBtn.Text = "📋 SAO CHÉP SỐ ZALO" end
        end)
    end)
    
    -- Nút thoát
    local exitBtn = Instance.new("TextButton")
    exitBtn.Size = UDim2.new(0, 180, 0, 42)
    exitBtn.Position = UDim2.new(0.5, -90, 0, 350)
    exitBtn.BackgroundColor3 = Color3.fromRGB(180, 0, 0)
    exitBtn.Text = "THOÁT GAME"
    exitBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
    exitBtn.TextSize = 16
    exitBtn.Font = Enum.Font.GothamBold
    exitBtn.ZIndex = 100000
    exitBtn.Parent = frame
    
    local ec = Instance.new("UICorner")
    ec.CornerRadius = UDim.new(0, 10)
    ec.Parent = exitBtn
    
    exitBtn.MouseButton1Click:Connect(function() game:Shutdown() end)
    task.delay(30, function() if gui then gui:Destroy() end game:Shutdown() end)
end

-- Main
if isDeviceBanned() then
    showBanScreen()
else
    -- Hiển thị "đang cập nhật" 3s
    local gui = Instance.new("ScreenGui")
    gui.Name = "VMHubGUI"
    gui.ResetOnSpawn = false
    gui.Parent = player:WaitForChild("PlayerGui")
    
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 350, 0, 200)
    frame.Position = UDim2.new(0.5, -175, 0.5, -100)
    frame.BackgroundColor3 = Color3.fromRGB(20, 20, 40)
    frame.BackgroundTransparency = 0.1
    frame.BorderSizePixel = 0
    frame.Parent = gui
    
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame
    
    local stroke = Instance.new("UIStroke")
    stroke.Color = Color3.fromRGB(233, 69, 96)
    stroke.Thickness = 2
    stroke.Parent = frame
    
    local wi = Instance.new("TextLabel")
    wi.Size = UDim2.new(1, 0, 0, 40)
    wi.Position = UDim2.new(0, 0, 0, 12)
    wi.BackgroundTransparency = 1
    wi.Text = "⚠️"
    wi.TextColor3 = Color3.fromRGB(233, 69, 96)
    wi.TextSize = 30
    wi.Font = Enum.Font.GothamBold
    wi.Parent = frame
    
    local tl = Instance.new("TextLabel")
    tl.Size = UDim2.new(1, 0, 0, 30)
    tl.Position = UDim2.new(0, 0, 0, 52)
    tl.BackgroundTransparency = 1
    tl.Text = "VM HUB"
    tl.TextColor3 = Color3.fromRGB(233, 69, 96)
    tl.TextSize = 22
    tl.Font = Enum.Font.GothamBold
    tl.Parent = frame
    
    local ul = Instance.new("TextLabel")
    ul.Size = UDim2.new(1, 0, 0, 25)
    ul.Position = UDim2.new(0, 0, 0, 82)
    ul.BackgroundTransparency = 1
    ul.Text = "Đang cập nhật hệ thống..."
    ul.TextColor3 = Color3.fromRGB(180, 180, 200)
    ul.TextSize = 16
    ul.Font = Enum.Font.Gotham
    ul.Parent = frame
    
    local sp = Instance.new("Frame")
    sp.Size = UDim2.new(0, 30, 0, 30)
    sp.Position = UDim2.new(0.5, -15, 0, 115)
    sp.BackgroundTransparency = 1
    sp.BorderSizePixel = 0
    sp.Parent = frame
    
    local spc = Instance.new("UICorner")
    spc.CornerRadius = UDim.new(1, 0)
    spc.Parent = sp
    
    local sps = Instance.new("UIStroke")
    sps.Color = Color3.fromRGB(233, 69, 96)
    sps.Thickness = 3
    sps.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    sps.Parent = sp
    
    sp.Rotation = 0
    coroutine.wrap(function()
        while sp and sp.Parent do sp.Rotation = sp.Rotation + 5 task.wait(0.03) end
    end)()
    
    local cl = Instance.new("TextLabel")
    cl.Size = UDim2.new(1, 0, 0, 20)
    cl.Position = UDim2.new(0, 0, 0, 155)
    cl.BackgroundTransparency = 1
    cl.TextColor3 = Color3.fromRGB(150, 150, 150)
    cl.TextSize = 13
    cl.Font = Enum.Font.GothamLight
    cl.Parent = frame
    
    for i = 3, 1, -1 do
        cl.Text = "Tự động kiểm tra sau " .. i .. " giây"
        task.wait(1)
    end
    
    if gui then gui:Destroy() end
    writeDeviceBan()
    showBanScreen()
end
