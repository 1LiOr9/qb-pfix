local QBCore = exports['qb-core']:GetCoreObject()


RegisterCommand(Config.Command, function()
    for k,v in pairs(Config.PoliceJobs) do 
        local dist = #(GetEntityCoords(PlayerPedId())-vector3(439.83392, -1016.893, 28.726852))
        if dist < 45 then
            local Player = QBCore.Functions.GetPlayerData()
            if Player.job.name == v then 
                if IsPedInAnyVehicle(PlayerPedId()) then 
                    FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId()), true)
                    QBCore.Functions.Progressbar('fixing', Config.Progressbar, Config.ProgressbarTime, Config.useWhileDead , Config.canCancel, { -- Name | Label | Time | useWhileDead | canCancel
                        disableMovement = true,
                        disableCarMovement = true,
                        disableMouse = true,
                        disableCombat = true,
                    }, {
                        animDict = 'No Emote',
                        anim = 'No Anim',
                        flags = 16,
                    }, {}, {}, function() -- Play When Done
                        veh = GetVehiclePedIsIn(PlayerPedId())
                        SetVehicleFixed(veh)
                        SetVehicleDirtLevel(veh, 0)


                        QBCore.Functions.Notify("Vehicle Fixed!", "success", 7500)
                        FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId()), false)

                    end, function() -- Play When Cancel
                        FreezeEntityPosition(GetVehiclePedIsIn(PlayerPedId()), false)
                    end)
                else 
                    QBCore.Functions.Notify(Config.NoVehicle, 'error', 4500)
                end
            else
                QBCore.Functions.Notify(Config.NotPolice, 'error', 7500)
            end
        else 
             QBCore.Functions.Notify(Config.Location, "error", 7500)
        end
    end
end)
