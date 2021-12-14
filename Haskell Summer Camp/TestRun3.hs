import Data.Map

{- anything that can be use to describe something

data Map K a
  A Map from keys k to values, Keys dont have to be Ints


from List, takes rom a tuple to turn into a map
=> everything prior to the arrow is a constrant... This means that it K can be used as anything but it has to be an instance of Ord

-}


coolFactor Map :: Map LiveCodingLanguage Int
coolFactorMap = FromList [
  (Extempore,2)
  (TidalCycles, 7)
  (Hydra,10)
  (SuperCollider,4) 
  ]

-- dont have to be unique , just orderable