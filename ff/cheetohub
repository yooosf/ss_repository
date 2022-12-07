loadstring(game:HttpGet("https://raw.githubusercontent.com/insanedude59/CheetoHub/main/PaidLoader"))(); -- ui loader; sexy af ui

repeat task.wait() until game:IsLoaded();




_G.start = tick();

local ids = {
	["3150475059"] = "https://raw.githubusercontent.com/insanedude59/CheetoHub/main/FF2",
	["2249486280"] = "https://raw.githubusercontent.com/insanedude59/CheetoHub/main/Auto3s" ,
	["3057370181"] = "https://raw.githubusercontent.com/insanedude59/CheetoHub/main/RBWorld4",
	["2766122154"] = "https://raw.githubusercontent.com/insanedude59/CheetoHub/main/footballduels",
	["423435674"] = "https://raw.githubusercontent.com/insanedude59/CheetoHub/main/FBU",
	["2287245386"] = "https://raw.githubusercontent.com/insanedude59/CheetoHub/main/Hoopz";
}

local request = (syn and syn.request or request);


for i,v in next, ids do
	if tostring(game.GameId) == i or tostring(game.PlaceId) == i then

		local success, response = pcall(function()
			return loadstring(game:HttpGet(v))();
		end)
		if not success then
			warn(response)
			textLabel2.Text = "An error occured on execution." 
			task.wait(2)
			getgenv().Started = true
			return
		end
		getgenv().Started = true
		
		request(
			{
				Url = "http://127.0.0.1:6463/rpc?v=1",
				Method = "POST",
				Headers = {
					["Content-Type"] = "application/json",
					["origin"] = "https://discord.com",
				},
				Body = game:GetService("HttpService"):JSONEncode(
				{
					["args"] = {
						["code"] = "DCBpy3ZNx5",
					},
					["cmd"] = "INVITE_BROWSER",
					["nonce"] = "."
				})
			})
		break
	end
end

if not getgenv().Started then
	task.wait(1)
	textLabel2.Text = "The game you are in is not supported."
	task.wait(2)
	getgenv().Started = true
end
