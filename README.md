This is a simple gamepad library for nim. It's a thin, statically-compiled wrapper for [libstem_gamepad]( https://github.com/ThemsAllTook/libstem_gamepad).

It should work on Windows, Linux, and Mac.

## installation

Add this to your .nimble file:

```nim
requires "gamepad >= 0.0.16"
```

## usage

```nim
import gamepad
import os

proc onGamepadAttached(device: ptr GamepadDevice, context: pointer) {.cdecl.} =
  var js = device[]
  echo "attached: " & $js.deviceID

proc onGamepadRemoved(device: ptr GamepadDevice, context: pointer) {.cdecl.} =
  var js = device[]
  echo "removed: " & $js.deviceID

proc onButtonDown (device: ptr GamepadDevice, buttonID: cuint, timestamp: cdouble, context: pointer) {.cdecl.} =
  var js = device[]
  echo "buttonDown: (" & $buttonID & ")" & $js.deviceID

proc onButtonUp (device: ptr GamepadDevice, buttonID: cuint, timestamp: cdouble, context: pointer) {.cdecl.} =
  var js = device[]
  echo "buttonUp: (" & $buttonID & ")" & $js.deviceID

proc onAxisMoved (device: ptr GamepadDevice, axisID: cuint, value: cfloat, lastValue: cfloat, timestamp: cdouble, context: pointer) {.cdecl.} =
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

# do your loop however you like
# this is a simple example that will cleanup on Ctrl-C

proc handler() {.noconv.} =
  close = true
  gamepad.shutdown()
setControlCHook(handler)

echo "Press Ctrl-C to exit"
while not close:
  sleep(100)
  gamepad.processEvents()
  dec iterationsToNextPoll
  if iterationsToNextPoll == 0:
    gamepad.detectDevices()
    iterationsToNextPoll = GAMEPAD_POLL_ITERATION_INTERVAL

```
