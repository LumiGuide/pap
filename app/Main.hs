module Main where

import Lumi.Logger
import Lumi.Concurrent.Daemon

main :: IO ()
main = new >>= withBoundDaemon
