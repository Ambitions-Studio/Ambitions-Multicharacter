local activeCam = nil

--- Create and setup a camera focused on the player ped
---@param ped number The player ped entity
---@param offsetX number Camera offset on X axis
---@param offsetY number Camera offset on Y axis
---@param offsetZ number Camera offset on Z axis
---@param transitionTime number Transition time in milliseconds
---@return number cam The created camera handle
local function CreateCharacterSelectionCamera(ped, offsetX, offsetY, offsetZ, transitionTime)
  if activeCam then
    DestroyCam(activeCam, false)
  end

  local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
  local camOffset = GetOffsetFromEntityInWorldCoords(ped, offsetX, offsetY, offsetZ)

  SetCamCoord(cam, camOffset.x, camOffset.y, camOffset.z)
  PointCamAtEntity(cam, ped, 0.0, 0.0, 0.0, true)
  SetCamActive(cam, true)
  RenderScriptCams(true, true, transitionTime, true, false)

  activeCam = cam

  return cam
end

--- Destroy the active camera and return to gameplay camera
---@param transitionTime number Transition time in milliseconds
local function DestroyActiveCamera(transitionTime)
  if activeCam then
    RenderScriptCams(false, true, transitionTime, true, false)
    DestroyCam(activeCam, false)
    activeCam = nil
  end
end

--- Get the current active camera handle
---@return number|nil cam The active camera handle or nil
local function GetActiveCamera()
  return activeCam
end

--- Offset camera for character creation UI (positions ped on right 2/3 of screen)
---@param ped number The player ped entity
---@param transitionTime number Transition time in milliseconds
---@return number cam The created camera handle
local function OffsetCameraForCreation(ped, transitionTime)
  if activeCam then
    DestroyCam(activeCam, false)
  end

  local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)

  -- Offset camera to the left so ped appears on right side
  -- X = left/right, Y = forward/back, Z = up/down
  local camOffset = GetOffsetFromEntityInWorldCoords(ped, -0.8, 1.0, 0.65)

  SetCamCoord(cam, camOffset.x, camOffset.y, camOffset.z)
  PointCamAtEntity(cam, ped, 0.0, 0.0, 0.65, true)
  SetCamActive(cam, true)
  RenderScriptCams(true, true, transitionTime or 1000, true, false)

  activeCam = cam

  return cam
end

return {
  CreateCharacterSelectionCamera = CreateCharacterSelectionCamera,
  DestroyActiveCamera = DestroyActiveCamera,
  GetActiveCamera = GetActiveCamera,
  OffsetCameraForCreation = OffsetCameraForCreation,
}
