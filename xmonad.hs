-- default desktop configuration for Fedora

{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}

import           Control.Arrow                (second, (***))
import           Data.Maybe                   (maybe)
import           System.Exit
import           System.IO
import           System.Posix.Env             (getEnv)
import           XMonad
import           XMonad.Hooks.DynamicLog

import           XMonad.Actions.WindowBringer
import           XMonad.Actions.CycleSelectedLayouts
import           XMonad.Actions.CycleWS
import           XMonad.Actions.WindowNavigation
import           XMonad.Actions.FindEmptyWorkspace
import           XMonad.Actions.WorkspaceNames

import           XMonad.Hooks.ManageDocks
import           XMonad.Hooks.SetWMName

import           XMonad.Layout.Fullscreen
import           XMonad.Layout.NoBorders
import           XMonad.Layout.ResizableTile
import           XMonad.Layout.Spiral
import           XMonad.Layout.ThreeColumns
import qualified XMonad.StackSet              as W
import           XMonad.Util.EZConfig         (additionalKeys)
import           XMonad.Util.Run              (spawnPipe)

import           XMonad.Prompt
import           XMonad.Prompt.RunOrRaise

import           XMonad.Config.Desktop
import           XMonad.Config.Gnome
import           XMonad.Config.Kde
import           XMonad.Config.Xfce
import           XMonad.Config.Mate

newtype Flip l a = Flip (l a) deriving (Show, Read)
instance LayoutClass l a => LayoutClass (Flip l) a where
    runLayout (W.Workspace i (Flip l) ms) r = (map (second flipRect) *** fmap Flip)
                                                `fmap` runLayout (W.Workspace i l ms) (flipRect r)
                                         where screenWidth = fromIntegral $ rect_width r
                                               flipRect (Rectangle rx ry rw rh) = Rectangle (screenWidth - rx - (fromIntegral rw)) ry rw rh
    handleMessage (Flip l) = fmap (fmap Flip) . handleMessage l
    description (Flip l) = "Flip "++ description l

myLayout = avoidStruts (
    Flip (ResizableTall 1 (3/100) (1/2) []) |||
    ThreeColMid 1 (3/100) (1/2) |||
    noBorders (fullscreenFull Full))

    -- ResizableTall 1 (3/100) (1/2) [] |||
    -- Mirror (Tall 1 (3/100) (1/2)) |||
    -- Full |||
    -- spiral (6/7)

myModMask = mod4Mask

myXPConfig  = defaultXPConfig {
        -- font = "-*-avant garde gothic-demi-r-*-*"
        font = "xft:Ubuntu Mono:pixelsize=30:autohint=true"
        ,   height = 30
        -- always highlight a result, so I can hit enter any time
        ,   alwaysHighlight = True
}

main = do
     session <- getEnv "DESKTOP_SESSION"

     -- switch/move windows using arrow keys
     xconfig <- withWindowNavigationKeys [
       ((myModMask, xK_Up), WNGo U)
       , ((myModMask, xK_Left), WNGo L)
       , ((myModMask, xK_Down), WNGo D)
       , ((myModMask, xK_Right), WNGo R)
       , ((myModMask .|. shiftMask, xK_Up), WNSwap U)
       , ((myModMask .|. shiftMask, xK_Left), WNSwap L)
       , ((myModMask .|. shiftMask, xK_Down), WNSwap D)
       , ((myModMask .|. shiftMask, xK_Right), WNSwap R)
       ] $ (maybe desktopConfig desktop session)

     xmonad $ xconfig
       {
         layoutHook = smartBorders $ myLayout
       , modMask = myModMask     -- Rebind Mod to the Windows key
       } `additionalKeys` [
       -- Shring non master area
       ((myModMask, xK_u), sendMessage MirrorShrink)
         -- Expand non master area
       , ((myModMask, xK_i), sendMessage MirrorExpand)

       -- Launch applications rofi
       , ((myModMask, xK_p), spawn "rofi -show run -i -font 'Ubuntu Mono 26'")

       -- Switch to application using rofi
       , ((myModMask, xK_w), spawn "rofi -show window -i -font \"Ubuntu Mono 26\"")

         -- Chosen one, will be brought into current workspace
       , ((myModMask, xK_b), bringMenuArgs' "dmenu" [ "-fn", "'Ubuntu Mono 13'" ])

       -- Display current layout
       , ((myModMask, xK_m), (dynamicLogString defaultPP >>= \d->spawn $"notify-send \"" ++ d ++ "\"" ++ " -t 1000"))

       -- Run or Switch to app
       , ((myModMask, xK_x), runOrRaisePrompt myXPConfig)

       -- Cycle between workspaces
       , ((myModMask .|. controlMask, xK_Left), nextWS)
       , ((myModMask .|. controlMask, xK_Right),  prevWS)
       , ((myModMask .|. controlMask .|. shiftMask, xK_Left),  shiftToNext >> nextWS)
       , ((myModMask .|. controlMask .|. shiftMask, xK_Right), shiftToPrev >> prevWS)
       , ((myModMask .|. controlMask, xK_z), toggleWS)

       -- Jump or move window to empty workspace
       , ((myModMask, xK_e), viewEmptyWorkspace)
       , ((myModMask .|. shiftMask, xK_e), tagToEmptyWorkspace)

       , ((myModMask .|. shiftMask, xK_r), renameWorkspace myXPConfig)
       , ((myModMask .|. shiftMask, xK_Left  ), swapTo Prev)
       , ((myModMask .|. shiftMask, xK_Right ), swapTo Next)
       ]
       -- ++ [((myModMask .|. controlMask, k), swapWithCurrent i) | (i, k) <- zip (workspaces xconfig) [xK_1 ..]]

desktop "gnome" = gnomeConfig
desktop "kde" = kde4Config
desktop "xfce" = xfceConfig
desktop "mate" = mateConfig
desktop "xmonad-mate" = mateConfig
desktop _ = desktopConfig
