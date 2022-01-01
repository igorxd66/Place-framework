local NoClipActive = false
local NoClipEntity = nil
local NoClipScaleform = nil
NoClipSpeed = 1

Citizen.CreateThread(function()
  local isInArena = false
	AddEventHandler("areanas:isInArena", function(bool) 
		isInArena = bool 
	end)

  NoClipScaleform = setupScaleform("instructional_buttons")

  while true do
    if not isInArena then
      if IsControlJustPressed(1, config.controls.openKey) then
        NoClip()
      end
    else
      Citizen.Wait(250)
    end

    Citizen.Wait(0)
  end
end)

NoClip = function()
  NoClipActive = not NoClipActive

  if IsPedInAnyVehicle(PlayerPedId(), false) then
    NoClipEntity = GetVehiclePedIsIn(PlayerPedId(), false)
  else
    NoClipEntity = PlayerPedId()
  end

  SetEntityCollision(NoClipEntity, not NoClipActive, not NoClipActive)
  SetVehicleRadioEnabled(NoClipEntity, not NoClipActive)
  FreezeEntityPosition(NoClipEntity, NoClipActive) 

  if NoClipActive then
    Citizen.SetTimeout(0, function()
      local yoff, zoff

      while NoClipActive do
        yoff = 0.0
        zoff = 0.0

        if IsControlJustPressed(1, config.controls.changeSpeed) then
          NoClipSpeed = (NoClipSpeed + 1) % 8

          if NoClipSpeed == 0 then
            NoClipSpeed = 1
          end

          NoClipScaleform = setupScaleform("instructional_buttons")
        end

        DisableControls()

        if IsDisabledControlPressed(0, config.controls.goForward) then
          yoff = config.offsets.y
        end
        if IsDisabledControlPressed(0, config.controls.goBackward) then
          yoff = -config.offsets.y
        end
        if IsDisabledControlPressed(0, config.controls.goUp) then
          zoff = config.offsets.z
        end
        if IsDisabledControlPressed(0, config.controls.goDown) then
          zoff = -config.offsets.z
        end
        if IsDisabledControlPressed(0, config.controls.turnLeft) then
          SetEntityHeading(NoClipEntity, GetEntityHeading(NoClipEntity) + config.offsets.h)
        end
        if IsDisabledControlPressed(0, config.controls.turnRight) then
          SetEntityHeading(NoClipEntity, GetEntityHeading(NoClipEntity) - config.offsets.h)
        end

        local newPos = GetOffsetFromEntityInWorldCoords(NoClipEntity, 0.0, yoff * (config.speeds[NoClipSpeed].speed + 0.3), zoff * (config.speeds[NoClipSpeed].speed + 0.3))       
        SetEntityCoordsNoOffset(NoClipEntity, newPos.x, newPos.y, newPos.z, true, true, true)
        SetEntityVelocity(NoClipEntity, 0.0, 0.0, 0.0)
        
        DrawScaleformMovieFullscreen(NoClipScaleform)

        Citizen.Wait(0)
      end
    end)   
  end
end

function BigMapHandle(InVehicle, IsDriver)
	if UseBigMap and (((IsDriver or not OnlyDriver) and BigMapInVehicles and InVehicle and IsControlPressed(1, BigMapKeyInVehicle)) or (not InVehicle and IsControlPressed(1, BigMapKeyOnFoot))) then
		DisplayRadar(true)
		SetRadarBigmapEnabled(true, false)	
		Hide = true
	else
		if not InVehicle or (InVehicle and OnlyDriver and not IsDriver) then
			DisplayRadar(false)
		end
		SetRadarBigmapEnabled(false, false)
		Hide = false
	end
end

function _DrawRect(X, Y, W, H, R, G, B, A, L)
	SetUiLayer(L)
	DrawRect(X, Y, W, H, R, G, B, A)
end

function GetMinimapAnchor()
  local safezone = GetSafeZoneSize()
  local safezone_x = 1.0 / 20.0
  local safezone_y = 1.0 / 20.0
  local aspect_ratio = GetAspectRatio(0)
  local res_x, res_y = GetActiveScreenResolution()
  local xscale = 1.0 / res_x
  local yscale = 1.0 / res_y
  local Minimap = {}
  Minimap.width = xscale * (res_x / (4 * aspect_ratio))
  Minimap.height = yscale * (res_y / 5.674)
  Minimap.left_x = xscale * (res_x * (safezone_x * ((math.abs(safezone - 1.0)) * 10)))
  Minimap.bottom_y = 1.0 - yscale * (res_y * (safezone_y * ((math.abs(safezone - 1.0)) * 10)))
  Minimap.right_x = Minimap.left_x + Minimap.width
  Minimap.top_y = Minimap.bottom_y - Minimap.height
  Minimap.x = Minimap.left_x
  Minimap.y = Minimap.top_y
  Minimap.xunit = xscale
  Minimap.yunit = yscale
  return Minimap
end

function revivePed(ped)
	isDead = false

	NetworkResurrectLocalPlayer(GetEntityCoords(ped), false, false, false)
	SetPlayerInvincible(ped, false)
	ClearPedBloodDamage(ped)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

function drawRct(x,y,width,height,r,g,b,a)
	DrawRect(x + width/2, y + height/2, width, height, r, g, b, a)
end

function DrawTxt(text, x, y)
	--x = x - 0.1
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.4)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x, y)
end

function DrawText3DSecond(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.45, 0.45)
    SetTextFont(4)
    SetTextProportional(1) 
    SetTextColour(255, 0, 0, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.45, 0.45)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
end

function GetVehicleInDirection( entFrom, coordFrom, coordTo )
	local rayHandle = StartShapeTestCapsule( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 5.0, 10, entFrom, 7 )
    local _, _, _, _, vehicle = GetShapeTestResult( rayHandle )
    
    if ( IsEntityAVehicle( vehicle ) ) then 
        return vehicle
    end 
end

local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
      enum.destructor = nil
      enum.handle = nil
    end
  }
  
  local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
      local iter, id = initFunc()
      if not id or id == 0 then
        disposeFunc(iter)
        return
      end
      
      local enum = {handle = iter, destructor = disposeFunc}
      setmetatable(enum, entityEnumerator)
      
      local next = true
      repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
      until not next
      
      enum.destructor, enum.handle = nil, nil
      disposeFunc(iter)
    end)
  end
  
  function EnumerateObjects()
    return EnumerateEntities(FindFirstObject, FindNextObject, EndFindObject)
  end
  
  function EnumeratePeds()
    return EnumerateEntities(FindFirstPed, FindNextPed, EndFindPed)
  end
  
  function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
  end
  
  function EnumeratePickups()
    return EnumerateEntities(FindFirstPickup, FindNextPickup, EndFindPickup)
  end

--- nolcip
config = {
    controls = {
        -- [[Controls, list can be found here : https://docs.fivem.net/game-references/controls/]]
        openKey = 289, -- [[F2]]
        goUp = 85, -- [[Q]]
        goDown = 48, -- [[Z]]
        turnLeft = 34, -- [[A]]
        turnRight = 35, -- [[D]]
        goForward = 32,  -- [[W]]
        goBackward = 33, -- [[S]]
        changeSpeed = 21, -- [[L-Shift]]
    },

    speeds = {
        -- [[If you wish to change the speeds or labels there are associated with then here is the place.]]
        { label = "Bardzo wolno", speed = 0},
        { label = "Wolno", speed = 0.5},
        { label = "Normalnie", speed = 2},
        { label = "Szybko", speed = 4},
        { label = "Bardzo szybko", speed = 6},
        { label = "Ekstremalnie szybko", speed = 10},
        { label = "Ekstremalnie bardzo szybko", speed = 20},
        { label = "Maksymalna prędkość", speed = 25}
    },

    offsets = {
        y = 0.5, -- [[How much distance you move forward and backward while the respective button is pressed]]
        z = 0.2, -- [[How much distance you move upward and downward while the respective button is pressed]]
        h = 3, -- [[How much you rotate. ]]
    },

    -- [[Background colour of the buttons. (It may be the standard black on first opening, just re-opening.)]]
    bgR = 0, -- [[Red]]
    bgG = 0, -- [[Green]]
    bgB = 0, -- [[Blue]]
    bgA = 80, -- [[Alpha]]
}

function ButtonMessage(text)
    BeginTextCommandScaleformString("STRING")
    AddTextComponentScaleform(text)
    EndTextCommandScaleformString()
end

function Button(ControlButton)
    N_0xe83a3e3557a56640(ControlButton)
end

function setupScaleform(scaleform)

    local scaleform = RequestScaleformMovie(scaleform)

    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(1)
    end

    PushScaleformMovieFunction(scaleform, "CLEAR_ALL")
    PopScaleformMovieFunctionVoid()
    
    PushScaleformMovieFunction(scaleform, "SET_CLEAR_SPACE")
    PushScaleformMovieFunctionParameterInt(200)
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(5)
    Button(GetControlInstructionalButton(2, config.controls.openKey, true))
    ButtonMessage("Wyłącz Noclip")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(4)
    Button(GetControlInstructionalButton(2, config.controls.goUp, true))
    ButtonMessage("W górę")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(3)
    Button(GetControlInstructionalButton(2, config.controls.goDown, true))
    ButtonMessage("W dół")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(2)
    Button(GetControlInstructionalButton(1, config.controls.turnRight, true))
    Button(GetControlInstructionalButton(1, config.controls.turnLeft, true))
    ButtonMessage("Skręc w Lewo/Prawo")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(1)
    Button(GetControlInstructionalButton(1, config.controls.goBackward, true))
    Button(GetControlInstructionalButton(1, config.controls.goForward, true))
    ButtonMessage("W przód/tył")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_DATA_SLOT")
    PushScaleformMovieFunctionParameterInt(0)
    Button(GetControlInstructionalButton(2, config.controls.changeSpeed, true))
    ButtonMessage("Zmień prędkość ("..config.speeds[NoClipSpeed].label..")")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "DRAW_INSTRUCTIONAL_BUTTONS")
    PopScaleformMovieFunctionVoid()

    PushScaleformMovieFunction(scaleform, "SET_BACKGROUND_COLOUR")
    PushScaleformMovieFunctionParameterInt(config.bgR)
    PushScaleformMovieFunctionParameterInt(config.bgG)
    PushScaleformMovieFunctionParameterInt(config.bgB)
    PushScaleformMovieFunctionParameterInt(config.bgA)
    PopScaleformMovieFunctionVoid()

    return scaleform
end

function DisableControls()
    DisableControlAction(0, 30, true)
    DisableControlAction(0, 31, true)
    DisableControlAction(0, 32, true)
    DisableControlAction(0, 33, true)
    DisableControlAction(0, 34, true)
    DisableControlAction(0, 35, true)
    DisableControlAction(0, 266, true)
    DisableControlAction(0, 267, true)
    DisableControlAction(0, 268, true)
    DisableControlAction(0, 269, true)
    DisableControlAction(0, 44, true)
    DisableControlAction(0, 20, true)
    DisableControlAction(0, 74, true)
    DisableControlAction(0, 68, true)
    DisableControlAction(0, 69, true)
    DisableControlAction(0, 91, true)
    DisableControlAction(0, 25, true)
    DisableControlAction(0, 50, true)
    DisableControlAction(0, 0, true)
    DisableControlAction(0, 24, true)
    DisableControlAction(0, 257, true)
    DisableControlAction(1, 288, true) -- F1
    DisableControlAction(1, 170, true) -- F3
end
