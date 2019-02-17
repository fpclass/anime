-------------------------------------------------------------------------------
-- Haskell bindings for Weeb Soc's API                                       --
-------------------------------------------------------------------------------

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
    eventWhen         :: UTCTime,
    eventWhere        :: Text,
    eventDetails      :: Text,
    eventMaxSignups   :: Int,
    eventSignupsOpen  :: UTCTime,
    eventSignupsClose :: UTCTime
} deriving Show

instance FromJSON Event where
    parseJSON = withObject "Event" $ \v ->
        Event <$> v .: "id"
              <*> v .: "title"
              <*> v .: "subtitle"
              <*> v .: "when"
              <*> v .: "where"
              <*> v .: "details"
              <*> v .: "max_signups"
              <*> v .: "signups_open"
              <*> v .: "signups_close"

-------------------------------------------------------------------------------
