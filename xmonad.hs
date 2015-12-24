-- default desktop configuration for Fedora

{-# LANGUAGE FlexibleInstances     #-}
{-# LANGUAGE MultiParamTypeClasses #-}

import           Control.Arrow                (second, (***))
import           Data.Maybe                   (maybe)
import           System.Exit
import           System.IO
import           System.Posix.Env             (getEnv)
import           XMonad
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

main = do
     session <- getEnv "DESKTOP_SESSION"
     xmonad  $ (maybe desktopConfig desktop session)
       {
         layoutHook = smartBorders $ myLayout,
         modMask = mod4Mask     -- Rebind Mod to the Windows key
       }

desktop "gnome" = gnomeConfig
desktop "kde" = kde4Config
desktop "xfce" = xfceConfig
desktop "xmonad-mate" = gnomeConfig
desktop _ = desktopConfig
