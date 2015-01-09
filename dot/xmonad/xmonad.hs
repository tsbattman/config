
import qualified Data.Map as Map

import XMonad
import Graphics.X11.ExtraTypes.XF86

keyMap conf = Map.union (keys conf conf) brightness
  where
    brightness = Map.fromList [
        ((noModMask, xF86XK_MonBrightnessUp), spawn "xbrightness -inc 40")
      , ((noModMask, xF86XK_MonBrightnessDown), spawn "xbrightness -dec 40")
      ]

main :: IO ()
main = xmonad $ defaultConfig {
    borderWidth = 1
  , terminal = "urxvt"
  , keys = keyMap
  }

