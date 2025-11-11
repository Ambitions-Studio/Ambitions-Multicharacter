local isPanning = false
local isRotating = false
local lastMouseX = 0
local lastMouseY = 0
local armsUpActive = false

--- Start camera control
---@param controlType string Type of control: 'pan' or 'rotate'
function StartCameraControl(controlType)
  if controlType == 'pan' then
    isPanning = true
  elseif controlType == 'rotate' then
    isRotating = true
  end
end

--- Stop camera control
---@param controlType string Type of control: 'pan' or 'rotate'
function StopCameraControl(controlType)
  if controlType == 'pan' then
    isPanning = false
  elseif controlType == 'rotate' then
    isRotating = false
  end
end

--- Handle camera/ped movement
---@param controlType string Type of control: 'pan' or 'rotate'
---@param movementX number Mouse movement on X axis
---@param movementY number Mouse movement on Y axis
function HandleCameraMove(controlType, movementX, movementY)
  local activeCam = GetActiveCamera()
  if not activeCam then
    return
  end

  if controlType == 'pan' and isPanning then
    local camPos = GetCamCoord(activeCam)
    local camRot = GetCamRot(activeCam, 2)

    local sensitivity = 0.002

    local heading = math.rad(camRot.z)
    local rightX = math.cos(heading)
    local rightY = math.sin(heading)

    local newX = camPos.x - (rightX * movementX * sensitivity)
    local newY = camPos.y - (rightY * movementX * sensitivity)
    local newZ = camPos.z + (movementY * sensitivity)

    SetCamCoord(activeCam, newX, newY, newZ)

  elseif controlType == 'rotate' and isRotating then
    local ped = PlayerPedId()
    local currentHeading = GetEntityHeading(ped)

    local sensitivity = 0.5

    local newHeading = currentHeading - (movementX * sensitivity)

    SetEntityHeading(ped, newHeading)
  end
end

RegisterNetEvent('ambitions-multicharacter:client:cameraControlStart', function(controlType)
  StartCameraControl(controlType)
end)

RegisterNetEvent('ambitions-multicharacter:client:cameraControlStop', function(controlType)
  StopCameraControl(controlType)
end)

RegisterNetEvent('ambitions-multicharacter:client:cameraControlMove', function(controlType, movementX, movementY)
  HandleCameraMove(controlType, movementX, movementY)
end)

--- Toggle arms up animation
function ToggleArmsUp()
  local ped = PlayerPedId()

  if not armsUpActive then
    RequestAnimDict('random@mugging3')
    while not HasAnimDictLoaded('random@mugging3') do
      Wait(100)
    end

    TaskPlayAnim(ped, 'random@mugging3', 'handsup_standing_base', 8.0, -8.0, -1, 50, 0, false, false, false)
    armsUpActive = true
  else
    ClearPedTasks(ped)
    armsUpActive = false
  end
end

RegisterNetEvent('ambitions-multicharacter:client:toggleArmsUp', function()
  ToggleArmsUp()
end)

--- Handle camera zoom towards mouse position
---@param zoomIn boolean True to zoom in, false to zoom out
---@param mouseX number Normalized mouse X position (0-1)
---@param mouseY number Normalized mouse Y position (0-1)
function HandleCameraZoom(zoomIn, mouseX, mouseY)
  local activeCam = GetActiveCamera()
  if not activeCam then
    return
  end

  local camPos = GetCamCoord(activeCam)
  local camRot = GetCamRot(activeCam, 2)

  local pitch = math.rad(camRot.x)
  local yaw = math.rad(camRot.z)

  local forwardX = -math.sin(yaw) * math.cos(pitch)
  local forwardY = math.cos(yaw) * math.cos(pitch)
  local forwardZ = math.sin(pitch)

  local zoomAmount = zoomIn and 0.1 or -0.1

  local newX = camPos.x + (forwardX * zoomAmount)
  local newY = camPos.y + (forwardY * zoomAmount)
  local newZ = camPos.z + (forwardZ * zoomAmount)

  SetCamCoord(activeCam, newX, newY, newZ)
end

RegisterNetEvent('ambitions-multicharacter:client:cameraZoom', function(zoomIn, mouseX, mouseY)
  HandleCameraZoom(zoomIn, mouseX, mouseY)
end)