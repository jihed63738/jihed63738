-- سكربت لزيادة سرعة اللاعب عند الاقتراب من لاعبين آخرين
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")

local function getHumanoid()
    local char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
    return char:WaitForChild("Humanoid"), char:WaitForChild("HumanoidRootPart")
end

local baseSpeed = 16
local boostedSpeed = baseSpeed * 1.15
local detectRange = 10

coroutine.wrap(function()
    while true do
        local success, humanoid, root = pcall(getHumanoid)
        if not success then task.wait(1) continue end

        local closest = math.huge
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
                local dist = (root.Position - p.Character.HumanoidRootPart.Position).Magnitude
                if dist < closest then
                    closest = dist
                end
            end
        end

        if closest < detectRange then
            humanoid.WalkSpeed = boostedSpeed
        else
            humanoid.WalkSpeed = baseSpeed
        end

        task.wait(0.2)
    end
end)()
