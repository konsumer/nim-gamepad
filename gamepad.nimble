# Package

version       = "0.0.9"
author        = "David Konsumer"
description   = "Cross-platform gamepad driver"
license       = "MIT"
srcDir        = "src"
bin           = @["jstest"]

installDirs   = @["libgamepad/gamepad"]
installExt = @["nim", "c", "h"]

# Dependencies

requires "nim >= 1.6.10"
