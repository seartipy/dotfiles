-- default desktop configuration for Fedora

{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}

import           Control.Arrow                (second, (***))
import           Data.Maybe                   (maybe)
import           System.Exit
import           System.IO
import           System.Posix.Env             (getEnv)
import           XMonad
import XMonad.Hooks.DynamicLog
import           XMonad.Actions.WindowBringer

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

import           XMonad.Config.Desktop
import           XMonad.Config.Gnome
import           XMonad.Config.Kde
import           XMonad.Config.Xfce

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
main = do
     session <- getEnv "DESKTOP_SESSION"
     xmonad  $ (maybe desktopConfig desktop session)
       {
         layoutHook = smartBorders $ myLayout,
         modMask = myModMask     -- Rebind Mod to the Windows key
       } `additionalKeys` [
       -- Shring non master area
       ((myModMask, xK_a), sendMessage MirrorShrink)

       , ((myModMask, xK_p), spawn "dmenu_run -fn 'Ubuntu Mono 13'")

         -- Expand non master area
       , ((myModMask, xK_z), sendMessage MirrorExpand)
         -- open a dmenu with window titles, switch to workspace of the chosen one
       , ((myModMask, xK_g), gotoMenuArgs' "dmenu" [ "-fn",  "'Ubuntu Mono 13'" ])

         -- Chosen one, will be brought into current workspace
       , ((myModMask, xK_b), bringMenuArgs' "dmenu" [ "-fn", "'Ubuntu Mono 14'" ])

       , ((myModMask, xK_m), (dynamicLogString defaultPP >>= \d->spawn $"notify-send \"" ++ d ++ "\"" ++ " -t 1000"))

       ]

desktop "gnome" = gnomeConfig
desktop "kde" = kde4Config
desktop "xfce" = xfceConfig
desktop "mate" = gnomeConfig
desktop "xmonad-mate" = gnomeConfig
desktop _ = desktopConfig
