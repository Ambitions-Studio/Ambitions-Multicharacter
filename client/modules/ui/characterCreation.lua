local pedConfig = require('@ambitions.config.peds')

local function ShowCharacterCreator()
    SetNuiFocus(true, true)

    local pedsToSend = {}

    for _, pedModel in ipairs(pedConfig.pedList.basics) do
        table.insert(pedsToSend, {
            title = pedModel,
            value = pedModel,
            category = 'Basics'
        })
    end

    if pedConfig.authorizePedwhileInCreator then
        for _, pedModel in ipairs(pedConfig.pedList.peds) do
            table.insert(pedsToSend, {
                title = pedModel,
                value = pedModel,
                category = 'Peds'
            })
        end
    end

    SendNUIMessage({
        action = "showCharacterCreator",
        config = {
            authorizePedwhileInCreator = pedConfig.authorizePedwhileInCreator,
            pedModels = pedsToSend
        }
    })
end

local function HideCharacterCreator()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "hideCharacterCreator"
    })
end

RegisterCommand("charactercreator", function()
    ShowCharacterCreator()
end, false)

RegisterCommand("hidecharcreator", function()
    HideCharacterCreator()
end, false)

RegisterNUICallback("closeCharacterCreator", function(data, cb)
    HideCharacterCreator()
    cb("ok")
end)

RegisterNUICallback("createCharacter", function(data, cb)
    print("Character creation data received:", json.encode(data))
    cb("ok")
end)