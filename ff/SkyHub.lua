




local uis = game:GetService("UserInputService")

uis.InputBegan:Connect(function(key, gp)
    if gp then return end; -- prevents it from opening/closing when inside of a text box

    if key.KeyCode == Enum.KeyCode.CTRL then
        script.Parent.Visible = not script.Parent.Visible
    end
end)



    
local lib = loadstring(game:HttpGet("https://raw.githubusercontent.com/insanedude59/UILib/main/source"))();
lib:SetTitle("Sky Hub | Private")




local Mags = lib:NewTab("FF2", "")









-- Mags

local player = game.Players.LocalPlayer
local rs = game:GetService("RunService")

function magBall(ball)
   if ball and player.Character then
       firetouchinterest(player.Character["Left Arm"], ball, 0)
       firetouchinterest(player.Character["Right Arm"], ball, 0)
       task.wait()
       firetouchinterest(player.Character["Left Arm"], ball, 1)
       firetouchinterest(player.Character["Right Arm"], ball, 1)
   end
end

Mags:NewToggle("Legit Mags",nil,function(bool)
shared.Mags = bool
    rs.Stepped:Connect(function()
    if shared.Mags and not game:GetService("ReplicatedStorage").Values.HomeQB.Value:match(player.Name) and not game:GetService("ReplicatedStorage").Values.AwayQB.Value:match(player.Name) then
       for i,v in pairs(workspace:GetChildren()) do
           if v.Name == "Football" and v:IsA("BasePart") then
               wait()
               local mag = (player.Character.Torso.Position - v.Position).Magnitude
               magBall(v)
               
           end
        end
    else
        wait()
      
    end
    if shared.Mags and game:GetService("ReplicatedStorage").Values.HomeQB.Value:match(player.Name) or game:GetService("ReplicatedStorage").Values.AwayQB.Value:match(player.Name) then
        print('Magz Auto-Disabled as QB')
    end
end)
end) 




-- Blatant Mags


Mags:NewButton("Blatant Mags",function()
local uis = game:GetService('UserInputService')
local old = nil


_G.On = true -- turn to true to turn on, false to turn it off


 
old = hookmetamethod(game, "__index", function(Self, Key)
        if  not checkcaller() and Self:IsA("BasePart") and Key == "Position" and Self.Name ~= "ReplayBall"  then
            return Vector3.new(math.random(1,500),math.random(1,500),math.random(1,500))
                end
         return old(Self,Key)
end)

ball = function()
    for i,v in pairs(workspace:GetChildren()) do
        if v.Name:match("Football") and v:FindFirstChild("Mesh") then
            return v
        end
    end
end

uis.InputBegan:Connect(function(key,gp)
    if gp then return end

    if key.UserInputType == Enum.UserInputType.MouseButton1 then
        for i = 1,45 do wait()
        if ball() ~= nil and game:GetService('Players').LocalPlayer.Character:FindFirstChild('Humanoid') and _G.On then
            ball().CanCollide = false
            ball().CFrame = CFrame.new(game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position)
            ball().Size = Vector3.new(10,10,10)
            end
        end
    end
end)
end)





Mags:NewButton("Blatant Mags Off",function()
local uis = game:GetService('UserInputService')
local old = nil


_G.On = false -- turn to true to turn on, false to turn it off


 
old = hookmetamethod(game, "__index", function(Self, Key)
        if  not checkcaller() and Self:IsA("BasePart") and Key == "Position" and Self.Name ~= "ReplayBall"  then
            return Vector3.new(math.random(1,500),math.random(1,500),math.random(1,500))
                end
         return old(Self,Key)
end)

ball = function()
    for i,v in pairs(workspace:GetChildren()) do
        if v.Name:match("Football") and v:FindFirstChild("Mesh") then
            return v
        end
    end
end

uis.InputBegan:Connect(function(key,gp)
    if gp then return end

    if key.UserInputType == Enum.UserInputType.MouseButton1 then
        for i = 1,45 do wait()
        if ball() ~= nil and game:GetService('Players').LocalPlayer.Character:FindFirstChild('Humanoid') and _G.On then
            ball().CanCollide = false
            ball().CFrame = CFrame.new(game:GetService('Players').LocalPlayer.Character:FindFirstChild('HumanoidRootPart').Position)
            ball().Size = Vector3.new(10,10,10)
            end
        end
    end
end)
end)



-- Misc


local Misc = lib:NewTab("Misc", "")


Misc:NewButton("Destroy Gui",function()
    game:GetService("CoreGui"):WaitForChild("ScriptedUI"):Destroy()

end)
