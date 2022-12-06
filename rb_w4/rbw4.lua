local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local Shooting = {}

do
    Shooting.Enabled = false 
    Shooting.Threshold = 95 

    function Shooting:GetBar()
        local Character = Players.LocalPlayer.Character 
        local MainGameplayScript = Character and Character:FindFirstChild("ShotMeterUI")
        local ShotBar = MainGameplayScript and MainGameplayScript:FindFirstChild("Meter") and MainGameplayScript:FindFirstChild("Meter"):FindFirstChild("Bar")
    
        return ShotBar
    end

    function Shooting:Is0()
        local Amount = self:GetBar() and self:GetBar().AbsoluteSize.Y

        if Amount and Amount > self.Threshold and self.Enabled then 
            return true 
        end
    end 

    game:GetService("RunService").RenderStepped:Connect(function()
        if Shooting:Is0() then
            keyrelease(0x45)
        end
    end)
end


local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/wally-rblx/LinoriaLib/main/Library.lua"))()
local Window = Library:CreateWindow({
	Title = "RB World 4",
	Center = true, 
	AutoShow = true 
})

local Tabs = {
	Shooting = Window:AddTab("Shooting"),
}

local GroupBoxes = {
	Shooting = {
		AutoTimer = Tabs.Shooting:AddLeftGroupbox("Auto Timer"),
	},
}
GroupBoxes.Shooting.AutoTimer:AddToggle("EnableShotTimer", {
    Text = "Enabled",
    Default = false,
    Tooltip = "Hold E and it will autotime the shot at your threshold."
})

Toggles.EnableShotTimer:OnChanged(function()
    Shooting.Enabled = Toggles.EnableShotTimer.Value 
end)


GroupBoxes.Shooting.AutoTimer:AddSlider("ShotTimerThreshold", {
    Text = "Threshold",
    Default = Shooting.Threshold,
    Min = 1,
    Max = 100,
    Rounding = 1,
    Compact = false 
})

Options.ShotTimerThreshold:OnChanged(function()
    Shooting.Threshold = Options.ShotTimerThreshold.Value 
end)

