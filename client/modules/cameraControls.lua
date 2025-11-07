local cameraModule = require('client.modules.camera')
local ambitionsPrint = require('Ambitions.shared.lib.log.print')

ambitionsPrint.info('Camera controls module loaded')

local isPanning = false
local isRotating = false
local lastMouseX = 0
local lastMouseY = 0
local armsUpActive = false

--- Start camera control
---@param controlType string Type of control: 'pan' or 'rotate'
local function StartCameraControl(controlType)
  if controlType == 'pan' then
    isPanning = true
    ambitionsPrint.info('Camera panning started')
  elseif controlType == 'rotate' then
    isRotating = true
    ambitionsPrint.info('Ped rotation started')
  end
end

--- Stop camera control
---@param controlType string Type of control: 'pan' or 'rotate'
local function StopCameraControl(controlType)
  if controlType == 'pan' then
    isPanning = false
    ambitionsPrint.info('Camera panning stopped')
  elseif controlType == 'rotate' then
    isRotating = false
    ambitionsPrint.info('Ped rotation stopped')
  end
end

--- Handle camera/ped movement
---@param controlType string Type of control: 'pan' or 'rotate'
---@param movementX number Mouse movement on X axis
---@param movementY number Mouse movement on Y axis
local function HandleCameraMove(controlType, movementX, movementY)
  local activeCam = cameraModule.GetActiveCamera()
  if not activeCam then
    return
  end

  if controlType == 'pan' and isPanning then
    -- Pan camera (move left/right, up/down without rotating)
    local camPos = GetCamCoord(activeCam)
    local camRot = GetCamRot(activeCam, 2)

    -- Sensitivity for panning
    local sensitivity = 0.002

    -- Calculate camera's right vector (perpendicular to forward)
    local heading = math.rad(camRot.z)
    local rightX = math.cos(heading)
    local rightY = math.sin(heading)

    -- Move camera along its right axis (left/right) and up/down (Z axis)
    local newX = camPos.x + (rightX * movementX * sensitivity)
    local newY = camPos.y + (rightY * movementX * sensitivity)
    local newZ = camPos.z + (movementY * sensitivity)

    SetCamCoord(activeCam, newX, newY, newZ)

  elseif controlType == 'rotate' and isRotating then
    -- Rotate ped on himself
    local ped = PlayerPedId()
    local currentHeading = GetEntityHeading(ped)

    -- Sensitivity for rotation
    local sensitivity = 0.5

    -- Rotate based on horizontal mouse movement
    local newHeading = currentHeading - (movementX * sensitivity)

    SetEntityHeading(ped, newHeading)
  end
end

-- Register events
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
local function ToggleArmsUp()
  local ped = PlayerPedId()

  if not armsUpActive then
    -- Play arms up animation
    RequestAnimDict('random@mugging3')
    while not HasAnimDictLoaded('random@mugging3') do
      Wait(100)
    end

    TaskPlayAnim(ped, 'random@mugging3', 'handsup_standing_base', 8.0, -8.0, -1, 50, 0, false, false, false)
    armsUpActive = true
    ambitionsPrint.success('Arms up animation started')
  else
    -- Stop animation
    ClearPedTasks(ped)
    armsUpActive = false
    ambitionsPrint.success('Arms up animation stopped')
  end
end

RegisterNetEvent('ambitions-multicharacter:client:toggleArmsUp', function()
  ToggleArmsUp()
end)

return {
  StartCameraControl = StartCameraControl,
  StopCameraControl = StopCameraControl,
  HandleCameraMove = HandleCameraMove,
  ToggleArmsUp = ToggleArmsUp,
}
