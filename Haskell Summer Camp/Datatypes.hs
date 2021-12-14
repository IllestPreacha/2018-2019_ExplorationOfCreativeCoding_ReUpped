-- Capitialization occurs for Types, Type Classes, everything that is value based will be in small

import Data.Maybe

-- algebraic types

data LiveCodingLanguage =
  SuperCollider |
  TidalCycles |
  Extempore  |
  Hydra 
  deriving (Show,Eq,Ord)

-- type of LivecodingLanguage, SuperCollider & Etc are Types

coolFactor :: LiveCodingLanguage -> Int
coolFactor SuperCollider = 4
coolFactor TidalCycles = 7
coolFactor Extempore = 2
coolFactor Hydra = 10

-- record syntax


data LiveCoder = LiveCoder {
  name :: String,
  language :: Maybe LiveCodingLanguage -- it adds range for debugging and etc
  }

-- instance LiveCoder Monoid where
--  mempty = LiveCoder "" EmptyLanguage
--  mappend x y = LiveCoder


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

howFamousWillYouBe :: (Int,Int) -> Int
-- howFamousWillYouBe (address,cf) = address*address*address-(cf*address)+(cf*cf*(-1)*address)
howFamousWillYouBe = uncurry howFamousWillYouBe'

howFamousWillYouBe' :: Int -> Int -> Int
howFamousWillYouBe' address cf = address*address*address-(cf*address)+(cf*cf*(-1)*address)

howFamousWillYouBe'' :: Int -> Int -> Int
howFamousWillYouBe'' = flip howFamousWillYouBe'


coolFactor' :: Maybe LiveCodingLanguage -> Int
-- coolFactor' (Just l) = coolFactor l
-- coolFactor' Nothing = 0
coolFactor' = maybe 0 coolFactor



