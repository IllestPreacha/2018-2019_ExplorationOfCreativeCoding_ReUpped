import Data.Map

--lookup is a maybe function since you may not be able to find the thing


{-record syntax, where we build records (databses) 
  Equal and show to transform to a print
  Since we have two maps, we have to use the Prelude.map to differientate -}

data LiveCoder = LiveCoder {
  name :: String,
  language :: Maybe LiveCodingLanguage
  } 

instance Show LiveCoder where
  show x = name x ++ " lives there. " ++  describeLanguage (language x)

describeLanguage :: Maybe LiveCodingLanguage -> String
describeLanguage Nothing = "They are too cool for any one language."
describeLanguage (Just SuperCollider) = " they use the venerable SuperCollider Language. How old school?" 
describeLanguage (Just TidalCycles) = " They use TidalCycles and are preptually bouncing fom one algorave to the next "
describeLanguage (Just Extempore) = " They use Extempore and are in total command of their machine."
describeLanguage (Just SonicPi) = " The Best 1"
describeLanguage (Just Gibber) = " Everything has JS"
  
  
type Location = String  
  
liveCoderMap :: Map Location LiveCoder 
liveCoderMap = fromList [
  ("Dundas",LiveCoder "dktr0" Nothing),
  ("Ainslie Wood",LiveCoder "luis" (Just TidalCycles)),
  ("Mississauga", LiveCoder "Yumna" Nothing),
  ("Montreal", LiveCoder "Kofi" (Just SonicPi)),
  ("Mexico", LiveCoder "Damtro" (Just Gibber))
  ]
  
 -- building a type again

data LiveCoder' = LiveCoder' String LiveCodingLanguage
-- building types 

data LiveCodingLanguage = 
  SuperCollider |
  Extempore |
  TidalCycles |
  Hyrda |
  SonicPi |
  Gibber
  deriving (Show)


-- a program to ask you for a live coder's name
-- which it then looks up in the map/database and uses
-- to give you some kind of message in reply

main :: IO()  -- since in IO monad can use the do notation
main = do
  putStrLn "Please enter the location of a livecoder and then press enter)"
  x <- getLine
  putStrLn (getResponse x) -- putStrLn :: String -> IO ()

getResponse :: String -> String
getResponse x = liveCoderToString $ Data.Map.lookup x liveCoderMap
liveCoderToString :: Maybe LiveCoder -> String
liveCoderToString (Just x) = show x
liveCoderToString Nothing = "There is no such livecoder yet at the moment"
-- lookup :: Ord => k -> Map k a -> Maybe a
--lookup x liveCoderMap -- Maybe LiveCoder













{- a type has to both sides of the equation
-- use EQ to compare the two stuff while prinitng -}

-- remaking this : fmap :: (a -> b) -> f a -> f b 
-- Functor

data Maybe' a = Just' a | Nothing'  deriving (Show,Eq) 

instance Functor Maybe' where
  fmap f (Just' x) =  Just' (f x) -- Have to match the Maybe functor
  fmap f (Nothing') = Nothing'      -- Pattern Matching


-- Applicative ("Applicative Style" "Applicative Functors")

-- pure :: a -> f a   -- pure :: a -> Maybe' a
-- (<*> :: f (a-> b) -> f a -> fb    -- :: Maybe' (a->b) -> Maybe" a -> Maybe' b

instance Applicative Maybe' where
  pure x = Just' x -- wrapping a value in a just , which equals "Pure = Just'" (Factoring)
  (Just' f) <*> (Just' x) = Just' (f x) -- has to be in brackets cause it is only two agruments but not 3 
  _<*>_ = Nothing' -- _ symbolizes anytype , any value

{-
  (Just' f) <*> (Nothing') =  Nothing'
  (Nothing') <*> (Just' x) = Nothing' -- cause we can't return Maybe a' if we are expecting a Maybe b',
  (Nothing') <*> (Nothing') = Nothing' -}


-- Monads

-- bind (>>=)

-- (>>=) :: m a -> (a -> m b) -> m b
-- return :: a -> m a -- a -> Maybe' a 


instance Monad Maybe' where
--  return = pure
  (Just' x ) >>= f = f x -- just x is simialr to the Maybe' x
  (Nothing') >>= f = Nothing'


-- do notaton , works well for adding Maybe Numbers and other complex type ( due to in part to BIND)   -- Number needs to be of the Maybe type due to our type class

test :: Maybe' Int
test = do
  x <- Just' 5
  y <- Just' 15
  z <- Just' 11
  return (x+y-z)

test1 = Nothing' >>= (\x -> Just' 10 >>= (\y -> return (x+y)))




-- IO

test2 :: IO ()  -- needs a binding
test2 = do
  putStrLn "Please enter something"
  x <- getLine -- getLine :: IO String , x :: String
  putStrLn "Even though you type this please repeat"
  y <- getLine
  putStrLn "Thank you, very much !1"


test3 :: Either String Int  -- hard to debug with strings   -- Either a is an instance of monad but not Either
test3 = do
  x <- Left "Sorry this value isn't available"
  y <- Right 10
  return (x + y)


{-
>>= :: m a -> (a -> m b) -> m b
    :: IO String -> (String -> IO ()) -> IO ()

list = non-deterministic coputation
Maybe = cpmtext of success vs silent failure
IO = Context is that we might itneract with the user via external factors
  
-}

