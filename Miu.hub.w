--// Kick A Lucky Block GUI
--// Mobile + PC

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local LocalPlayer = Players.LocalPlayer

-- REMOTES
local CollectRemote =
ReplicatedStorage.Shared.Packages.Network.rev_B_Collect

local KickRemote =
ReplicatedStorage.Shared.Packages.Network.rev_KickEvent

local RebirthRemote =
ReplicatedStorage.Shared.Packages.Network.rev_RebirthRequest

local BuffRemote =
ReplicatedStorage.Shared.Packages.Network.rev_TaviMishkal

-- SETTINGS
local Settings = {
	PerfectKick = false,
	CollectCash = false,
	AutoRebirth = false,
	AutoFlyToBlock = false,
	AutoX2Buff = false,
}

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LuckyBlockGUI"
ScreenGui.Parent = game.CoreGui

local Main = Instance.new("Frame")
Main.Parent = ScreenGui
Main.Size = UDim2.new(0,300,0,500)
Main.Position = UDim2.new(0.3,0,0.2,0)
Main.BackgroundColor3 = Color3.fromRGB(10,10,10)
Main.BorderSizePixel = 0
Main.Active = true
Main.Draggable = true

Instance.new("UICorner", Main)

local Title = Instance.new("TextLabel")
Title.Parent = Main
Title.Size = UDim2.new(1,0,0,50)
Title.BackgroundTransparency = 1
Title.Text = "KICK A LUCKY BLOCK"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 28
Title.TextColor3 = Color3.new(1,1,1)

-- MOBILE DRAG
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
	local delta = input.Position - dragStart

	Main.Position = UDim2.new(
		startPos.X.Scale,
		startPos.X.Offset + delta.X,
		startPos.Y.Scale,
		startPos.Y.Offset + delta.Y
	)
end

Main.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
	or input.UserInputType == Enum.UserInputType.MouseButton1 then

		dragging = true
		dragStart = input.Position
		startPos = Main.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

Main.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch
	or input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- TOGGLE
local function CreateToggle(Name, PositionY, Callback)

	local Text = Instance.new("TextLabel")
	Text.Parent = Main
	Text.Size = UDim2.new(0.7,0,0,45)
	Text.Position = UDim2.new(0.05,0,0,PositionY)
	Text.BackgroundTransparency = 1
	Text.Text = Name
	Text.Font = Enum.Font.GothamBold
	Text.TextSize = 22
	Text.TextXAlignment = Enum.TextXAlignment.Left
	Text.TextColor3 = Color3.new(1,1,1)

	local Toggle = Instance.new("TextButton")
	Toggle.Parent = Main
	Toggle.Size = UDim2.new(0,45,0,45)
	Toggle.Position = UDim2.new(0.82,0,0,PositionY)
	Toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
	Toggle.Text = ""

	Instance.new("UICorner", Toggle)

	local Enabled = false

	Toggle.MouseButton1Click:Connect(function()

		Enabled = not Enabled

		if Enabled then
			Toggle.BackgroundColor3 = Color3.fromRGB(0,170,0)
		else
			Toggle.BackgroundColor3 = Color3.fromRGB(40,40,40)
		end

		Callback(Enabled)
	end)
end

CreateToggle("Perfect Kick",60,function(v)
	Settings.PerfectKick = v
end)

CreateToggle("Collect Cash",120,function(v)
	Settings.CollectCash = v
end)

CreateToggle("Auto Rebirth",180,function(v)
	Settings.AutoRebirth = v
end)

CreateToggle("Auto Fly To Block",240,function(v)
	Settings.AutoFlyToBlock = v
end)

CreateToggle("Auto x2 Buff",300,function(v)
	Settings.AutoX2Buff = v
end)

-- FIND BLOCK
local function GetBlock()

	for _, v in pairs(workspace:GetDescendants()) do

		if v:IsA("BasePart") then

			local n = string.lower(v.Name)

			if string.find(n,"block")
			or string.find(n,"lucky") then

				return v
			end
		end
	end
end

-- FLY
local function FlyToBlock(Block)

	local Character = LocalPlayer.Character
	if not Character then return end

	local HRP = Character:FindFirstChild("HumanoidRootPart")
	if not HRP then return end

	local Behind = Block.CFrame.LookVector * -8

	local TargetPos =
		Block.Position
		+ Behind
		+ Vector3.new(0,3,0)

	HRP.CFrame = CFrame.new(TargetPos, Block.Position)
end

-- AUTO KICK
task.spawn(function()

	while task.wait(0.1) do

		if Settings.PerfectKick then

			local Block = GetBlock()

			if Block then

				pcall(function()
					KickRemote:FireServer(Block)
				end)
			end
		end
	end
end)

-- AUTO COLLECT
task.spawn(function()

	while task.wait(0.2) do

		if Settings.CollectCash then

			pcall(function()
				CollectRemote:FireServer()
			end)
		end
	end
end)

-- AUTO REBIRTH
task.spawn(function()

	while task.wait(5) do

		if Settings.AutoRebirth then

			pcall(function()
				RebirthRemote:FireServer()
			end)
		end
	end
end)

-- AUTO FLY
task.spawn(function()

	while task.wait(0.15) do

		if Settings.AutoFlyToBlock then

			local Block = GetBlock()

			if Block then

				pcall(function()
					FlyToBlock(Block)
				end)
			end
		end
	end
end)

-- AUTO X2
task.spawn(function()

	while task.wait(2) do

		if Settings.AutoX2Buff then

			local Character = LocalPlayer.Character

			if Character then

				local Tool =
				Character:FindFirstChildOfClass("Tool")

				-- chỉ spam khi đang cầm tạ
				if Tool then

					pcall(function()
						BuffRemote:FireServer()
					end)
				end
			end
		end
	end
end)

print("Lucky Block GUI Loaded")
