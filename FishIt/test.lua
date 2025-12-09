-- Fish It SIMPLE by projekajam
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- GUI
local sg = Instance.new("ScreenGui")
sg.Parent = player.PlayerGui
local f = Instance.new("Frame")
f.Parent = sg
f.Size = UDim2.new(0,200,0,80)
f.Position = UDim2.new(0,10,0,10)
f.BackgroundColor3 = Color3.new(0,0,0)

local btn = Instance.new("TextButton")
btn.Parent = f
btn.Size = UDim2.new(1,0,1,0)
btn.Text = "AUTO FARM: OFF"
btn.TextColor3 = Color3.new(1,1,1)
btn.BackgroundColor3 = Color3.new(0.2,0.2,0.2)
btn.TextScaled = true

local farm = false
btn.MouseButton1Click:Connect(function()
    farm = not farm
    btn.Text = farm and "AUTO FARM: ON" or "AUTO FARM: OFF"
    btn.BackgroundColor3 = farm and Color3.new(0,1,0) or Color3.new(1,0,0)
end)

-- AUTO FISH (universal spam semua remote)
spawn(function()
    while true do
        wait(0.1)
        if farm then
            for _, obj in pairs(game:GetService("ReplicatedStorage"):GetDescendants()) do
                if obj:IsA("RemoteEvent") then
                    pcall(function()
                        obj:FireServer()
                    end)
                end
            end
        end
    end
end)

print("✅ Fish It LOADED! Klik GUI kiri atas")
