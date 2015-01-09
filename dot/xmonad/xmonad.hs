
import qualified Data.Map as Map

import XMonad
import Graphics.X11.ExtraTypes.XF86

keyMap conf = keys defaultConfig conf `Map.union`  brightness
  where
    brightness = Map.fromList [
        ((noModMask, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 10")
      , ((noModMask, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 10")
      ]

main :: IO ()
main = xmonad $ defaultConfig {
    borderWidth = 1
  , terminal = "urxvt"
  , keys = keyMap
  }

