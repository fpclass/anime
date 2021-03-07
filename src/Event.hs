-------------------------------------------------------------------------------
-- Haskell bindings for Weeb Soc's API                                       --
-------------------------------------------------------------------------------

{-# LANGUAGE OverloadedStrings #-}

module Event where

-------------------------------------------------------------------------------

import Data.Aeson
import Data.Text
import Data.Time.Clock

-------------------------------------------------------------------------------

-- | Represents an event.
data Event = Event {
    eventID           :: Int,
    eventTitle        :: Text,
    eventSubtitle     :: Text,
    eventWhen         :: Maybe UTCTime,
    eventWhere        :: Maybe Text,
    eventDetails      :: Text,
    eventMaxSignups   :: Maybe Int,
    eventSignupsOpen  :: Maybe UTCTime,
    eventSignupsClose :: Maybe UTCTime
} deriving (Eq, Show)

instance FromJSON Event where
    parseJSON = withObject "Event" $ \v ->
        Event <$> v .: "id"
              <*> v .: "title"
              <*> v .: "subtitle"
              <*> v .:? "when"
              <*> v .:? "where"
              <*> v .: "details"
              <*> v .:? "max_signups"
              <*> v .:? "signups_open"
              <*> v .:? "signups_close"

-------------------------------------------------------------------------------
