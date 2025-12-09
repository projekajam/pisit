-- Fish It Circle Menu CLICKABLE by projekajam
local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("🎣 Fish It Circle Menu LOADED!")

-- Main GUI
local sg = Instance.new("ScreenGui")
sg.Name = "FishItMenu"
sg.Parent = player:WaitForChild("PlayerGui")

-- CIRCLE BUTTON (ImageButton = CLICKABLE)
local circleBtn = Instance.new("ImageButton")
circleBtn.Parent = sg
circleBtn.Size = UDim2.new(0, 80, 0, 80)
circleBtn.Position = UDim2.new(0, 20, 0, 20)
circleBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
circleBtn.BorderSizePixel = 0
circleBtn.Image = "" -- Transparent image

local circleCorner = Instance.new("UICorner")
circleCorner.CornerRadius = UDim.new(1, 0)
circleCorner.Parent = circleBtn

local circleIcon = Instance.new("TextLabel")
circleIcon.Parent = circleBtn
circleIcon.Size = UDim2.new(1, 0, 1, 0)
circleIcon.BackgroundTransparency = 1
circleIcon.Text = "🎣"
circleIcon.TextColor3 = Color3.new(1,1,1)
circleIcon.TextScaled = true
circleIcon.Font = Enum.Font.GothamBold

-- Menu Frame (Hidden)
local menu = Instance.new("Frame")
menu.Parent = sg
menu.Size = UDim2.new(0, 250, 0, 300)
menu.Position = UDim2.new(0, 120, 0, 20)
menu.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
menu.BorderSizePixel = 0
menu.Visible = false

local menuCorner = Instance.new("UICorner")
menuCorner.CornerRadius = UDim.new(0, 12)
menuCorner.Parent = menu

-- Title
local title = Instance.new("TextLabel")
title.Parent = menu
title.Size = UDim2.new(1, 0, 0, 40)
title.Text = "Fish It by projekajam"
title.BackgroundTransparency = 1
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold

-- Buttons Data
local buttons = {
    {name="Auto Farm", color=Color3.fromRGB(0,200,0), active=false},
    {name="Auto Sell", color=Color3.fromRGB(0,150,255), active=false},
    {name="Speed x2", color=Color3.fromRGB(255,150,0), active=false},
    {name="Fly", color=Color3.fromRGB(150,0,255), active=false}
}

-- Create Buttons
for i, btnData in pairs(buttons) do
    local btn = Instance.new("TextButton")
    btn.Parent = menu
    btn.Size = UDim2.new(0.9, 0, 0, 50)
    btn.Position = UDim2.new(0.05, 0, 0, 50 + (i-1)*60)
    btn.Text = btnData.name .. ": OFF"
    btn.BackgroundColor3 = btnData.color
    btn.TextColor3 = Color3.new(1,1,1)
    btn.TextScaled = true
    btn.Font = Enum.Font.Gotham
    btn.Name = btnData.name
    
    local btnCorner = Instance.new("UICorner")
    btnCorner.CornerRadius = UDim.new(0, 8)
    btnCorner.Parent = btn
    
    -- Button Logic
    btn.MouseButton1Click:Connect(function()
        btnData.active = not btnData.active
        btn.Text = btnData.name .. ": " .. (btnData.active and "ON" or "OFF")
        btn.BackgroundColor3 = btnData.active and Color3.fromRGB(0,255,0) or btnData.color
        
        if btnData.name == "Auto Farm" and btnData.active then
            print("🚀 Auto Farm ON")
        end
    end)
end

-- CIRCLE BUTTON CLICK (Fixed!)
circleBtn.MouseButton1Click:Connect(function()
    menu.Visible = not menu.Visible
    circleBtn.BackgroundColor3 = menu.Visible and Color3.fromRGB(50,255,50) or Color3.fromRGB(255,50,50)
    print("📱 Menu toggled:", menu.Visible and "OPEN" or "CLOSED")
end)

print("✅ Circle menu CLICKABLE! Klik tombol bulat 🎣")
