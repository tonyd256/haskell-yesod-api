{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}

import Yesod.Core
import Network.Wai.Handler.Warp
import Data.Streaming.Network.Internal

data HelloWorld = HelloWorld

mkYesod "HelloWorld" [parseRoutes|
/ HomeR GET
|]

instance Yesod HelloWorld

getHomeR :: Handler Html
getHomeR = defaultLayout [whamlet|Hello World!|]

main :: IO ()
main = warp' 3000 "0.0.0.0" HelloWorld

warp' :: YesodDispatch site => Int -> String -> site -> IO ()
warp' port host site = do
  toWaiApp site >>= runSettings (setPort port $ setHost (Host host) $ defaultSettings)

