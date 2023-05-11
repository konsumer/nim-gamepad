{.passC: "-Isrc".}

{.compile: "src/gamepad/Gamepad_private.c".}

when defined(macosx):
  {.compile: "src/gamepad/Gamepad_macosx.c".}
  {.passL: "-framework IOKit -framework CoreFoundation".}

when defined(linux):
  {.compile: "src/gamepad/Gamepad_linux.c".}

when defined(windows):
  {.compile: "src/gamepad/Gamepad_windows_dinput.c".}
  {.passL: "-lXinput -ldinput8 -ldxguid".}

type
  GamepadDevice* {.bycopy.} = object
    deviceID*: cuint
    description*: cstring
    vendorID*: cint
    productID*: cint
    numAxes*: cuint
    numButtons*: cuint
    axisStates*: ptr cfloat
    buttonStates*: ptr bool
    privateData*: pointer
  
  cbAttach = proc (device: ptr GamepadDevice; context: pointer)
  cbButton = proc (device: ptr GamepadDevice; buttonID: cuint; timestamp: cdouble; context: pointer)
  cbAxis = proc (device: ptr GamepadDevice; axisID: cuint; value: cfloat; lastValue: cfloat; timestamp: cdouble; context: pointer)


{.push callconv: cdecl, importc:"Gamepad_$1".}
proc init*()
proc shutdown*()
proc numDevices*(): cuint
proc deviceAtIndex*(deviceIndex: cuint): ptr GamepadDevice
proc detectDevices*()
proc processEvents*()
proc deviceAttachFunc*(callback: cbAttach; context: pointer = nil)
proc deviceRemoveFunc*(callback: cbAttach; context: pointer = nil)
proc buttonDownFunc*(callback: cbButton; context: pointer = nil)
proc buttonUpFunc*(callback: cbButton; context: pointer = nil)
proc axisMoveFunc*(callback: cbAxis; context: pointer = nil)
{.pop.}
