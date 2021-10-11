local CoralTypes = {
    ["dendrogyra_coral"] = math.random(70, 100),
    ["antipatharia_coral"] = math.random(50, 70)
}

-- Code

RegisterServerEvent('qb-airlines:server:SetBerthVehicle')
AddEventHandler('qb-airlines:server:SetBerthVehicle', function(BerthId, vehicleModel)
    TriggerClientEvent('qb-airlines:client:SetBerthVehicle', -1, BerthId, vehicleModel)

    QBBoatshop.Locations["berths"][BerthId]["boatModel"] = boatModel
end)

RegisterServerEvent('qb-airlines:server:SetDockInUse')
AddEventHandler('qb-airlines:server:SetDockInUse', function(BerthId, InUse)
    QBBoatshop.Locations["berths"][BerthId]["inUse"] = InUse
    TriggerClientEvent('qb-airlines:client:SetDockInUse', -1, BerthId, InUse)
end)

QBCore.Functions.CreateCallback('qb-airlines:server:GetBusyDocks', function(source, cb)
    cb(QBBoatshop.Locations["berths"])
end)

RegisterServerEvent('qb-airlines:server:BuyBoat')
AddEventHandler('qb-airlines:server:BuyBoat', function(boatModel, BerthId)
    local BoatPrice = QBBoatshop.ShopBoats[boatModel]["price"]
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local PlayerMoney = {
        cash = Player.PlayerData.money.cash,
        bank = Player.PlayerData.money.bank
    }
    local missingMoney = 0
    local plate = "QB" .. math.random(1000, 9999)

    if PlayerMoney.cash >= BoatPrice then
        Player.Functions.RemoveMoney('cash', BoatPrice, "bought-boat")
        TriggerClientEvent('qb-airlines:client:BuyBoat', src, boatModel, plate)
        InsertBoat(boatModel, Player, plate)
    elseif PlayerMoney.bank >= BoatPrice then
        Player.Functions.RemoveMoney('bank', BoatPrice, "bought-boat")
        TriggerClientEvent('qb-airlines:client:BuyBoat', src, boatModel, plate)
        InsertBoat(boatModel, Player, plate)
    else
        if PlayerMoney.bank > PlayerMoney.cash then
            missingMoney = (BoatPrice - PlayerMoney.bank)
        else
            missingMoney = (BoatPrice - PlayerMoney.cash)
        end
        TriggerClientEvent('QBCore:Notify', src, 'Not Enough Money, You Are Missing $' .. missingMoney .. '', 'error')
    end
end)

function InsertBoat(boatModel, Player, plate)
    exports.oxmysql:insert('INSERT INTO player_aircrafts (citizenid, model, plate) VALUES (?, ?, ?)',
        {Player.PlayerData.citizenid, boatModel, plate})
end

QBCore.Functions.CreateUseableItem("jerry_can", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)

    TriggerClientEvent("qb-airlines:client:UseJerrycan", source)
end)

RegisterServerEvent('qb-airlines:server:RemoveItem')
AddEventHandler('qb-airlines:server:RemoveItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem(item, amount)
end)

QBCore.Functions.CreateCallback('qb-airlines:server:GetMyBoats', function(source, cb, dock)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = exports.oxmysql:fetchSync('SELECT * FROM player_aircrafts WHERE citizenid = ? AND boathouse = ?',
        {Player.PlayerData.citizenid, dock})
    if result[1] ~= nil then
        cb(result)
    else
        cb(nil)
    end
end)

QBCore.Functions.CreateCallback('qb-airlines:server:GetDepotBoats', function(source, cb, dock)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = exports.oxmysql:fetchSync('SELECT * FROM player_aircrafts WHERE citizenid = ? AND state = ?',
        {Player.PlayerData.citizenid, 0})
    if result[1] ~= nil then
        cb(result)
    else
        cb(nil)
    end
end)

RegisterServerEvent('qb-airlines:server:SetBoatState')
AddEventHandler('qb-airlines:server:SetBoatState', function(plate, state, boathouse, fuel)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local result = exports.oxmysql:scalarSync('SELECT 1 FROM player_aircrafts WHERE plate = ?', {plate})
    if result ~= nil then
        exports.oxmysql:execute(
            'UPDATE player_aircrafts SET state = ?, boathouse = ?, fuel = ? WHERE plate = ? AND citizenid = ?',
            {state, boathouse, fuel, plate, Player.PlayerData.citizenid})
    end
end)