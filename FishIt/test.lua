-- Fish It SLIDER by projekajam
local Players = game:GetService("Players")
local player = Players.LocalPlayer

print("🎮 Fish It SLIDER LOADED!")

-- ScreenGui
local sg = Instance.new("ScreenGui")
sg.Parent = player.PlayerGui
sg.Name = "FishItSlider"

-- SLIDER BAR (Background)
local sliderBg = Instance.new("Frame")
sliderBg.Parent = sg
sliderBg.Size = UDim2.new(0, 300, 0, 60)
sliderBg.Position = UDim2.new(0.5, -150, 0.1, 0)
sliderBg.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
sliderBg.BorderSizePixel = 0

local bgCorner = Instance.new("UICorner")
bgCorner.CornerRadius = UDim.new(0, 25)
bgCorner.Parent = sliderBg

-- SLIDER BUTTON (Geser-geser)
local sliderBtn = Instance.new("TextButton")
sliderBtn.Parent = sliderBg
sliderBtn.Size = UDim2.new(0, 50, 1, 0)
sliderBtn.Position = UDim2.new(0, 0, 0, 0)
sliderBtn.BackgroundColor3 = Color3.fromRGB(255, 100, 100)
sliderBtn.Text = "🎣"
sliderBtn.TextColor3 = Color3.new(1,1,1)
sliderBtn.TextScaled = true
sliderBtn.Font = Enum.Font.GothamBold

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 25)
btnCorner.Parent = sliderBtn

-- DRAG SLIDER (SUPER SIMPLE)
local draggingSlider = false
sliderBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = true
    end
end)

sliderBtn.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        draggingSlider = false
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if draggingSlider and input.UserInputType == Enum.UserInputType.MouseMovement then
        local mouseX = input.Position.X
        local sliderLeft = sliderBg.AbsolutePosition.X
        local sliderRight = sliderLeft + sliderBg.AbsoluteSize.X
        local btnWidth = sliderBtn.AbsoluteSize.X
        
        -- Clamp position
        local newX = math.clamp(mouseX - sliderLeft - btnWidth/2, 0, sliderBg.AbsoluteSize.X - btnWidth)
        sliderBtn.Position = UDim2.new(0, newX, 0, 0)
        
        -- Color based on position (LEFT=Red, RIGHT=Green)
        local percent = newX / (sliderBg.AbsoluteSize.X - btnWidth)
        local red = 255 - (255 * percent)
        local green = 100 + (155 * percent)
        sliderBtn.BackgroundColor3 = Color3.fromRGB(red, green, 100)
        
        print("Slider pos:", math.floor(percent*100).."%")
    end
end)

-- CLICK ACTION (di tengah = FARM)
sliderBtn.MouseButton1Click:Connect(function()
    print("🚀 FARM SPAM ACTIVATED!")
    for i = 1, 20 do
        for _, obj in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                pcall(function() obj:FireServer() end)
            end
        end
        wait(0.05)
    end
    print("✅ Farm burst complete!")
end)

print("✅ SLIDER LOADED! Geser tombol merah 🎣")
print("📍 Klik tombol = FARM SPAM")
