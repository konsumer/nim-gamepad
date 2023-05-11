# Package

version       = "0.0.6"
author        = "David Konsumer"
description   = "Cross-platform gamepad driver"
license       = "MIT"
srcDir        = "src"
bin           = @["jstest"]
installDirs   = @["src", "src/gamepad"]

# Dependencies

requires "nim >= 1.6.10"
