local activeCam = nil

--- Create and setup a camera at a position relative to the player ped
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

  -- Set camera rotation (200 degrees to the right)
  local pedHeading = GetEntityHeading(ped)
  local camRotation = pedHeading + 200.0
  SetCamRot(cam, 0.0, 0.0, camRotation, 2)

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

return {
  CreateCharacterSelectionCamera = CreateCharacterSelectionCamera,
  DestroyActiveCamera = DestroyActiveCamera,
  GetActiveCamera = GetActiveCamera,
}
