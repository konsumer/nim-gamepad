import ./gamepad

proc onGamepadAttached(device: ptr GamepadDevice, context: pointer) =
  var js = device[]
  echo "attached: " & $js.deviceID

proc onGamepadRemoved(device: ptr GamepadDevice, context: pointer) =
  var js = device[]
  echo "removed: " & $js.deviceID

proc onButtonDown (device: ptr GamepadDevice, buttonID: cuint, timestamp: cdouble, context: pointer) =
  var js = device[]
  echo "buttonDown: (" & $buttonID & ")" & $js.deviceID

proc onButtonUp (device: ptr GamepadDevice, buttonID: cuint, timestamp: cdouble, context: pointer) =
  var js = device[]
  echo "buttonUp: (" & $buttonID & ")" & $js.deviceID

proc onAxisMoved (device: ptr GamepadDevice, axisID: cuint, value: cfloat, lastValue: cfloat, timestamp: cdouble, context: pointer) =
  var js = device[]
  echo "axis: (" & $axisID & ")" & $js.deviceID & " - " & $value


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
