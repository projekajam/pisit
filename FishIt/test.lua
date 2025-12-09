-- Fish It Script by projekajam (FIXED)
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local player = Players.LocalPlayer

print("🔍 Scanning Fish It remotes...")

-- Cek semua possible paths
local paths = {
    ReplicatedStorage:FindFirstChild("Remotes"),
    ReplicatedStorage:FindFirstChild("Events"),
    ReplicatedStorage:FindFirstChild("RemoteEvents"),
    workspace:FindFirstChild("Remotes")
}

local fishRemotes = {}
for _, path in pairs(paths) do
    if path then
        for _, obj in pairs(path:GetDescendants()) do
            if obj:IsA("RemoteEvent") then
                local name = obj.Name:lower()
                if name:find("fish") or name:find("cast") or name:find("catch") then
                    table.insert(fishRemotes, obj)
                    print("✅ Found remote:", obj:GetFullName())
                end
            end
        end
    end
end

print("📊 Found", #fishRemotes, "fish remotes")

-- GUI Toggle
local sg = Instance.new("ScreenGui")
local f = Instance.new("Frame", sg)
f.Size, f.Position, f.BackgroundColor3 = UDim2.new(0,220,0,100), UDim2.new(0,10,0,10), Color3.new(0,0,0)
f.BorderSizePixel = 2
sg.Parent = player:WaitForChild("PlayerGui")

local title = Instance.new("TextLabel", f)
title.Size, title.Position, title.Text, title.TextColor3 = UDim2.new(1,0,0,30), UDim2.new(0,0,0,0), "Fish It by projekajam", Color3.new(1,1,1)
title.BackgroundTransparency = 1
title.TextScaled = true

local toggle = Instance.new("TextButton", f)
toggle.Size, toggle.Position, toggle.Text, toggle.BackgroundColor3 = UDim2.new(1,-20,0,40), UDim2.new(0,10,0,40), "AUTO FARM: OFF", Color3.new(0.2,0.2,0.2)
toggle.TextColor3, toggle.TextScaled = Color3.new(1,1,1), true

local status = Instance.new("TextLabel", f)
status.Size, status.Position, status.Text, status.TextColor3 = UDim2.new(1,0,0,25), UDim2.new(0,0,0,75), "Status: Ready", Color3.new(0,1,0)
status.BackgroundTransparency, status.TextScaled = 1, true

local autoFarm = false
toggle.MouseButton1Click:Connect(function()
    autoFarm = not autoFarm
    toggle.Text = "AUTO FARM: " .. (autoFarm and "ON 🟢" or "OFF 🔴")
    toggle.BackgroundColor3 = autoFarm and Color3.new(0,0.8,0) or Color3.new(0.8,0,0)
    status.Text = autoFarm and "Farming..." or "Stopped"
end)

-- Auto farm loop
spawn(function()
    while wait(0.05) do
        if autoFarm and #fishRemotes > 0 then
            for _, remote in pairs(fishRemotes) do
                pcall(function()
                    remote:FireServer()
                end)
            end
        end
    end
end)

print("🎣 Fish It Script LOADED! Toggle di kiri atas")
print("📋 Cek console untuk remote paths")
