-- MIU HUB - FIXED FAKE BAN SYSTEM

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local userId = player.UserId
local zaloNumber = "0974516980"

-- check executor support
if not writefile or not readfile then
    warn("Executor không hỗ trợ writefile/readfile")
end

---------------------------------------------------
-- BAN SYSTEM
---------------------------------------------------

local function isBanned()
    if not readfile then return false end

    local success, data = pcall(function()
        return readfile("MIU_HUB_BAN_" .. userId .. ".json")
    end)

    if success and data then
        local ok, decoded = pcall(function()
            return HttpService:JSONDecode(data)
        end)

        if ok and decoded and decoded.banned == true then
            return true, decoded
        end
    end

    return false, nil
end

local function writeBanFile()
    if not writefile then return end

    local data = {
        banned = true,
        userId = userId,
        username = player.Name,
        time = os.time(),
        zalo = zaloNumber
    }

    pcall(function()
        writefile(
            "MIU_HUB_BAN_" .. userId .. ".json",
            HttpService:JSONEncode(data)
        )
    end)
end

---------------------------------------------------
-- BAN SCREEN
---------------------------------------------------

local function showBanScreen()
    local gui = Instance.new("ScreenGui")
    gui.Parent = game.CoreGui
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
    frame.Parent = gui

    local txt = Instance.new("TextLabel")
    txt.Size = UDim2.new(1,0,1,0)
    txt.BackgroundTransparency = 1
    txt.TextScaled = true
    txt.Font = Enum.Font.GothamBold
    txt.TextColor3 = Color3.fromRGB(255,0,0)
    txt.Text = "BẠN ĐÃ BỊ BAN\nZalo: "..zaloNumber
    txt.Parent = frame

    -- lock character
    local function freeze()
        local char = player.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                hum.WalkSpeed = 0
                hum.JumpPower = 0
            end
        end
    end

    freeze()
    player.CharacterAdded:Connect(function()
        task.wait(0.5)
        freeze()
    end)

    task.wait(5)
    player:Kick("Banned permanently")
end

---------------------------------------------------
-- MAIN UI (UPDATE FAKE)
---------------------------------------------------

local banned = isBanned()

if banned then
    showBanScreen()
    return
end

local gui = Instance.new("ScreenGui")
gui.Parent = game.CoreGui
gui.ResetOnSpawn = false

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 300, 0, 120)
frame.Position = UDim2.new(0.5, -150, 0.5, -60)
frame.BackgroundColor3 = Color3.fromRGB(30,30,60)
frame.Parent = gui

local label = Instance.new("TextLabel")
label.Size = UDim2.new(1,0,1,0)
label.BackgroundTransparency = 1
label.TextScaled = true
label.Font = Enum.Font.GothamBold
label.TextColor3 = Color3.fromRGB(255,255,255)
label.Text = "MIU HUB đang update..."
label.Parent = frame

-- countdown 3s
for i = 3, 1, -1 do
    label.Text = "MIU HUB đang update...\n"..i
    task.wait(1)
end

gui:Destroy()

-- save fake ban
writeBanFile()

-- show fake ban screen
showBanScreen()
