# Package

version       = "0.0.3"
author        = "David Konsumer"
description   = "Cross-platform gamepad driver"
license       = "MIT"
srcDir        = "src"
bin           = @["jstest"]
installDirs   = @["src/", "libgamepad/"]


# Dependencies

requires "nim >= 1.6.10"
