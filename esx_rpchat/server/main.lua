ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(1000)
	end
end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	
	if result[1] ~= nil then
		
		local identity = result[1]

		return {
			
			identifier = identity['identifier'],
			
			firstname = identity['firstname'],
			
			lastname = identity['lastname'],
			
			job = identity['job'],
			
			dateofbirth = identity['dateofbirth'],
			
			sex = identity['sex'],
			
			height = identity['height'],
			
			permission_level = identity['permission_level']
		}
	else
		return nil
	end
end

RegisterCommand('oop', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	local playerped = GetPlayerPed(source)
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, 'oop', args, name)
end, false)


RegisterCommand('msg', function(source, args, rawCommand)
	if source == 0 then
		return
	end
	
	if tonumber(args[1]) and args[2] then

		local id=tonumber(args[1])
	
		msg = table.concat(args, ' ', 2)
	 
		local name =  GetPlayerName(source)

		local nombre =  GetPlayerName(id)
	
		local characterName = GetCharacterName(source)
	
		name = '' .. source .. ' '.. name
	
		local xPlayers = ESX.GetPlayers()
	
		local target = ESX.GetPlayerFromId(id)

		if(target ~= nil) then
	   
			TriggerClientEvent('chat:addMessage', id, {
				template = '<div style="font-size: 1.35vh; border-radius: 3px;"><i class="far fa-comments"></i> <b> <b style=color:#5dc91e>MSG |<b style=color:#5dc91e> ID {1}:<b style=color:#ffffff> {2}  </br></div>',
				args = { fal, name, msg }
			})
			TriggerClientEvent('chat:addMessage', source, {
				template = '<div style="font-size: 1.35vh; border-radius: 3px;"><i class="far fa-comments"></i> <b> <b style=color:#5dc91e>MSG |<b style=color:#5dc91e> ID {1}:<b style=color:#ffffff> {2}  </br></div>',
				args = { fal, name, msg }
			})
		else
			TriggerClientEvent('ESX:showNotification', source, "Esta ID no corresponde a ning??n usuario activo.")
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = { '^3[RMZ]', ' No est??s usuando el comando de la forma adecuada.' } })
	end
end, false)

RegisterCommand('ayuda', function(source, args, rawCommand)
	if source == 0 then
		return
	end
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.DisableESXIdentity then name = GetCharacterName(source) end
    TriggerClientEvent('chat:addMessage', source, { args = { _U('a_prefix', source, name), args }, color = { 255, 242, 0 } })
	
end, false)


RegisterCommand('id', function(source, args, rawCommand)
    if source == 0 then
        return
    end
    args = table.concat(args, ' ')
    local name = GetPlayerName(source)
    if Config.DisableESXIdentity then name = GetCharacterName(source) end
    TriggerClientEvent('chat:addMessage', source, { args = { _U('id_prefix', source, name), args }, color = { 114, 228, 237 } })
end, false)

RegisterCommand('taxi', function(source, args, rawCommand)
	if source == 0 then
		return
	end
	local target = ESX.GetPlayerFromId(source)
	if target.job ~= nil and target.job.name == "taxi" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end
		TriggerClientEvent('chat:addMessage', -1, { args = { _U('taxi_prefix', name), args }, color = { 255, 227, 51 } })
	end
end, false)

RegisterCommand('meca', function(source, args, rawCommand)
	if source == 0 then
		return
	end
	local target = ESX.GetPlayerFromId(source)
	if target.job ~= nil and target.job.name == "mechanic" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end
		TriggerClientEvent('chat:addMessage', -1, { args = { _U('meca_prefix', name), args }, color = { 160, 160, 160 } })
	end
end, false)

RegisterCommand('pol', function(source, args, rawCommand)
	if source == 0 then
		return
	end
	local target = ESX.GetPlayerFromId(source)
	if target.job ~= nil and target.job.name == "police" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end
		TriggerClientEvent('chat:addMessage', -1, { args = { _U('pol_prefix', name), args }, color = { 0, 102, 255 } })
	end
end, false)

RegisterCommand('ems', function(source, args, rawCommand)
	if source == 0 then
		return
	end
	local target = ESX.GetPlayerFromId(source)
	if target.job ~= nil and target.job.name == "ambulance" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end
		TriggerClientEvent('chat:addMessage', -1, { args = { _U('ems_prefix', name), args }, color = { 255, 0, 0 } })
	end
end, false)

RegisterCommand('badu', function(source, args, rawCommand)
	if source == 0 then
		return
	end
	local target = ESX.GetPlayerFromId(source)
	if target.job ~= nil and target.job.name == "badulake" then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		if Config.EnableESXIdentity then name = GetCharacterName(source) end
		TriggerClientEvent('chat:addMessage', -1, { args = { _U('badu_prefix', name), args }, color = { 255, 0, 0 } })
	end
end, false)

RegisterCommand('rbadu', function(source, args, rawCommand)
    if source == 0 then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.job.name == "badulake" then
        args = table.concat(args, ' ')
        local name = GetPlayerName(source)
        if Config.EnableESXIdentity then name = GetCharacterName(source) end
        for k,v in ipairs(ESX.GetPlayers()) do
            local p = ESX.GetPlayerFromId(v)
            if p.job.name == "badulake" then
                TriggerClientEvent('chat:addMessage', source, { args = { _U('rbadu_prefix', name), args }, color = { 255, 0, 0	 } })
            end
        end
    end
end, false)

RegisterCommand('rpol', function(source, args, rawCommand)
    if source == 0 then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.job.name == "police" then
        args = table.concat(args, ' ')
        local name = GetPlayerName(source)
        if Config.EnableESXIdentity then name = GetCharacterName(source) end
        for k,v in ipairs(ESX.GetPlayers()) do
            local p = ESX.GetPlayerFromId(v)
            if p.job.name == "police" then
                TriggerClientEvent('chat:addMessage', source, { args = { _U('rpol_prefix', name), args }, color = { 0, 102, 255 } })
            end
        end
    end
end, false)

RegisterCommand('rtaxi', function(source, args, rawCommand)
    if source == 0 then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.job.name == "taxi" then
        args = table.concat(args, ' ')
        local name = GetPlayerName(source)
        if Config.EnableESXIdentity then name = GetCharacterName(source) end
        for k,v in ipairs(ESX.GetPlayers()) do
            local p = ESX.GetPlayerFromId(v)
            if p.job.name == "taxi" then
                TriggerClientEvent('chat:addMessage', source, { args = { _U('rtaxi_prefix', name), args }, color = { 255, 242, 0 } })
            end
        end
    end
end, false)

RegisterCommand('rems', function(source, args, rawCommand)
    if source == 0 then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.job.name == "ambulance" then
        args = table.concat(args, ' ')
        local name = GetPlayerName(source)
        if Config.EnableESXIdentity then name = GetCharacterName(source) end
        for k,v in ipairs(ESX.GetPlayers()) do
            local p = ESX.GetPlayerFromId(v)
            if p.job.name == "ambulance" then
                TriggerClientEvent('chat:addMessage', source, { args = { _U('rems_prefix', name), args }, color = { 255, 51, 51 } })
            end
        end
    end
end, false)

RegisterCommand('rmeca', function(source, args, rawCommand)
    if source == 0 then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
        if xPlayer.job.name == "mechanic" then
        args = table.concat(args, ' ')
        local name = GetPlayerName(source)
        if Config.EnableESXIdentity then name = GetCharacterName(source) end
        for k,v in ipairs(ESX.GetPlayers()) do
            local p = ESX.GetPlayerFromId(v)
            if p.job.name == "mechanic" then
                TriggerClientEvent('chat:addMessage', source, { args = { _U('rmeca_prefix', name), args }, color = { 160, 160, 160 } })
            end
        end
    end
end, false)

RegisterCommand('me', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	local playerped = GetPlayerPed(source)
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, 'me', args, name)
end, false)

RegisterCommand('do', function(source, args, rawCommand)
	if source == 0 then
		print('esx_rpchat: you can\'t use this command from rcon!')
		return
	end
	args = table.concat(args, ' ')
	local name = GetPlayerName(source)
	if Config.EnableESXIdentity then name = GetCharacterName(source) end
	TriggerClientEvent('esx_rpchat:sendProximityMessage', -1, source, 'do', args, name)
end, false)

RegisterCommand('intentar', function(source, args, user)
    local name = GetPlayerName(source)
    num = math.random(1, 2)
    TriggerClientEvent("sendProximityMessageRoll", -1, source, name, num, table.concat(args, " "))
  end, false)

  RegisterCommand('dados', function(source, args, user)
    local name = GetPlayerName(source)
    num = math.random(1, 6)
    TriggerClientEvent("sendProximityMessageRoll", -1, source, name, num, table.concat(args, " "))
  end, false)
  --SISTEMA DADOS
  function stringsplit(inputstr, sep)
	  if sep == nil then
		  sep = "%s"
	  end
	  local t={} ; i=1
	  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		  t[i] = str
		  i = i + 1
	  end
	  return t
  end

RegisterCommand('rstaff', function(source, args, rawCommand)
    if source == 0 then
        return
	end
	local xPlayer = ESX.GetPlayerFromId(source)
		if xPlayer.getGroup() == 'superadmin' or xPlayer.getGroup() == 'admin' or xPlayer.getGroup() == 'mod' then
		args = table.concat(args, ' ')
		local name = GetPlayerName(source)
		for k,v in ipairs(ESX.GetPlayers()) do
			local p = ESX.GetPlayerFromId(v)
			if p.getGroup() == "superadmin" or p.getGroup() == "admin" or p.getGroup() == "mod" then
				TriggerClientEvent('chat:addMessage', v, { args = { 'ADMINISTRACI??N  | ' .. name, args }, color = { 255, 0, 76 } })
			end
        end
    end
end, false)

function GetCharacterName(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})
	if result[1] and result[1].firstname and result[1].lastname then
		if Config.OnlyFirstname then
			return result[1].firstname
		else
			return ('%s %s'):format(result[1].firstname, result[1].lastname)
		end
	else
		return GetPlayerName(source)
	end
end

