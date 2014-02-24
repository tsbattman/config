
import XMonad

main :: IO ()
main = xmonad $ defaultConfig { borderWidth = 1, terminal = "urxvt" }

