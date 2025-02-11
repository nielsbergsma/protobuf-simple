-- |
-- Module:      Data.ProtoBuf.Mergeable
-- Copyright:   (c) 2015-2016 Martijn Rijkeboer <mrr@sru-systems.com>
-- License:     MIT
-- Maintainer:  Martijn Rijkeboer <mrr@sru-systems.com>
--
-- Mergeable typeclass

module Data.ProtoBuf.Mergeable
    ( Mergeable(..)
    ) where


import Data.ByteString (ByteString)
import Data.Int (Int32, Int64)
import Data.Sequence (Seq, (><))
import Data.Text (Text)
import Data.Word (Word32, Word64)


-- | Typeclass to handle merging of values.
class Mergeable a where

    -- | Merge two values.
    merge :: a -> a -> a
    merge _ b = b


instance Mergeable Bool
instance Mergeable ByteString
instance Mergeable Double
instance Mergeable Float
instance Mergeable Int32
instance Mergeable Int64
instance Mergeable Text
instance Mergeable Word32
instance Mergeable Word64


instance Mergeable a => Mergeable (Maybe a) where
    merge Nothing  b        = b
    merge a        Nothing  = a
    merge (Just a) (Just b) = Just (merge a b)


instance Mergeable (Seq a) where
    merge = (><)
