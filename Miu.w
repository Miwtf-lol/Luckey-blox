--// MIU HUB - Auto x5 Buff + Key System
--// Mobile + PC

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HttpService = game:GetService("HttpService")

local LocalPlayer = Players.LocalPlayer

-- REMOTE
local BuffRemote = ReplicatedStorage.Shared.Packages.Network.rev_TaviMishkal

-- KEY CONFIG
local CorrectKey = "0d3a507d-3357-42b5-8f91-50dc76392cae"
local CorrectKey = "MIUHUB@"
local KeyLink = "https://link-center.net/3814834/2Ec5lRYpE96o"
local KEY_EXPIRY_HOURS = 24
local KeyStorage = "MIU_HUB_KEY_DATA"

-- SETTINGS
local AutoX5Buff = false

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "MIU_HUB"
pcall(function()
	ScreenGui.Parent = game.CoreGui
end)

------------------------------------------------
-- LOADING GUI
------------------------------------------------

local LoadingBG = Instance.new("Frame")
LoadingBG.Parent = ScreenGui
LoadingBG.Size = UDim2.new(0,350,0,200)
LoadingBG.Position = UDim2.new(0.5,-175,0.5,-100)
LoadingBG.BackgroundColor3 = Color3.fromRGB(255,105,180)
LoadingBG.BorderSizePixel = 0

Instance.new("UICorner", LoadingBG).CornerRadius = UDim.new(0,20)

local LoadingTitle = Instance.new("TextLabel")
LoadingTitle.Parent = LoadingBG
LoadingTitle.Size = UDim2.new(1,0,0,40)
LoadingTitle.Position = UDim2.new(0,0,0.05,0)
LoadingTitle.BackgroundTransparency = 1
LoadingTitle.Text = "🔑 MIU HUB"
LoadingTitle.Font = Enum.Font.GothamBold
LoadingTitle.TextSize = 28
LoadingTitle.TextColor3 = Color3.new(1,1,1)

local LoadingBarBG = Instance.new("Frame")
LoadingBarBG.Parent = LoadingBG
LoadingBarBG.Size = UDim2.new(0.8,0,0,20)
LoadingBarBG.Position = UDim2.new(0.1,0,0.55,0)
LoadingBarBG.BackgroundColor3 = Color3.fromRGB(60,30,50)
LoadingBarBG.BorderSizePixel = 0

Instance.new("UICorner", LoadingBarBG).CornerRadius = UDim.new(0,10)

local LoadingBar = Instance.new("Frame")
LoadingBar.Parent = LoadingBarBG
LoadingBar.Size = UDim2.new(0,0,1,0)
LoadingBar.BackgroundColor3 = Color3.fromRGB(50,220,100)
LoadingBar.BorderSizePixel = 0

Instance.new("UICorner", LoadingBar).CornerRadius = UDim.new(0,10)

local PercentLabel = Instance.new("TextLabel")
PercentLabel.Parent = LoadingBG
PercentLabel.Size = UDim2.new(1,0,0,30)
PercentLabel.Position = UDim2.new(0,0,0.72,0)
PercentLabel.BackgroundTransparency = 1
PercentLabel.Text = "0%"
PercentLabel.Font = Enum.Font.GothamBold
PercentLabel.TextSize = 24
PercentLabel.TextColor3 = Color3.new(1,1,1)

------------------------------------------------
-- LOADING
------------------------------------------------

task.spawn(function()
	for i = 1,100 do
		LoadingBar.Size = UDim2.new(i/100,0,1,0)
		PercentLabel.Text = i.."%"
		task.wait(0.02)
	end
	
	task.wait(0.5)
	LoadingBG:Destroy()
end)

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
KeyFrame.Visible = false

Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0,18)

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Parent = KeyFrame
KeyTitle.Size = UDim2.new(1,0,0,35)
KeyTitle.Position = UDim2.new(0,0,0.02,0)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "🔑 MIU HUB KEY"
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 22
KeyTitle.TextColor3 = Color3.new(1,1,1)

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

------------------------------------------------
-- MAIN GUI
------------------------------------------------

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,240,0,120)
Main.Position = UDim2.new(0.35,0,0.3,0)
Main.BackgroundColor3 = Color3.fromRGB(255,105,180)
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

local Toggle = Instance.new("TextButton")
Toggle.Parent = Main
Toggle.Size = UDim2.new(0.8,0,0,45)
Toggle.Position = UDim2.new(0.1,0,0.5,0)
Toggle.BackgroundColor3 = Color3.fromRGB(255,130,200)
Toggle.Text = "AUTO x5 : OFF"
Toggle.TextColor3 = Color3.new(1,1,1)
Toggle.Font = Enum.Font.GothamBold
Toggle.TextSize = 20

Instance.new("UICorner", Toggle).CornerRadius = UDim.new(0,14)

local Mini = Instance.new("ImageButton")
Mini.Parent = ScreenGui
Mini.Size = UDim2.new(0,55,0,55)
Mini.Position = UDim2.new(0.05,0,0.4,0)
Mini.BackgroundColor3 = Color3.fromRGB(255,105,180)
Mini.Visible = false
Mini.Active = true
Mini.Draggable = true

Instance.new("UICorner", Mini).CornerRadius = UDim.new(1,0)

Mini.Image = "rbxassetid://135283977825181"

------------------------------------------------
-- KEY FUNCTIONS
------------------------------------------------

local function IsKeyValid(savedData)
	if not savedData then
		return false
	end

	local success, decoded = pcall(function()
		return HttpService:JSONDecode(savedData)
	end)

	if not success then
		return false
	end

	local elapsed = os.time() - decoded.Timestamp

	if elapsed >= (KEY_EXPIRY_HOURS * 3600) then
		return false
	end

	return decoded.Key == CorrectKey
end

local function ShowMain()
	KeyFrame.Visible = false
	Main.Visible = true
end

------------------------------------------------
-- GET KEY BUTTON
------------------------------------------------

GetKeyButton.MouseButton1Click:Connect(function()
	local success = false

	pcall(function()
		setclipboard(KeyLink)
		success = true
	end)

	if success then
		StatusLabel.Text = "✅ Link copied!"
		GetKeyButton.Text = "✅ COPIED"

		task.wait(1.5)

		GetKeyButton.Text = "📋 GET KEY"
	else
		StatusLabel.Text = "❌ Clipboard unsupported"
	end
end)

------------------------------------------------
-- CHECK KEY
------------------------------------------------

CheckButton.MouseButton1Click:Connect(function()
	if KeyBox.Text == CorrectKey then
		
		local saveData = {
			Key = CorrectKey,
			Timestamp = os.time()
		}

		local json = HttpService:JSONEncode(saveData)

		local old = game.CoreGui:FindFirstChild(KeyStorage)
		if old then
			old:Destroy()
		end

		local value = Instance.new("StringValue")
		value.Name = KeyStorage
		value.Value = json
		value.Parent = game.CoreGui

		ShowMain()
	else
		StatusLabel.Text = "❌ Wrong Key"

		task.wait(1.5)

		StatusLabel.Text = ""
	end
end)

------------------------------------------------
-- MINIMIZE
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
-- TOGGLE AUTO x5
------------------------------------------------

Toggle.MouseButton1Click:Connect(function()
	AutoX5Buff = not AutoX5Buff

	if AutoX5Buff then
		Toggle.Text = "AUTO x5 : ON"
		Toggle.BackgroundColor3 = Color3.fromRGB(255,80,170)
	else
		Toggle.Text = "AUTO x5 : OFF"
		Toggle.BackgroundColor3 = Color3.fromRGB(255,130,200)
	end
end)

------------------------------------------------
-- AUTO x5 LOOP
------------------------------------------------

task.spawn(function()
	while task.wait(0.01) do
		if AutoX5Buff then
			local Character = LocalPlayer.Character

			if Character then
				local Tool = Character:FindFirstChildOfClass("Tool")

				if Tool then
					pcall(function()
						for i = 1,5 do
							BuffRemote:FireServer()
						end
					end)
				end
			end
		end
	end
end)

------------------------------------------------
-- START
------------------------------------------------

task.wait(3)

local savedObj = game.CoreGui:FindFirstChild(KeyStorage)

if savedObj and IsKeyValid(savedObj.Value) then
	ShowMain()
else
	KeyFrame.Visible = true
end

print("MIU HUB Loaded")
