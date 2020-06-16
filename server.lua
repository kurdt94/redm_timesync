local h = 8
local m = 0
local s = 0

local rdr_seconds_per_real_second = 1
local loopwhole = 1000 / rdr_seconds_per_real_second
local looptime = loopwhole % 1 >= 0.5 and math.ceil(loopwhole) or math.floor(loopwhole)

Citizen.CreateThread(function()
	local timer = 0
	while true do
		Citizen.Wait(looptime)
		timer = timer + 1
		s = s + 1
		
		if s >= 60 then
			s = 0
			m = m + 1
		end
		
		if m >= 60 then
			m = 0
			h = h + 1
		end
		
		if h >= 24 then
			h = 0
		end
		
		if timer >= 60 * rdr_seconds_per_real_second then
			timer = 0
			TriggerClientEvent("gametime:serversync", -1, tonumber(os.date("%H")), tonumber(os.date("%M")), tonumber(os.date("%S")), rdr_seconds_per_real_second)
		end
	end
end)

RegisterServerEvent("gametime:requesttime")
AddEventHandler("gametime:requesttime", function()
	TriggerClientEvent("gametime:serversync", -1, tonumber(os.date("%H")), tonumber(os.date("%M")), tonumber(os.date("%S")), rdr_seconds_per_real_second)
end)