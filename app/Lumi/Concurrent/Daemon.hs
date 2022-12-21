{-# language ImportQualifiedPost #-}
{-# language PackageImports #-}
{-# language RankNTypes #-}

module Lumi.Concurrent.Daemon
    ( immortal
    , withBoundDaemon
    ) where

import "base" Control.Concurrent ( threadDelay )
import "async" Control.Concurrent.Async qualified as Async
import "base" Control.Exception ( SomeException, try )
import "base" Control.Monad ( forever )
import "base" Data.Foldable ( traverse_ )
import "base" GHC.IO ( unsafeUnmask )
import "this" Lumi.Logger qualified as Logger

{-# NOINLINE withBoundDaemon #-}
withBoundDaemon
    :: Logger.Handle
    -> IO ()
withBoundDaemon logger = Async.withAsyncBound labeledImmortalDaemon (const $ pure ())
  where
    {-# NOINLINE labeledImmortalDaemon #-}
    labeledImmortalDaemon :: IO ()
    labeledImmortalDaemon = immortal logger Nothing unsafeUnmask $ pure ()

{-# NOINLINE immortal #-}
immortal
    :: Logger.Handle
    -> Maybe Int
    -> (forall a. IO a -> IO a)
    -> IO ()
    -> IO ()
immortal logger mbDelayOnException unmask action = forever $ do
    excOrSuccess <- try $ unmask action
    case excOrSuccess :: Either SomeException () of
      Right () -> pure ()
      Left _ -> do
        Logger.logError logger
        traverse_ threadDelay mbDelayOnException
