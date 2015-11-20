{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
{-# LANGUAGE TemplateHaskell   #-}
{-# LANGUAGE TypeFamilies      #-}

import Yesod.Core
import Network.Wai.Handler.Warp
import Data.Streaming.Network.Internal

data YesodAPI = YesodAPI

mkYesod "YesodAPI" $(parseRoutesFile "config/routes")

instance Yesod YesodAPI

getHomeR :: Handler Html
getHomeR = defaultLayout [whamlet|Hello World!|]

main :: IO ()
main = warp' 3000 "0.0.0.0" YesodAPI

warp' :: YesodDispatch site => Int -> String -> site -> IO ()
warp' port host site = do
  toWaiApp site >>= runSettings (setPort port $ setHost (Host host) $ defaultSettings)

