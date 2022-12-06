local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Client = Players.LocalPlayer 
local Character = Client.Character or Client.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
local Humanoid = Character:WaitForChild("Humanoid"); do
    Client.CharacterAdded:Connect(function(newCharacter)
        Character = newCharacter 
        Humanoid = Character:WaitForChild("Humanoid")
        HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")
    end)    
end


local AutoGuard = {}; do
    AutoGuard.Target = nil 

    function AutoGuard:CheckBallCarrier(Player) 
        if Player.Character and not (Player == Client) then
            return Player.Character:FindFirstChild("ball.weld")
        end
    end

    function AutoGuard:CheckOpponent(player)
        return game.PlaceId == 10107441386 or (not (player.TeamColor == Client.TeamColor))
    end 

    function AutoGuard:GetNearestPlayer() 
        local ClosestDistance = math.huge 
        local ClosestPlayer = nil 

        for i,v in pairs(Players:GetPlayers()) do
            if self:CheckOpponent(v) and self:CheckBallCarrier(v) and v.Character:FindFirstChild("HumanoidRootPart") and HumanoidRootPart then
                local Distance = (v.Character:FindFirstChild("HumanoidRootPart").Position - HumanoidRootPart.Position).Magnitude 
                
                if Distance < ClosestDistance then
                    ClosestPlayer = v 
                    ClosestDistance = Distance
                end
            end
        end
        
        return ClosestPlayer
    end

    function AutoGuard:IsGuarding()
        return game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.G)
    end


    function AutoGuard:GetClosestNet()
        local ClosestDistance = math.huge 
        local ClosestNet = nil 

        do 
            if not self.Cache then
                self.Cache = {} 
    
                for _, Part in ipairs(workspace:GetDescendants()) do
                    if Part.Name == "Goal" and Part:IsA("BasePart") then
                        table.insert(self.Cache, Part)
                    end
                end
            end 
        end

        for _, Part in ipairs(self.Cache) do
            if HumanoidRootPart then
                local Distance = (Part.Position - HumanoidRootPart.Position).Magnitude 
                
                if Distance < ClosestDistance then
                    ClosestDistance = Distance 
                    ClosestNet = Part 
                end
            end
        end

        return ClosestNet
    end

    function AutoGuard:GetTargetPosition()
        local Target = self:GetNearestPlayer()
        local Net = self:GetClosestNet()

        if Target and Net then
            local TargetHumanoidRootPart = Target.Character:FindFirstChild("HumanoidRootPart")
            local TargetHumanoid = Target.Character:FindFirstChildOfClass("Humanoid")

            local Direction = (Net.Position - TargetHumanoidRootPart.Position).Unit
            local Position = nil 

            if TargetHumanoid.MoveDirection.Magnitude > 0 then
                Position = (TargetHumanoidRootPart.Position + (Direction * 7)) + TargetHumanoidRootPart.Velocity.Unit * 7
            else
                Position = TargetHumanoidRootPart.Position
            end

            return TargetHumanoid, Position
        end
    end

    function AutoGuard:Startup()
        game:GetService("RunService").RenderStepped:Connect(function()
            if self:IsGuarding() then
                local TargetHumanoid, PositionEntry = self:GetTargetPosition()

                if PositionEntry and Humanoid and (self.Target == nil or self.Target == TargetHumanoid.Parent) then 
                    self.Target = TargetHumanoid.Parent 
                    --Humanoid.WalkSpeed = TargetHumanoid.WalkSpeed
                    Humanoid:MoveTo(PositionEntry)
                end
            end
        end)

        game:GetService("UserInputService").InputEnded:Connect(function(input)
            if input.KeyCode == Enum.KeyCode.G then 
                self.Target = nil 
            end
        end)
    end
end; AutoGuard:Startup()
