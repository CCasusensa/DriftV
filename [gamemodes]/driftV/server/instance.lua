local playersInstance = {}
local pInstance = {}

for i = 1,63 do
    playersInstance[i] = 0
end

function SetPlayerInstance(source, instance)
    SetPlayerRoutingBucket(source, tonumber(instance))
    pInstance[source] = tonumber(instance)
end

RegisterNetEvent("drift:ChangeServerInstance")
AddEventHandler("drift:ChangeServerInstance", function(instance)
    if pInstance[source] == nil then
        pInstance[source] = 0
    end

    SetPlayerInstance(source, instance)
end)

RegisterNetEvent("drift:GetServerInstance")
AddEventHandler("drift:GetServerInstance", function()
    TriggerClientEvent("drift:GetServerInstance", source, playersInstance)
end)

Citizen.CreateThread(function()
    while true do
        for i = 1,63 do
            playersInstance[i] = 0
        end

        for k,v in pairs(pInstance) do
            if GetPlayerPing(k) == 0 then
                pInstance[k] = nil
            else
                if playersInstance[pInstance[k]] == nil then
                    playersInstance[pInstance[k]] = 0
                end
                playersInstance[pInstance[k]] = playersInstance[pInstance[k]] + 1
            end
        end
        Wait(5000)
    end
end)