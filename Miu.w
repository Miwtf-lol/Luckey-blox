--// MIU HUB - Auto x2 Buff + Key System
--// Mobile + PC

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- REMOTE
local BuffRemote =
ReplicatedStorage.Shared.Packages.Network.rev_TaviMishkal

-- KEY
local CorrectKey = "MIUHUB123"

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
KeyFrame.Size = UDim2.new(0,260,0,170)
KeyFrame.Position = UDim2.new(0.35,0,0.3,0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(255,105,180)
KeyFrame.Active = true
KeyFrame.Draggable = true

Instance.new("UICorner", KeyFrame).CornerRadius = UDim.new(0,18)

local KeyTitle = Instance.new("TextLabel")
KeyTitle.Parent = KeyFrame
KeyTitle.Size = UDim2.new(1,0,0,40)
KeyTitle.BackgroundTransparency = 1
KeyTitle.Text = "MIU HUB KEY"
KeyTitle.Font = Enum.Font.GothamBold
KeyTitle.TextSize = 24
KeyTitle.TextColor3 = Color3.new(1,1,1)

local KeyBox = Instance.new("TextBox")
KeyBox.Parent = KeyFrame
KeyBox.Size = UDim2.new(0.8,0,0,40)
KeyBox.Position = UDim2.new(0.1,0,0.35,0)
KeyBox.PlaceholderText = "Enter Key..."
KeyBox.Text = ""
KeyBox.TextSize = 18
KeyBox.BackgroundColor3 = Color3.fromRGB(255,130,200)
KeyBox.TextColor3 = Color3.new(1,1,1)

Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0,14)

local CheckButton = Instance.new("TextButton")
CheckButton.Parent = KeyFrame
CheckButton.Size = UDim2.new(0.8,0,0,40)
CheckButton.Position = UDim2.new(0.1,0,0.67,0)
CheckButton.Text = "CHECK KEY"
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
-- FUNCTIONS
------------------------------------------------

CheckButton.MouseButton1Click:Connect(function()

	if KeyBox.Text == CorrectKey then

		KeyFrame.Visible = false
		Main.Visible = true

	else

		CheckButton.Text = "WRONG KEY"

		task.wait(1)

		CheckButton.Text = "CHECK KEY"
	end
end)

Minimize.MouseButton1Click:Connect(function()

	Main.Visible = false
	Mini.Visible = true
end)

Mini.MouseButton1Click:Connect(function()

	Main.Visible = true
	Mini.Visible = false
end)

Toggle.MouseButton1Click:Connect(function()

	AutoX2Buff = not AutoX2Buff

	if AutoX2Buff then

		Toggle.Text = "AUTO x2 : ON"
		Toggle.BackgroundColor3 =
			Color3.fromRGB(255,80,170)

	else

		Toggle.Text = "AUTO x2 : OFF"
		Toggle.BackgroundColor3 =
			Color3.fromRGB(255,130,200)
	end
end)

------------------------------------------------
-- AUTO x2
------------------------------------------------

task.spawn(function()

	while task.wait(2) do

		if AutoX2Buff then

			local Character =
				LocalPlayer.Character

			if Character then

				local Tool =
					Character:FindFirstChildOfClass("Tool")

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
print("KEY:", CorrectKey)
