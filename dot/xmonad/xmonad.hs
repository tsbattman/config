
import Control.Applicative
import Data.Traversable
import qualified Data.Map as Map

import XMonad
import Graphics.X11.ExtraTypes.XF86

brightness = Map.fromList [
    ((noModMask, xF86XK_MonBrightnessUp), spawn "xbacklight -inc 1")
  , ((noModMask, xF86XK_MonBrightnessDown), spawn "xbacklight -dec 1")
  ]

volume = Map.fromList [
    ((noModMask, xF86XK_AudioRaiseVolume), spawn "amixer sset Master,0 5%+")
  , ((noModMask, xF86XK_AudioLowerVolume), spawn "amixer sset Master,0 5%-")
  , ((noModMask, xF86XK_AudioMute), spawn "amixer sset Master,0 toggle")
  ]

main :: IO ()
main = xmonad def {
    borderWidth = 1
  , terminal = "exec urxvt"
  , keys = Map.unions <$> sequenceA [
      keys def
    , const brightness
    , const volume
    ]
  , startupHook = spawn "exec xmobar"
  }
