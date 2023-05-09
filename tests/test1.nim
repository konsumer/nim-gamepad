import unittest

import gamepad

# this isn't really a unit-test, just a way to load the lib

proc onGamepadAttached(device: ptr Gamepad_device, context: pointer) =
  var js = device[]
  echo "attached: " & $js.deviceID

proc onGamepadRemoved(device: ptr Gamepad_device, context: pointer) =
  var js = device[]
  echo "removed: " & $js.deviceID

proc onButtonDown (device: ptr Gamepad_device, buttonID: cuint, timestamp: cdouble, context: pointer) =
  var js = device[]
  echo "buttonDown: (" & $buttonID & ")" & $js.deviceID

proc onButtonUp (device: ptr Gamepad_device, buttonID: cuint, timestamp: cdouble, context: pointer) =
  var js = device[]
  echo "buttonUp: (" & $buttonID & ")" & $js.deviceID

proc onAxisMoved (device: ptr Gamepad_device, axisID: cuint, value: cfloat, lastValue: cfloat, timestamp: cdouble, context: pointer) =
  var js = device[]
  echo "axis: (" & $axisID & ")" & $js.deviceID & " - " & $value

test "can add":
  gamepad.deviceAttachFunc(onGamepadAttached)
  gamepad.deviceRemoveFunc(onGamepadRemoved)
  gamepad.buttonDownFunc(onButtonDown)
  gamepad.buttonUpFunc(onButtonUp)
  gamepad.axisMoveFunc(onAxisMoved)
  gamepad.init()
  
  gamepad.detectDevices()
  gamepad.processEvents()
