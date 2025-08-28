module Server (
  HelloAPI,
  helloAPI,
  server,
  app,
) where

import Network.Wai qualified as Wai
import Protolude
import Servant (type (:>))
import Servant qualified as S


-- API Definition
type HelloAPI = "hello" :> S.Get '[S.PlainText] Text


helloAPI :: S.Proxy HelloAPI
helloAPI = S.Proxy


-- Handler Implementation
helloHandler :: S.Handler Text
helloHandler = pure "Hello World"


-- Server
server :: S.Server HelloAPI
server = helloHandler


-- WAI Application
app :: Wai.Application
app = S.serve helloAPI server
