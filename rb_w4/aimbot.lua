--[[
getgenv().pings = {
    {Ping = 40, Timing = .5};
    {Ping = 60, Timing = .45};
    {Ping = 80, Timing = .4};
    {Ping = 100, Timing = .35};
    {Ping = 120, Timing = .3};
    {Ping = 140, Timing = .2};
    {Ping = 160, Timing = .2};
    {Ping = 180, Timing = .17};
    {Ping = 200, Timing = .15};
    {Ping = 220, Timing = .1};
}
]] -- jokes new update made these early like a bitch ??

getgenv().pings = {
    {Ping = 40, Timing = .6};
    {Ping = 60, Timing = .55};
    {Ping = 80, Timing = .55};
    {Ping = 100, Timing = .45};
    {Ping = 120, Timing = .4};
    {Ping = 140, Timing = .35};
    {Ping = 160, Timing = .3};
    {Ping = 180, Timing = .27};
    {Ping = 200, Timing = .25};
    {Ping = 220, Timing = .2};
}


local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/violin-suzutsuki/LinoriaLib/main/Library.lua"))()

local Aimbot = {}; do
    function Aimbot:GetPing()
        local Stats = game:GetService("Stats")
        local Network = Stats.Network

        return Network.ServerStatsItem["Data Ping"]:GetValue()
    end

    function Aimbot:GetBenchmark()
        local Timing, CurrentPing = nil, self:GetPing()

        for _, data in ipairs(pings) do
            if CurrentPing > data.Ping then 
                Timing = data.Timing
            end
        end

        return Timing or pings[1].Timing
    end 

    function Aimbot:GetMeterGUI()
        local Players = game:GetService("Players")
        local Client = Players.LocalPlayer
        local Character = Client.Character 

        if Character then
            local ShotMeterUI = Character:FindFirstChild("ShotMeterUI")

            if ShotMeterUI then 
                return ShotMeterUI:FindFirstChild("Meter"):FindFirstChild("Bar")
            end
        end
    end


    function Aimbot:Startup()
        self.LastNotified = 0 

        game:GetService("RunService").RenderStepped:Connect(function()
            local MeterGUI, Benchmark = self:GetMeterGUI(), self:GetBenchmark()

            if MeterGUI and Benchmark and game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.E) then
                if MeterGUI.Size.Y.Scale >= Benchmark then
                    keyrelease(0x45)
                        
                    if tick() - self.LastNotified > 2 then
                        Library:Notify("Released at " .. tostring(self:GetPing()) .. "\nBenchmark: " .. tostring(Benchmark))
                        self.LastNotified = tick()
                    end
                end
            end
        end)
    end
end; Aimbot:Startup()
