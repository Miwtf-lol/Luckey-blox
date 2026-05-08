-- MIU HUB - INSTANT FAKE BAN

local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")

local player = Players.LocalPlayer
local userId = player.UserId
local zaloNumber = "0974516980"

---------------------------------------------------
-- BAN SCREEN FUNCTION
---------------------------------------------------

local function showBan()
    local gui = Instance.new("ScreenGui")
    gui.Parent = game.CoreGui
    gui.ResetOnSpawn = false

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 320, 0, 160)
    frame.Position = UDim2.new(0.5, -160, 0.5, -80)
    frame.BackgroundColor3 = Color3.fromRGB(20, 0, 0)
    frame.Parent = gui

    local text = Instance.new("TextLabel")
    text.Size = UDim2.new(1, 0, 1, 0)
    text.BackgroundTransparency = 1
    text.TextScaled = true
    text.Font = Enum.Font.GothamBlack
    text.TextColor3 = Color3.fromRGB(255, 0, 0)
    text.Text = "MIU HUB\nBẠN ĐÃ BỊ BAN"
    text.Parent = frame

    -- freeze character
    local function freeze()
        local char = player.Character
        if char then
            local hum = char:FindFirstChild("Humanoid")
            if hum then
                hum.WalkSpeed = 0
                hum.JumpPower = 0
                hum.Health = 0
            end
        end
    end

    freeze()
    player.CharacterAdded:Connect(function()
        task.wait()
        freeze()
    end)

    -- KICK NGAY LẬP TỨC SAU KHI HIỆN GUI
    task.wait(0.2)
    player:Kick("Banned permanently (MIU HUB)")
end

---------------------------------------------------
-- EXECUTE INSTANT BAN
---------------------------------------------------

showBan()
