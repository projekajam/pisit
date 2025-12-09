-- Fish It DRAGGABLE MENU by projekajam
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

print("🎣 Fish It DRAGGABLE LOADED!")

-- ScreenGui
local sg = Instance.new("ScreenGui")
sg.Name = "FishItMenu"
sg.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
sg.Parent = player:WaitForChild("PlayerGui")

-- Circle Button (Draggable + Clickable)
local circleBtn = Instance.new("ImageButton")
circleBtn.Name = "CircleBtn"
circleBtn.Parent = sg
circleBtn.Size = UDim2.new(0, 70, 0, 70)
circleBtn.Position = UDim2.new(0, 20, 0, 20)
circleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
circleBtn.ZIndex = 10
circleBtn.ImageTransparency = 1

local circleCorner = Instance.new("UICorner")
circleCorner.CornerRadius = UDim.new(0.5, 0)
circleCorner.Parent = circleBtn

local circleText = Instance.new("TextLabel")
circleText.Parent = circleBtn
circleText.Size = UDim2.new(1, 0, 1, 0)
circleText.BackgroundTransparency = 1
circleText.Text = "🎣"
circleText.TextColor3 = Color3.new(1,1,1)
circleText.TextScaled = true
circleText.Font = Enum.Font.GothamBold
circleText.ZIndex = 11

-- Main Menu (Draggable)
local menu = Instance.new("Frame")
menu.Name = "MainMenu"
menu.Parent = sg
menu.Size = UDim2.new(0, 280, 0, 350)
menu.Position = UDim2.new(0, 100, 0, 20)
menu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
menu.ZIndex = 5
menu.Visible = false

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 15)
menuCorner.Parent = menu

local menuStroke = Instance.new("UIStroke")
menuStroke.Color = Color3.fromRGB(60, 60, 60)
menuStroke.Thickness = 2
menuStroke.Parent = menu

-- Title Bar (Drag handle)
local titleBar = Instance.new("Frame")
titleBar.Parent = menu
titleBar.Size = UDim2.new(1, 0, 0, 50)
titleBar.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
titleBar.ZIndex = 6

local titleText = Instance.new("TextLabel")
titleText.Parent = titleBar
titleText.Size = UDim2.new(1, -60, 1, 0)
titleText.Position = UDim2.new(0, 15, 0, 0)
titleText.BackgroundTransparency = 1
titleText.Text = "Fish It by projekajam"
titleText.TextColor3 = Color3.new(1,1,1)
titleText.TextScaled = true
titleText.Font = Enum.Font.GothamBold
titleText.ZIndex = 7

local closeBtn = Instance.new("TextButton")
closeBtn.Parent = titleBar
closeBtn.Size = UDim2.new(0, 40, 0, 40)
closeBtn.Position = UDim2.new(1, -50, 0, 5)
closeBtn.Text = "✕"
closeBtn.BackgroundTransparency = 1
closeBtn.TextColor3 = Color3.new(1,0.5,0.5)
closeBtn.TextScaled = true
closeBtn.ZIndex = 7

-- DRAG FUNCTION
local dragging = false
local dragStart = nil
local startPos = nil

local function updateInput(input)
    local delta = input.Position - dragStart
    local newPos = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    menu.Position = newPos
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = menu.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updateInput(input)
    end
end)

-- Toggle Menu
circleBtn.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
    circleBtn.BackgroundColor3 = menu.Visible and Color3.fromRGB(0, 255, 0) or Color3.fromRGB(255, 50, 50)
    print("Menu toggled:", menu.Visible)
end)

-- Close Button
closeBtn.MouseButton1Click:Connect(function()
    menu.Visible = false
    circleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
end)

-- Test Button
local testBtn = Instance.new("TextButton")
testBtn.Parent = menu
testBtn.Size = UDim2.new(0.9, 0, 0, 50)
testBtn.Position = UDim2.new(0.05, 0, 0, 70)
testBtn.Text = "TEST FARM (Spam All Remotes)"
testBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 0)
testBtn.TextColor3 = Color3.new(1,1,1)
testBtn.TextScaled = true
testBtn.Font = Enum.Font.GothamBold
testBtn.ZIndex = 6

local testCorner = Instance.new("UICorner")
testCorner.CornerRadius = UDim.new(0, 10)
testCorner.Parent = testBtn

testBtn.MouseButton1Click:Connect(function()
    print("🚀 SPAMMING ALL REMOTES...")
    for i = 1, 10 do
        for _, obj in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                pcall(function() obj:FireServer() end)
            end
        end
        wait(0.1)
    end
    print("✅ Test complete!")
end)

print("✅ DRAGGABLE MENU LOADED! Drag title bar, klik circle 🎣")
