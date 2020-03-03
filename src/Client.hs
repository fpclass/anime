-------------------------------------------------------------------------------
-- Haskell bindings for Weeb Soc's API                                       --
-------------------------------------------------------------------------------

module Client (
    module Event,
    getEvents
) where

-------------------------------------------------------------------------------

import Data.Proxy

import Servant.API
import Servant.Client

import Network.HTTP.Client (newManager)
import Network.HTTP.Client.TLS (tlsManagerSettings)

import Event

-------------------------------------------------------------------------------

-- | The API represented as a type.
type WeebApi = "events" :> Get '[JSON] [Event]

-- | A proxy value for the API type.
api :: Proxy WeebApi
api = Proxy

-- | `events` is a computation which retrieves events from the API.
events :: ClientM [Event]
events = client api

-- | The `BaseURL` of the API.
url :: BaseUrl
url = BaseUrl Https "animesoc.co.uk" 443 "/api/"

-- | `getEvents` is a computation which retrieves events from the API if
-- successful or an error if not.
getEvents :: IO (Either ClientError [Event])
getEvents = do
    manager <- newManager tlsManagerSettings
    runClientM events (ClientEnv manager url Nothing)


-------------------------------------------------------------------------------
