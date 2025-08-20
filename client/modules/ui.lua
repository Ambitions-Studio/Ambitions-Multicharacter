local function ShowCharacterSelection()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "showCharacterSelection"
    })
end

local function HideCharacterSelection()
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "hideCharacterSelection"
    })
end

RegisterCommand("character", function()
    ShowCharacterSelection()
end, false)

RegisterCommand("hidechar", function()
    HideCharacterSelection()
end, false)

RegisterNUICallback("closeCharacterSelection", function(data, cb)
    HideCharacterSelection()
    cb("ok")
end)