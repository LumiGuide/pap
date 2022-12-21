{-# language ImportQualifiedPost #-}
{-# language PackageImports #-}

module Lumi.Logger
    ( Handle
    , new
    , logError
    ) where

import "base" Control.Concurrent.MVar ( MVar, newMVar, tryReadMVar )
import "base" Control.Monad.IO.Class ( MonadIO, liftIO )
import "base" Data.Foldable ( for_ )
import "base" Data.Traversable ( for )

newtype Handle = Handle (MVar [Int])

{-# NOINLINE new #-}
new :: IO Handle
new = Handle <$> newMVar []

{-# NOINLINE logError #-}
logError :: (MonadIO m) => Handle -> m ()
logError (Handle mvarSinks) = do
  mbSinks <- liftIO $ tryReadMVar mvarSinks
  for_ mbSinks $ \sinks ->
    for sinks $ \_sink ->
      pure ()
