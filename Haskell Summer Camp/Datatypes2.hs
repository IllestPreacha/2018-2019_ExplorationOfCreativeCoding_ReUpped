-- Capitialization occurs for Types, Type Classes, everything that is value based will be in small

{- Block Commenting  -}

import Data.Maybe
import qualified Data.Map as M --using it as a object to control
-- import Data.Map(Map (..) , fromList)
-- importing selectin things, qualifying , 

-- algebraic types

data LiveCodingLanguage =
  SuperCollider |
  TidalCycles |
  Extempore  |
  Hydra
  deriving (Show,Eq,Ord)


-- type of LivecodingLanguage, SuperCollider & Etc are Types

-- Mapping a List of K value into 
coolFactor Map :: Map LiveCodingLanguage Int
coolFactorMap = FromList [
  (Extempore,2)
  (TidalCycles, 7)
  (Hydra,10)
  (SuperCollider,4) 
  ]

-- dont have to be unique , just orderable



coolFactor :: LiveCodingLanguage -> Int
coolFactor x = fndWithDefault 0 x coolFactorMap

-- record syntax

tye CustomLanguage = (String,Int)

data LiveCoder = LiveCoder {
  name :: String,
  language :: Either CustomLanguage LiveCodingLanguage
  } 


instance Show LiveCoder where
  show x = name x ++ " : " ++ show(language x) -- the language of x and then we convert to text

illestPreacha :: LiveCoder -- no capitals, copy added definition to the LiveCoder Def
illestPreacha = LiveCoder "illestPreacha" TidalCycles

dktr0 :: LiveCoder
dktr0 = LiveCoder "dktr0" SuperCollider

jessica :: LiveCoder
jessica = LiveCoder "jessica" Hydra

luis :: LiveCoder
luis = LiveCoder "luis" Hydra

type Ensemble = [LiveCoder] -- setting a new type for the list

rggtrn :: [LiveCoder]
rggtrn = [dktr0,illestPreacha,luis,jessica]

-- typeclasses


-- instance Show LiveCodingLanguage where  -- show a string to show something working , -- where is an
--  show SuperCollider = "SuperCollider!!!!!!!"
-- show TidalCycles = "TidalCycles!!!"
--  show Extempore = "Extempore!!!!!"

ensembleCoolFactor :: [LiveCoder] -> Int
-- ensembleCoolFactor [] = 0 -- setting an empty list
-- ensembleCoolFactor (x:xs) = coolFactor (language (head xs)) + ensembleCoolFactor (tail xs)
-- ensembleCoolFactor xs = foldl (+) 0 $ map (coolFactor . language) xs
ensembleCoolFactor  = (foldl (+) 0) . (map (coolFactor . language)) -- compositon replaces the xs on both sides of the equation


coolFactor' :: Maybe LiveCodingLanguage -> Int
coolFactor' = maybe 0 coolFactor
coolFactor'':: Either CustomLangua LiveCodingLanguage -> Int
coolFactor'' (Left(l,cf)) = cf
coolFacto'' (Right x) = coolFactor x

-- whatLanguages :: Ensemble -> [LiveCodingLanguage]
-- whatLanguages xs = catMaybes $ map langauge xs
-- whatLanguages xs = mapMaybe language xs
-- whatLanguages = mapMaybe language


--coolFactor'' = either(\(_,y) -> y*y) colFactor lambda expression
