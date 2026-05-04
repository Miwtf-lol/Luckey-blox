local player = game.Players.LocalPlayer

-- SETTINGS
getgenv().AutoKick = true
getgenv().AutoCollect = true
getgenv().AutoRebirth = true

-- GUI
local ScreenGui = Instance.new("ScreenGui", game.CoreGui)

local Frame = Instance.new("Frame", ScreenGui)
Frame.Size = UDim2.new(0,260,0,320)
Frame.Position = UDim2.new(0.3,0,0.2,0)
Frame.BackgroundColor3 = Color3.fromRGB(255, 105, 180) -- hồng
Frame.BackgroundTransparency = 0.3 -- trong suốt
Frame.Active = true

-- BO GÓC
local UICorner = Instance.new("UICorner", Frame)
UICorner.CornerRadius = UDim.new(0,15)

-- VIỀN
local UIStroke = Instance.new("UIStroke", Frame)
UIStroke.Color = Color3.fromRGB(255, 182, 193)
UIStroke.Thickness = 2

-- TITLE
local Title = Instance.new("TextLabel", Frame)
Title.Size = UDim2.new(1,0,0,40)
Title.Text = "🌸 miu hub"
Title.TextScaled = true
Title.BackgroundTransparency = 1
Title.TextColor3 = Color3.new(1,1,1)

-- NÚT THU NHỎ
local Minimize = Instance.new("TextButton", Frame)
Minimize.Size = UDim2.new(0,40,0,40)
Minimize.Position = UDim2.new(1,-40,0,0)
Minimize.Text = "-"
Minimize.BackgroundTransparency = 0.5
Minimize.BackgroundColor3 = Color3.fromRGB(255, 182, 193)
Minimize.TextColor3 = Color3.new(1,1,1)

-- ICON
local OpenBtn = Instance.new("TextButton", ScreenGui)
OpenBtn.Size = UDim2.new(0,50,0,50)
OpenBtn.Position = UDim2.new(0,20,0.5,0)
OpenBtn.Text = "🌸"
OpenBtn.Visible = false
OpenBtn.BackgroundColor3 = Color3.fromRGB(255,105,180)
OpenBtn.BackgroundTransparency = 0.3

-- LIST
local Layout = Instance.new("UIListLayout", Frame)
Layout.Padding = UDim.new(0,6)

-- DRAG
local UIS = game:GetService("UserInputService")
local dragging, dragStart, startPos

Frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Frame.Position
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		Frame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X,
			startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

-- TOGGLE
function makeToggle(name, var)
	local btn = Instance.new("TextButton", Frame)
	btn.Size = UDim2.new(1,-10,0,35)
	btn.Text = name .. " : ON"
	btn.BackgroundColor3 = Color3.fromRGB(255,182,193)
	btn.BackgroundTransparency = 0.4
	btn.TextColor3 = Color3.new(1,1,1)

	local corner = Instance.new("UICorner", btn)
	corner.CornerRadius = UDim.new(0,10)

	btn.MouseButton1Click:Connect(function()
		getgenv()[var] = not getgenv()[var]
		btn.Text = name .. " : " .. (getgenv()[var] and "ON" or "OFF")
	end)
end

-- BUTTONS
makeToggle("Perfect Kick", "AutoKick")
makeToggle("Collect Cash", "AutoCollect")
makeToggle("Auto Rebirth", "AutoRebirth")

-- THU NHỎ
Minimize.MouseButton1Click:Connect(function()
	Frame.Visible = false
	OpenBtn.Visible = true
end)

-- MỞ LẠI
OpenBtn.MouseButton1Click:Connect(function()
	Frame.Visible = true
	OpenBtn.Visible = false
end)
