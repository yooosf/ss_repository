getgenv().SpoofedValues = {
    ["Acceleration"] = 0.5
    ["GuardSpeed"] = 16
}

local Players = game:GetService("Players")
local Client = Players.LocalPlayer
local Character = Client.Character or Client.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local Skills = Character:WaitForChild("Skills")

local old; old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local arguments = {...}
    
    if (self == Humanoid or self == Skills) and string.lower(getnamecallmethod()) == "getattribute" then 
        local name = arguments[1]
        local value = self.GetAttribute(self, name)
        
        return SpoofedValues[name] or value
    end
    
    if (self == Character) and string.lower(getnamecallmethod()) == "breakjoints" then
        return nil
    end

    if tostring(self) == "ClientAction" and arguments[1] == "Report" then
        return nil 
    end
    
    return old(self, ...)
end))
