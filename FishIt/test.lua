-- Fish It Circle Menu by projekajam
local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("🎣 Fish It Circle Menu LOADED!")

-- Main GUI (Circle Button)
local sg = Instance.new("ScreenGui")
sg.Parent = player:WaitForChild("PlayerGui")
sg.Name = "FishItMenu"

local circle = Instance.new("Frame")
circle.Parent = sg
circle.Size = UDim2.new(0, 80, 0, 80)
circle.Position = UDim2.new(0, 20, 0, 20)
circle.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
circle.BorderSizePixel = 0
circle.Name = "CircleButton"

-- Circle shape
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(1, 0)
corner.Parent = circle

local title = Instance.new("TextLabel")
title.Parent = circle
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "🎣"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

-- Menu Frame (Hidden)
local menu = Instance.new("Frame")
menu.Parent = sg
menu.Size = UDim2.new(0, 250, 0, 300)
menu.Position = UDim2.new(0, 120, 0, 20)
menu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
menu.BorderSizePixel = 0
menu.Visible = false

local mcorner = Instance.new("UICorner")
mcorner.CornerRadius = UDim.new(0, 12)
mcorner.Parent = menu

-- Buttons
local buttons = {
    {text="Auto Farm", color=Color3.fromRGB(0,200,0)},
    {text="Auto Sell", color=Color3.fromRGB(0,150,255)},
    {text="Speed x2", color=Color3.fromRGB(255,150,0)},
    {text="Fly", color=Color3.fromRGB(150,0,255)}
}

local farmActive = false
local sellActive = false

-- Create buttons
for i, btnData in pairs(buttons) do
    local btn = Instance.new("TextButton")
    btn.Parent = menu
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, 10 + (i-1)*60)
    btn.Text = btnData.text .. ": OFF"
    btn.BackgroundColor3 = btnData.color
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    
    local bcorner = Instance.new("UICorner")
    bcorner.CornerRadius = UDim.new(0, 8)
    bcorner.Parent = btn
    
    btn.MouseButton1Click:Connect(function()
        if btnData.text == "Auto Farm" then
            farmActive = not farmActive
            btn.Text = "Auto Farm: " .. (farmActive and "ON" or "OFF")
            btn.BackgroundColor3 = farmActive and Color3.fromRGB(0,255,0) or btnData.color
        elseif btnData.text == "Auto Sell" then
            sellActive = not sellActive
            btn.Text = "Auto Sell: " .. (sellActive and "ON" or "OFF")
        end
    end)
end

-- Toggle Menu
circle.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        menu.Visible = not menu.Visible
        circle.BackgroundColor3 = menu.Visible and Color3.fromRGB(50,255,50) or Color3.fromRGB(255,50,50)
    end
end)

-- Auto Farm Loop
spawn(function()
    while wait(0.1) do
        if farmActive then
            for _, obj in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    pcall(function() obj:FireServer() end)
                end
            end
        end
    end
end)

print("✅ Circle menu di pojok kiri atas! Klik tombol bulat 🎣")
