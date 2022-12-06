getgenv().adjustments = {         
	[59] = {
		Power = 75,
		Arc = Vector3.new(0, 30, 0)
	},

	[60] = {
		Power = 75,
		Arc = Vector3.new(0, 32.5, 0)
	},

	[61] = {
		Power = 75,
		Arc = Vector3.new(0, 35, 0)
	},

	[62] = {
		Power = 80,
		Arc = Vector3.new(0, 25, 0)
	},

	[63] = {
		Power = 80,
		Arc = Vector3.new(0, 27, 0)
	},

	[64] = {
		Power = 80,
		Arc = Vector3.new(0, 30, 0)
	},

	[65] = {
		Power = 80,
		Arc = Vector3.new(0, 32, 0)
	},

	[66] = {
		Power = 80,
		Arc = Vector3.new(0, 34, 0)
	},

	[67] = {
		Power = 85,
		Arc = Vector3.new(0, 25, 0)
	},

	[68] = {
		Power = 85,
		Arc = Vector3.new(0, 30, 0)
	},

	[69] = {
		Power = 85,
		Arc = Vector3.new(0, 32, 0)
	},

	[70] = {
		Power = 85,
		Arc = Vector3.new(0, 32, 0)
	},

	[71] = {
		Power = 85,
		Arc = Vector3.new(0, 36, 0)
	},

	[72] = {
		Power = 85,
		Arc = Vector3.new(0, 40, 0)
	}
}

getgenv().adjustments2 = {         
	[59] = {
		Power = 80,
		Arc = Vector3.new(0, 70, 0)
	},

	[60] = {
		Power = 80,
		Arc = Vector3.new(0, 68, 0)
	},

	[61] = {
		Power = 80,
		Arc = Vector3.new(0, 66, 0)
	},

	[62] = {
		Power = 80,
		Arc = Vector3.new(0, 64, 0)
	},

	[63] = {
		Power = 80,
		Arc = Vector3.new(0, 62, 0)
	},

	[64] = {
		Power = 85,
		Arc = Vector3.new(0, 80, 0)
	},

	[65] = {
		Power = 85,
		Arc = Vector3.new(0, 78, 0)
	},

	[66] = {
		Power = 85,
		Arc = Vector3.new(0, 76, 0)
	},

	[67] = {
		Power = 85,
		Arc = Vector3.new(0, 74, 0)
	},

	[68] = {
		Power = 85,
		Arc = Vector3.new(0, 70, 0)
	},

	[69] = {
		Power = 85,
		Arc = Vector3.new(0, 66, 0)
	},

	[70] = {
		Power = 85,
		Arc = Vector3.new(0, 62, 0)
	},

	[71] = {
		Power = 85,
		Arc = Vector3.new(0, 50, 0)
	}
}

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/Library.lua"))()
local Players = game:GetService("Players")
local Client = Players.LocalPlayer 

local Aimbot = {}
local AutoDribble = {}
local BallReach = {}
local RangeIndicator = {}
local AutoGuard = {}
local BallMags = {}




do
	RangeIndicator.Enabled = false 
	RangeIndicator.Active = false 
	RangeIndicator.CurrentConnection = nil 

	RangeIndicator.Part = Instance.new("Part") 
	RangeIndicator.Part.Size = Vector3.new(2.3, 2.3, 1.3)
	RangeIndicator.Part.Color = Color3.fromRGB(0, 255, 0)
	RangeIndicator.Part.Material = Enum.Material.Neon
	RangeIndicator.Part.Anchored = true 
	RangeIndicator.Part.CanCollide = false 

	function RangeIndicator:Tag(boolean)
		self.Active = boolean 
		if self.Active and not self.CurrentConnection then
			self.CurrentConnection = game:GetService("RunService").RenderStepped:Connect(function()
				if self.Enabled and self.Active then
					local Torso = Client.Character and Client.Character:FindFirstChild("Torso")
					if Torso then
						self.Part.Parent = workspace 
						self.Part.CFrame = Torso.CFrame
					end 
				else
					self.Part.Parent = nil 
					self.CurrentConnection:Disconnect()
					self.CurrentConnection = nil 
				end 
			end) 
		end 
	end 
end  

local ContextActionService = game:GetService("ContextActionService")
local FREEZE_ACTION = "freezeMovement"
local A = false 
local function NoInput()
	A = not A 
	if A then
		ContextActionService:BindAction(
			FREEZE_ACTION,
			function() return Enum.ContextActionResult.Sink end,
			false,
			unpack(Enum.PlayerActions:GetEnumItems())
		)
	else
		ContextActionService:UnbindAction(FREEZE_ACTION)
	end
end

do
	Aimbot.Enabled = false 
	Aimbot.CurrentConnection = nil 
	Aimbot.Requesting = false 
	Aimbot.FPSConnection = nil 
	Aimbot.JumpTimer = true 
	Aimbot.OriginatedPosition = nil
	Aimbot.LowArc = true 
	Aimbot.HighArc = false

	function Aimbot:GetClosestRim()
		local Distance = math.huge 
		local ClosestRim = nil 

		for _, Court in ipairs(workspace.Courts:GetChildren()) do
			for _, Part in ipairs(Court:GetChildren()) do
				if Part:IsA("BasePart") and Part.Size == Vector3.new(.25, .25, .25) and Part.BrickColor == BrickColor.new("Really red") then
					local RootPart = Client.Character and Client.Character:WaitForChild("HumanoidRootPart")
					local Distance2 = RootPart and ((self.OriginatedPosition or RootPart.Position) - Part.Position).Magnitude 

					if Distance2 and Distance2 < Distance then
						ClosestRim = Part 
						Distance = Distance2 
					end
				end
			end
		end

		for _, Court in ipairs(workspace.PracticeArea:GetChildren()) do
			for _, Part in ipairs(Court:GetChildren()) do
				if Part:IsA("BasePart") and Part.Size == Vector3.new(.25, .25, .25) and Part.BrickColor == BrickColor.new("Really red") then
					local RootPart = Client.Character and Client.Character:WaitForChild("HumanoidRootPart")
					local Distance2 = RootPart and ((self.OriginatedPosition or RootPart.Position) - Part.Position).Magnitude 

					if Distance2 and Distance2 < Distance then
						ClosestRim = Part 
						Distance = Distance2 
					end
				end
			end
		end

		return ClosestRim, Distance 
	end

	function Aimbot:GetTrajectory()
		local Rim, Distance = self:GetClosestRim()

		if Aimbot.LowArc and adjustments[math.floor(Distance) + 1] or Aimbot.HighArc and adjustments2[math.floor(Distance)] then
			RangeIndicator:Tag(true)
		else
			RangeIndicator:Tag(false)
		end

		if Aimbot.LowArc and adjustments[math.floor(Distance)] or Aimbot.HighArc and adjustments2[math.floor(Distance)] then 
			return Vector3.new(Rim.Position.X, Rim.Position.Y + (Aimbot.LowArc and adjustments[math.floor(Distance)].Arc.Y or Aimbot.HighArc and adjustments2[math.floor(Distance)].Arc.Y), Rim.Position.Z), (Aimbot.LowArc and adjustments[math.floor(Distance)].Power or Aimbot.HighArc and adjustments2[math.floor(Distance)].Power), Distance
		end   
	end

	function Aimbot:GetNormal()
		local Rim, Distance = self:GetClosestRim()

		if adjustments[math.floor(Distance)] then 
			return (Vector3.new(Rim.Position.X, Rim.Position.Y + adjustments[math.floor(Distance)].Arc.Y, Rim.Position.Z)), adjustments[math.floor(Distance)].Power, Distance
		end   
	end

	function Aimbot:NewValue(boolean)
		self.Enabled = boolean 
		if self.Enabled then
			local Humanoid = Client.Character and Client.Character:WaitForChild("Humanoid") 
			self.CurrentConnection = Humanoid.Jumping:Connect(function() 
				local Ball = Client.Character and Client.Character:FindFirstChild("Basketball")
				if not self.OriginatedPosition then
					self.OriginatedPosition = Humanoid.Parent.PrimaryPart.Position
				end 
				if self:GetTrajectory() and Ball then 
					local g, p = self:GetTrajectory()
					Client:WaitForChild("Power").Value = p
					self.Requesting = true 
					local Humanoid = Client.Character and Client.Character:FindFirstChildOfClass("Humanoid")
					if Humanoid then
						NoInput()
						Humanoid.WalkSpeed = 0 
					end  
					if self.JumpTimer then
						task.spawn(function()
							local RaycastParams1 = RaycastParams.new()
							RaycastParams1.FilterType = Enum.RaycastFilterType.Blacklist
							RaycastParams1.FilterDescendantsInstances = {Humanoid.Parent}

							local Raycast = workspace:Raycast(Humanoid.Parent:FindFirstChild("Torso").Position, Vector3.new(0, -10, 0), RaycastParams1)
							if Raycast and Raycast.Instance then
								if (Humanoid.Parent:FindFirstChild("Torso").Position.Y - Raycast.Position.Y) > 9 then
									mouse1click() 
								else
									repeat 
										RaycastParams1 = RaycastParams.new()
										RaycastParams1.FilterType = Enum.RaycastFilterType.Blacklist
										RaycastParams1.FilterDescendantsInstances = {Humanoid.Parent}

										Raycast = workspace:Raycast(Humanoid.Parent:FindFirstChild("Torso").Position, Vector3.new(0, -10, 0), RaycastParams1)
										task.wait()
									until (Humanoid.Parent:FindFirstChild("Torso").Position.Y - Raycast.Position.Y) > 9 
									mouse1click() 
								end
							end
						end)
					end

					repeat task.wait() until not Client.Character:FindFirstChild("Basketball") 
					if Humanoid then
						if A then
							NoInput()
						end
						Humanoid.WalkSpeed = 16
					end

					self.Requesting = false  
					self.OriginatedPosition = nil
					self.FPSConnection:Disconnect()
					self.FPSConnection = nil 
				else
					self.Requesting = false 
				end
			end)
		else 
			if self.CurrentConnection then 
				self.CurrentConnection:Disconnect()
			end 
			if self.FPSConnection then 
				self.FPSConnection:Disconnect()
			end 
		end
	end 

	game:GetService("RunService").RenderStepped:Connect(function()
		if not Client.Character or not Client.Character:FindFirstChild("Basketball") then
			Aimbot.OriginatedPosition = nil 
			Aimbot.Requesting = false
		end
	end)
end  

do 
	local function IgnoreList()
		local IgnoreList = {}

		for i, Player in ipairs(game:GetService("Players"):GetPlayers()) do
			if Player.Character then
				table.insert(IgnoreList, Player.Character)
			end
		end

		for a,b in pairs(game:GetService("CollectionService"):GetTagged("Walls")) do
			table.insert(IgnoreList, b)
		end

		return IgnoreList
	end

	local function GetMousePosition()   
		local Location = game:GetService("UserInputService"):GetMouseLocation()
		local RayA = workspace.CurrentCamera:ViewportPointToRay(Location.X, Location.Y)
		return workspace:FindPartOnRayWithIgnoreList(Ray.new(RayA.Origin, RayA.Direction * 1000), IgnoreList())
	end

	local function Yea1()
		local Yea, Yessir = GetMousePosition() 
		return (Yessir - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).unit 
	end

	local old; old = hookfunction(game:GetService("ReplicatedStorage").shootingEvent.FireServer, newcclosure(function(self, ...) 
		local args = {...}

		if Aimbot.Requesting then
			local X, Y, Z 
			local Yeahh = Yea1()

			for i,v in pairs(args[3]) do
				if v == Yeahh.X then
					X = i 
				elseif v == Yeahh.Y then
					Y = i 
				elseif v == Yeahh.Z then
					Z = i
				end
			end  



			local Trajectory = Aimbot:GetTrajectory() and (Aimbot:GetTrajectory() - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Unit
			local _, _, d = Aimbot:GetTrajectory()
			
			if Trajectory then
				--Library.Notify(Library, "Shooting at " .. tostring(math.floor(d))) 
				print(tostring(math.floor(d)))
				args[3][X] = Trajectory.X 
				args[3][Y] = Trajectory.Y 
				args[3][Z] = Trajectory.Z 
			end
		end
		return old(self, table.unpack(args))
	end))
end

do
	AutoDribble.Enabled = false 
	AutoDribble.Combination = "Randomized" 
	AutoDribble.LastUse = 0

	function AutoDribble:GetClosestPlayer()
		local ClosestDistance = math.huge 
		local ClosestPlayer = nil 

		for _, Player in ipairs(Players:GetPlayers()) do 
			if Player == Client then continue end
			local Root = Player.Character and Player.Character.PrimaryPart
			if Root then
				local MyRoot = Client.Character and Client.Character.PrimaryPart
				if MyRoot then
					local Distance = (MyRoot.Position - Root.Position).Magnitude
					if Distance < ClosestDistance then
						ClosestDistance = Distance 
						ClosestPlayer = Player 
					end
				end
			end
		end

		return ClosestPlayer
	end

	function AutoDribble:GetClosestPartToBall()
		local Player = self:GetClosestPlayer()
		if Player then
			local Character = Client.Character 
			local Basketball = Character and Character:FindFirstChild("Basketball")

			if Basketball then
				local Ball = Basketball:FindFirstChild("Ball")

				local ClosestPartLeftArmDistance = math.huge
				local ClosestPartLeftArm 

				local ClosestPartRightArmDistance = math.huge
				local ClosestPartRightArm 

				if Player.Character then
					for _, Part in ipairs(Player.Character:GetChildren()) do
						if Part:IsA("BasePart") then
							local G = (Part.Position - Character:FindFirstChild("Right Arm").Position).Magnitude 
							if G < ClosestPartRightArmDistance then
								ClosestPartRightArmDistance = G 
								ClosestPartRightArm = Part 
							end
						end
					end

					for _, Part in ipairs(Player.Character:GetChildren()) do
						if Part:IsA("BasePart") then
							local G = (Part.Position - Character:FindFirstChild("Left Arm").Position).Magnitude 
							if G < ClosestPartRightArmDistance then
								ClosestPartLeftArmDistance = G 
								ClosestPartLeftArm = Part 
							end
						end
					end 

					if ClosestPartRightArmDistance < (ClosestPartLeftArmDistance) then
						return "left"
					else
						return "right"
					end
				end
			end
		end
	end 
	local VirtualInputManager = game:GetService('VirtualInputManager')
	function Aimbot:GetEquippedBall()
		local Character = Client.Character 
		local Basketball = Character and Character:FindFirstChild("Basketball")
		local LeftArmDistance = math.huge 
		local RightArmDistance = math.huge

		local LeftArm, RightArm, Ball = Character and Character:FindFirstChild("Left Arm"), Character and Character:FindFirstChild("Right Arm"), Basketball and Basketball:FindFirstChild("Ball")

		if LeftArm and RightArm and Ball then
			LeftArmDistance = (Ball.Position - LeftArm.Position).Magnitude
			RightArmDistance = (Ball.Position - RightArm.Position).Magnitude 

			return LeftArmDistance < RightArmDistance and "Left" or "Right"
		end
	end

	game:GetService("RunService").RenderStepped:Connect(function()
		if AutoDribble.Enabled and (tick() - AutoDribble.LastUse) >= .5 then
			local Side = AutoDribble:GetClosestPartToBall()
			local g = Client.Character and Client.Character:FindFirstChild("Basketball") and Client.Character:FindFirstChild("Basketball"):FindFirstChild("Ball")
			local Ye = Client.Character and Client.Character:FindFirstChild("Left Arm")
			local Ye2 = Client.Character and Client.Character:FindFirstChild("Right Arm")

			local Left = {
				"H",
				"G",
				--"B"
			}

			local Right = {
				"H",
				"F",
				--"V"
			}


			if Side == "left" and Aimbot:GetEquippedBall() == "Right" or Side == "right" and Aimbot:GetEquippedBall() == "Left" then
				if Side == "left" and Aimbot:GetEquippedBall() == "Right" then
					if AutoDribble.Combination == "Randomized" then
						local Key = Left[math.random(1, #Left)]
						VirtualInputManager:SendKeyEvent(true, Key, false, game)
						task.wait()
						VirtualInputManager:SendKeyEvent(false, Key, false, game)  
					elseif AutoDribble.Combination == "Switch hands" then
						local Key = "H"
						VirtualInputManager:SendKeyEvent(true, Key, false, game)
						task.wait()
						VirtualInputManager:SendKeyEvent(false, Key, false, game)  
					elseif AutoDribble.Combination == "Behind the back" then
						local Key = "G"
						VirtualInputManager:SendKeyEvent(true, Key, false, game)
						task.wait()
						VirtualInputManager:SendKeyEvent(false, Key, false, game)  
					end

					AutoDribble.LastUse = tick()
				elseif Side == "right" and Aimbot:GetEquippedBall() == "Left" then
					if AutoDribble.Combination == "Randomized" then
						local Key = Right[math.random(1, #Right)]
						VirtualInputManager:SendKeyEvent(true, Key, false, game)
						task.wait()
						VirtualInputManager:SendKeyEvent(false, Key, false, game)  
					elseif AutoDribble.Combination == "Switch hands" then
						local Key = "H"
						VirtualInputManager:SendKeyEvent(true, Key, false, game)
						task.wait()
						VirtualInputManager:SendKeyEvent(false, Key, false, game)  
					elseif AutoDribble.Combination == "Behind the back" then
						local Key = "F"
						VirtualInputManager:SendKeyEvent(true, Key, false, game)
						task.wait()
						VirtualInputManager:SendKeyEvent(false, Key, false, game)  
					end

					AutoDribble.LastUse = tick()
				end 
			end

			if not Client.Character or not Client.Character:FindFirstChild("Basketball") then
				AutoDribble.LastSide = ""
			end
		end
	end)


end

do
	AutoGuard.Enabled = false 
	AutoGuard.Keybind = "E"

	game:GetService("UserInputService").InputBegan:Connect(function(input, gameProcessedEvent)
		if not gameProcessedEvent then
			if input.KeyCode == Enum.KeyCode[AutoGuard.Keybind] then
				AutoGuard.Enabled = not AutoGuard.Enabled 
				if AutoGuard.Enabled then 
					local ClosestDistance = math.huge 
					local ClosestPlayer = nil 
					for _, Player in ipairs(game:GetService("Players"):GetPlayers()) do
						if Player ~= Client then 

							local Torso = Client.Character and Client.Character:FindFirstChild("Torso")
							local OtherTorso = Player.Character and Player.Character:FindFirstChild("Torso") 

							if Torso and OtherTorso then
								if (Torso.Position - OtherTorso.Position).Magnitude < ClosestDistance and OtherTorso.Parent:FindFirstChild("Ball", true) then
									ClosestDistance = (Torso.Position - OtherTorso.Position).Magnitude
									ClosestPlayer = Player
								end
							end
						end
					end

					if ClosestPlayer then
						local Torso = Client.Character and Client.Character:FindFirstChild("Torso")
						local OtherTorso = ClosestPlayer.Character and ClosestPlayer.Character:FindFirstChild("Torso") 
						while true do
							if not AutoGuard.Enabled then
								break 
							end

							if OtherTorso.Velocity.magnitude > 0.5 and OtherTorso.Parent:FindFirstChild("Ball", true) then
								Torso.Parent:FindFirstChildOfClass("Humanoid"):MoveTo(OtherTorso.Position + OtherTorso.Velocity.unit * 7)
							elseif OtherTorso.Velocity.magnitude < 0.5 and OtherTorso.Parent:FindFirstChild("Ball", true) then
								Torso.Parent:FindFirstChildOfClass("Humanoid"):MoveTo(OtherTorso.Position)
							elseif not OtherTorso.Parent:FindFirstChild("Ball", true) then
								AutoGuard.Enabled = false
							end

							task.wait()
						end 
					end
				end
			end
		end
	end)
end
--[[
	    BallReach.Distance = 5

    function BallReach:GetClosestBall()
        local ClosestBall = nil 
        local ClosestDistance = math.huge 
        
        for _, Player in ipairs(Players:GetPlayers()) do
            local Ball = Player.Character and Player.Character:FindFirstChild("Basketball") and Player.Character:FindFirstChild("Basketball"):FindFirstChild("Ball")
            local RootPart = Client.Character and Client.Character:FindFirstChild("HumanoidRootPart")

            if Ball and RootPart then
                local Distance = (Ball.Position - RootPart.Position).Magnitude 
                if Distance < self.Distance and Distance < ClosestDistance then
                    ClosestBall = Ball
                    ClosestDistance = Distance
                end
            end
        end

        return ClosestBall
    end  

    function BallReach:GetClosestPart(Ball)
        if Client.Character then
            local ClosestDistance = math.huge 
            local ClosestPart = nil 

            for i,v in pairs(Client.Character:GetChildren()) do
                if v:IsA("BasePart") then
                    local Distance = (v.Position - Ball.Position).Magnitude
                    if Distance < ClosestDistance then
                        ClosestDistance = Distance 
                        ClosestPart = v 
                    end
                end
            end

            return ClosestPart
        end
    end

    game:GetService("RunService").RenderStepped:Connect(function()
        local Ball = BallReach:GetClosestBall()
        local RootPart = Ball and BallReach:GetClosestPart(Ball)

        if Ball and RootPart then
            firetouchinterest(RootPart, Ball, 0)
            task.wait()
            firetouchinterest(RootPart, Ball, 1)
        end
    end)
]]


do
	function GetClosestPart(Ball)
		if Client.Character then
			local ClosestDistance = math.huge 
			local ClosestPart = nil 

			for i,v in pairs(Client.Character:GetChildren()) do
				if v:IsA("BasePart") then
					local Distance = (v.Position - Ball.Position).Magnitude
					if Distance < ClosestDistance then
						ClosestDistance = Distance 
						ClosestPart = v 
					end
				end
			end

			return ClosestPart
		end	
	end

	do
		BallMags.Distance = 0

		function BallMags:GetClosestBall()
			local ClosestBall = nil 
			local ClosestDistance = math.huge 

			for _, Ball in ipairs(workspace:GetChildren()) do	
				if Ball.Name == "Basketball" and Ball:FindFirstChild("Ball") then
					Ball = Ball:FindFirstChild("Ball") 
					local RootPart = Client.Character and Client.Character:FindFirstChild("HumanoidRootPart")
					local Distance = (Ball.Position - RootPart.Position).Magnitude 
					if Distance < self.Distance and Distance < ClosestDistance then
						ClosestBall = Ball
						ClosestDistance = Distance
					end
				end
			end

			return ClosestBall
		end  

	end

	do
		BallReach.Distance = 0

		function BallReach:GetClosestBall()
			local ClosestBall = nil 
			local ClosestDistance = math.huge 

			for _, Player in ipairs(Players:GetPlayers()) do
				local Ball = Player.Character and Player.Character:FindFirstChild("Basketball") and Player.Character:FindFirstChild("Basketball"):FindFirstChild("Ball")
				local RootPart = Client.Character and Client.Character:FindFirstChild("HumanoidRootPart")

				if Ball and RootPart then
					local Distance = (Ball.Position - RootPart.Position).Magnitude 
					if Distance < self.Distance and Distance < ClosestDistance then
						ClosestBall = Ball
						ClosestDistance = Distance
					end
				end
			end

			return ClosestBall
		end  
	end	


	game:GetService("RunService").RenderStepped:Connect(function()
		local MagsBall = BallMags:GetClosestBall()
		local ReachBall = BallReach:GetClosestBall()
		local Root1, Root2 = MagsBall and GetClosestPart(MagsBall), ReachBall and GetClosestPart(ReachBall)

		if MagsBall then
			firetouchinterest(Root1, MagsBall, 0)
			task.wait()
			firetouchinterest(Root1, MagsBall, 1)
		end

		if ReachBall then
			firetouchinterest(Root2, ReachBall, 0)
			task.wait()
			firetouchinterest(Root2, ReachBall, 1)
		end
	end)
end


game:GetService("RunService").RenderStepped:Connect(function()
	Aimbot:GetTrajectory()
end)

local Window = Library:CreateWindow({
	Title = "tobiware V2",
	Center = true, 
	AutoShow = true 
})

local Tabs = {
	Ball = Window:AddTab("Ball"), 
	Physics = Window:AddTab("Physics"),
	Defense = Window:AddTab("Defense")
}

local GroupBoxes = {
	Ball = {
		SilentAim = Tabs.Ball:AddLeftGroupbox("Silent Aim"),
		AutoHandles = Tabs.Ball:AddRightGroupbox("Handles"),
	},

	Physics = {
		TouchInterests = Tabs.Physics:AddLeftGroupbox("Touch Interests")
	},

	Defense = {
		AutoGuardT = Tabs.Defense:AddLeftGroupbox("Auto Guard")
	}
}

GroupBoxes.Ball.SilentAim:AddToggle("SilentAimEnabled", {
	Text = "Enabled",
	Default = Aimbot.Enabled,
})

GroupBoxes.Ball.SilentAim:AddToggle("RangeIndicator", {
	Text = "Range Indicator",
	Default = RangeIndicator.Enabled,
})

GroupBoxes.Ball.SilentAim:AddToggle("HighArc", {
	Text = "High Arc",
	Default = Aimbot.HighArc,
})



GroupBoxes.Ball.AutoHandles:AddToggle("AutoHandlesEnabled", {
	Text = "Enabled",
	Default = AutoDribble.Enabled,
})

GroupBoxes.Ball.AutoHandles:AddDropdown("HandlesDropdown", {
	Values = {'Behind the back', 'Switch hands', 'Randomized'},
	Default = 3,
	Multi = false,
	Text = 'Combination',
})

GroupBoxes.Physics.TouchInterests:AddSlider("ReachValue", {
	Text = "Ball Reach",
	Default = BallReach.Distance,
	Min = 0,
	Max = 30,
	Rounding = 2,
	Compact = false 
})

GroupBoxes.Physics.TouchInterests:AddSlider("MagsValue", {
	Text = "Ball Mags",
	Default = BallMags.Distance,
	Min = 0,
	Max = 30,
	Rounding = 2,
	Compact = false 
})

GroupBoxes.Defense.AutoGuardT:AddLabel("Keybind"):AddKeyPicker("AutoGuardKeyPicker", {
	Default = AutoGuard.Keybind,
	SyncToggleState = false, 
	Mode = 'Toggle',
	Text = "?"
})

Options.MagsValue:OnChanged(function()
	BallMags.Distance = Options.MagsValue.Value
end)

Options.ReachValue:OnChanged(function()
	BallReach.Distance = Options.ReachValue.Value
end)

Options.AutoGuardKeyPicker:OnClick(function()
	AutoGuard.Keybind = Options.AutoGuardKeyPicker.Value
end)

Toggles.AutoHandlesEnabled:OnChanged(function()
	AutoDribble.Enabled = Toggles.AutoHandlesEnabled.Value 
end)

Options.HandlesDropdown:OnChanged(function()
	AutoDribble.Combination = typeof(Options.HandlesDropdown.Value) ~= "table" and Options.HandlesDropdown.Value or Options.HandlesDropdown.Value[1]
end)


Toggles.SilentAimEnabled:OnChanged(function()
	Aimbot:NewValue(Toggles.SilentAimEnabled.Value)
end)

Toggles.RangeIndicator:OnChanged(function()
	RangeIndicator.Enabled = Toggles.RangeIndicator.Value 
end)

Toggles.HighArc:OnChanged(function()
	if Toggles.HighArc.Value == true then
		Aimbot.HighArc = true 
		Aimbot.LowArc = false 
	else
		Aimbot.HighArc = false 
		Aimbot.LowArc = true
	end
end)

Library:Notify("tobiware loaded")
