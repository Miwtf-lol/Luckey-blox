--// MIU HUB - Auto x2 Buff + Key System
--// Mobile + PC

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- REMOTE
local BuffRemote = ReplicatedStorage.Shared.Packages.Network.rev_TaviMishkal

-- KEY CONFIG
local CorrectKey = "0d3a507d-3357-42b5-8f91-50dc76392cae"
local KeyLink = "https://link-center.net/3814834/B4mG9jxdJQOV"
local KEY_EXPIRY_HOURS = 24
local KeyStorage = "MIU_HUB_KEY_DATA"

-- SETTINGS
local AutoX2Buff = false

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MIU_HUB"
ScreenGui.Parent = game.CoreGui

------------------------------------------------
-- KEY GUI
------------------------------------------------

local KeyFrame = Instance.new("Frame")
KeyFrame.Parent = ScreenGui
KeyFrame.Size = UDim2.new(0,320,0,240)
KeyFrame.Position = UDim2.new(0.5,-160,0.3,0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(255,105,180)
KeyFrame.Active = true
KeyFrame.Draggable = true

Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0,18)

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Parent = KeyFrame
KeyTitle.Size = UDim2.new(1,0,0,35)
KeyTitle.Position = UDim2.new(0,0,0.02,0)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "🔑 MIU HUB KEY SYSTEM"
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 22
KeyTitle.TextColor3 = Color3.new(1,1,1)

-- Nút GETKEY (sẽ tự động copy link)
local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Parent = KeyFrame
GetKeyButton.Size = UDim2.new(0.8,0,0,35)
GetKeyButton.Position = UDim2.new(0.1,0,0.2,0)
GetKeyButton.Text = "📋 GET KEY"
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.TextSize = 18
GetKeyButton.BackgroundColor3 = Color3.fromRGB(50,200,100)
GetKeyButton.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner", GetKeyButton).CornerRadius = UDim.new(0,14)

-- Label trạng thái
local StatusLabel = Instance.new("TextLabel")
StatusLabel.Parent = KeyFrame
StatusLabel.Size = UDim2.new(0.9,0,0,20)
StatusLabel.Position = UDim2.new(0.05,0,0.38,0)
StatusLabel.BackgroundTransparency = 1
StatusLabel.Text = ""
StatusLabel.Font = Enum.Font.Gotham
StatusLabel.TextSize = 14
StatusLabel.TextColor3 = Color3.fromRGB(255,255,200)

local KeyBox = Instance.new("TextBox")
KeyBox.Parent = KeyFrame
KeyBox.Size = UDim2.new(0.8,0,0,40)
KeyBox.Position = UDim2.new(0.1,0,0.48,0)
KeyBox.PlaceholderText = "Paste Key here..."
KeyBox.Text = ""
KeyBox.TextSize = 18
KeyBox.BackgroundColor3 = Color3.fromRGB(255,130,200)
KeyBox.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0,14)

local CheckButton = Instance.new("TextButton")
CheckButton.Parent = KeyFrame
CheckButton.Size = UDim2.new(0.8,0,0,40)
CheckButton.Position = UDim2.new(0.1,0,0.75,0)
CheckButton.Text = "✅ CHECK KEY"
CheckButton.Font = Enum.Font.GothamBold
CheckButton.TextSize = 20
CheckButton.BackgroundColor3 = Color3.fromRGB(255,130,200)
CheckButton.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner", CheckButton).CornerRadius = UDim.new(0,14)

-- Label thời gian hết hạn
local ExpiryLabel = Instance.new("TextLabel")
ExpiryLabel.Parent = KeyFrame
ExpiryLabel.Size = UDim2.new(1,0,0,18)
ExpiryLabel.Position = UDim2.new(0,0,0.92,0)
ExpiryLabel.BackgroundTransparency = 1
ExpiryLabel.Text = "Key expires in: 24h"
ExpiryLabel.Font = Enum.Font.Gotham
ExpiryLabel.TextSize = 12
ExpiryLabel.TextColor3 = Color3.fromRGB(255,200,200)

------------------------------------------------
-- MAIN GUI
------------------------------------------------

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,240,0,120)
Main.Position = UDim2.new(0.35,0,0.3,0)
Main.BackgroundColor3 = Color3.fromRGB(255,105,180)
Main.BorderSizePixel = 0
Main.Visible = false
Main.Active = true
Main.Draggable = true

Instance.new("UICorner", Main).CornerRadius = UDim.new(0,18)

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,35)
Title.BackgroundTransparency = 1
Title.Text = "MIU HUB"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextColor3 = Color3.new(1,1,1)

-- MINIMIZE BUTTON
local Minimize = Instance.new("TextButton")
Minimize.Parent = Main
Minimize.Size = UDim2.new(0,30,0,30)
Minimize.Position = UDim2.new(1,-35,0,5)
Minimize.BackgroundColor3 = Color3.fromRGB(255,130,200)
Minimize.Text = "-"
Minimize.TextColor3 = Color3.new(1,1,1)
Minimize.Font = Enum.Font.GothamBold
Minimize.TextSize = 22

Instance.new("UICorner", Minimize).CornerRadius = UDim.new(1,0)

-- TOGGLE
local Toggle = Instance.new("TextButton")
Toggle.Parent = Main
Toggle.Size = UDim2.new(0.8,0,0,45)
Toggle.Position = UDim2.new(0.1,0,0.5,0)
Toggle.BackgroundColor3 = Color3.fromRGB(255,130,200)
Toggle.Text = "AUTO x2 : OFF"
Toggle.TextColor3 = Color3.new(1,1,1)
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 20

Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0,14)

-- MINI ICON
local Mini = Instance.new("ImageButton")
Mini.Parent = ScreenGui
Mini.Size = UDim2.new(0,55,0,55)
Mini.Position = UDim2.new(0.05,0,0.4,0)
Mini.BackgroundColor3 = Color3.fromRGB(255,105,180)
Mini.Visible = false
Mini.Active = true
Mini.Draggable = true

Instance.new("UICorner", Mini).CornerRadius = UDim.new(1,0)

-- ẢNH ICON
Mini.Image = "rbxassetid://7072719338"

------------------------------------------------
-- KEY MANAGEMENT FUNCTIONS
------------------------------------------------

-- Lưu key và thời gian
local function SaveKeyData(key)
	local data = {
		Key = key,
		Timestamp = os.time()
	}
	if setclipboard then
		setclipboard(HttpService:JSONEncode(data))
	end
	-- Lưu vào StringValue nếu có thể
	local saved = Instance.new("StringValue")
	saved.Name = KeyStorage
	saved.Value = HttpService:JSONEncode(data)
	saved.Parent = game.CoreGui
end

-- Kiểm tra key còn hạn không
local function IsKeyValid(savedData)
	if not savedData then return false end
	
	local success, decoded = pcall(HttpService.JSONDecode, HttpService, savedData)
	if not success or not decoded.Key or not decoded.Timestamp then return false end
	
	local elapsed = os.time() - decoded.Timestamp
	local expirySeconds = KEY_EXPIRY_HOURS * 60 * 60
	
	if elapsed >= expirySeconds then return false end
	
	-- Key đúng và còn hạn
	return decoded.Key == CorrectKey, decoded
end

-- Cập nhật hiển thị thời gian còn lại
local function UpdateExpiryDisplay(decoded)
	if decoded and decoded.Timestamp then
		local elapsed = os.time() - decoded.Timestamp
		local remaining = (KEY_EXPIRY_HOURS * 60 * 60) - elapsed
		local hours = math.floor(remaining / 3600)
		local minutes = math.floor((remaining % 3600) / 60)
		ExpiryLabel.Text = string.format("⏱ Key expires in: %dh %dm", hours, minutes)
	else
		ExpiryLabel.Text = "⏱ Key expires in: 24h"
	end
end

------------------------------------------------
-- CHECK SAVED KEY ON START
------------------------------------------------

-- Tìm key đã lưu
local savedValue
local savedObj = game.CoreGui:FindFirstChild(KeyStorage)
if savedObj then
	savedValue = savedObj.Value
end

if savedValue then
	local valid, decoded = IsKeyValid(savedValue)
	if valid then
		-- Key còn hạn, bỏ qua key GUI
		KeyFrame.Visible = false
		Main.Visible = true
		UpdateExpiryDisplay(decoded)
		
		-- Tự động cập nhật thời gian mỗi phút
		task.spawn(function()
			while Main.Visible do
				task.wait(60)
				local obj = game.CoreGui:FindFirstChild(KeyStorage)
				if obj then
					local v, d = IsKeyValid(obj.Value)
					if v then
						UpdateExpiryDisplay(d)
					end
				end
			end
		end)
	else
		-- Key hết hạn hoặc sai
		ExpiryLabel.Text = "❌ Key expired or invalid - Get a new one!"
		if decoded then
			UpdateExpiryDisplay(decoded)
		end
	end
end

------------------------------------------------
-- GETKEY BUTTON - Copy link to clipboard
------------------------------------------------

GetKeyButton.MouseButton1Click:Connect(function()
	-- Copy link vào clipboard
	local success = false
	if pcall(function()
		setclipboard(KeyLink)
	end) then
		success = true
	end
	
	if success then
		StatusLabel.Text = "✅ Link copied! Open it to get key"
		GetKeyButton.Text = "✅ COPIED!"
		task.wait(1.5)
		GetKeyButton.Text = "📋 GET KEY"
	else
		StatusLabel.Text = "⚠️ Cannot copy (executor limited)"
		-- Fallback: hiện link để copy tay
		GetKeyButton.Text = KeyLink
	end
end)

------------------------------------------------
-- CHECK KEY BUTTON
------------------------------------------------

CheckButton.MouseButton1Click:Connect(function()
	local inputKey = KeyBox.Text
	
	if inputKey == CorrectKey then
		-- Key đúng -> lưu với timestamp
		local data = {
			Key = inputKey,
			Timestamp = os.time()
		}
		local jsonData = HttpService:JSONEncode(data)
		
		-- Xóa key cũ nếu có
		local old = game.CoreGui:FindFirstChild(KeyStorage)
		if old then old:Destroy() end
		
		local saved = Instance.new("StringValue")
		saved.Name = KeyStorage
		saved.Value = jsonData
		saved.Parent = game.CoreGui
		
		-- Copy vào clipboard nếu được
		pcall(function()
			setclipboard(jsonData)
		end)
		
		KeyFrame.Visible = false
		Main.Visible = true
		UpdateExpiryDisplay(data)
		
		-- Tự động cập nhật thời gian mỗi phút
		task.spawn(function()
			while Main.Visible do
				task.wait(60)
				local obj = game.CoreGui:FindFirstChild(KeyStorage)
				if obj then
					local v, d = IsKeyValid(obj.Value)
					if v then
						UpdateExpiryDisplay(d)
					end
				end
			end
		end)
		
		StatusLabel.Text = ""
	else
		CheckButton.Text = "❌ WRONG KEY"
		StatusLabel.Text = "❌ Invalid key! Get the correct one"
		
		task.wait(1.5)
		
		CheckButton.Text = "✅ CHECK KEY"
	end
end)

------------------------------------------------
-- MINIMIZE / RESTORE
------------------------------------------------

Minimize.MouseButton1Click:Connect(function()
	Main.Visible = false
	Mini.Visible = true
end)

Mini.MouseButton1Click:Connect(function()
	Main.Visible = true
	Mini.Visible = false
end)

------------------------------------------------
-- TOGGLE AUTO X2
------------------------------------------------

Toggle.MouseButton1Click:Connect(function()
	AutoX2Buff = not AutoX2Buff

	if AutoX2Buff then
		Toggle.Text = "AUTO x2 : ON"
		Toggle.BackgroundColor3 = Color3.fromRGB(255,80,170)
	else
		Toggle.Text = "AUTO x2 : OFF"
		Toggle.BackgroundColor3 = Color3.fromRGB(255,130,200)
	end
end)

------------------------------------------------
-- AUTO x2 LOOP
------------------------------------------------

task.spawn(function()
	while task.wait(2) do
		if AutoX2Buff then
			local Character = LocalPlayer.Character
			if Character then
				local Tool = Character:FindFirstChildOfClass("Tool")
				if Tool then
					pcall(function()
						BuffRemote:FireServer()
					end)
				end
			end
		end
	end
end)

print("MIU HUB Loaded")
print("Correct Key:", CorrectKey)
print("Get Key at:", KeyLink)
print("Key expires after:", KEY_EXPIRY_HOURS, "hours")
