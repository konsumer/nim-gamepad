import ./gamepad
proc main() =
  var data = 100
  proc onGamepadAttached(device: ptr GamepadDevice, context: pointer) {.cdecl.} =
    var js = device[]
    echo "attached: " & $js.deviceID
    inc data
    echo data

  proc onGamepadRemoved(device: ptr GamepadDevice, context: pointer){.cdecl.} =
    var js = device[]
    echo "removed: " & $js.deviceID
    inc data
    echo data

  proc onButtonDown (device: ptr GamepadDevice, buttonID: cuint, timestamp: cdouble, context: pointer) {.cdecl.} =
    var js = device[]
    echo "buttonDown: (" & $buttonID & ")" & $js.deviceID
    inc data
    echo data

  proc onButtonUp (device: ptr GamepadDevice, buttonID: cuint, timestamp: cdouble, context: pointer) {.cdecl.} =
    var js = device[]
    echo "buttonUp: (" & $buttonID & ")" & $js.deviceID
    inc data
    echo data

  proc onAxisMoved (device: ptr GamepadDevice, axisID: cuint, value: cfloat, lastValue: cfloat, timestamp: cdouble, context: pointer) {.cdecl.} =
    var js = device[]
    echo "axis: (" & $axisID & ")" & $js.deviceID & " - " & $value
    inc data
    echo data


  const GAMEPAD_POLL_ITERATION_INTERVAL=30

  gamepad.deviceAttachFunc(onGamepadAttached)
  gamepad.deviceRemoveFunc(onGamepadRemoved)
  gamepad.buttonDownFunc(onButtonDown)
  gamepad.buttonUpFunc(onButtonUp)
  gamepad.axisMoveFunc(onAxisMoved)
  gamepad.init()

  var iterationsToNextPoll = 1
  var close = false
  while not close:
    gamepad.processEvents()
    dec iterationsToNextPoll
    if iterationsToNextPoll == 0:
      gamepad.detectDevices()
      iterationsToNextPoll = GAMEPAD_POLL_ITERATION_INTERVAL
main()