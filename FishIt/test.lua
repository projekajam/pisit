-- Fish It Auto Farm Script by [YourName]
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

-- Cari RemoteEvents (Sesuaikan path berdasarkan game)
local remotes = ReplicatedStorage:WaitForChild("Remotes") -- Path umum Fish It
local fishRemote = remotes:FindFirstChild("Fish") or remotes:FindFirstChild("Cast")
local sellRemote = remotes:FindFirstChild("SellAll")

-- Auto Fish Loop
local autoFishing = false
spawn(function()
    while true do
        if autoFishing then
            if fishRemote then fishRemote:FireServer() end
            wait(0.1)
        end
        wait(0.5)
    end
end)

-- Auto Sell
spawn(function()
    while true do
        if sellRemote then sellRemote:FireServer() end
        wait(5)
    end
end)

-- Simple GUI Toggle
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
Frame.Parent = ScreenGui
Frame.Size = UDim2.new(0,200,0,100)
Frame.Position = UDim2.new(0,10,0,10)
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Toggle = Instance.new("TextButton")
Toggle.Parent = Frame
Toggle.Text = "Auto Farm: OFF"
Toggle.Size = UDim2.new(1,0,0.5,0)
Toggle.MouseButton1Click:Connect(function()
    autoFishing = not autoFishing
    Toggle.Text = autoFishing and "Auto Farm: ON" or "Auto Farm: OFF"
end)

print("Fish It Script Loaded! Toggle GUI di pojok kiri atas.")
