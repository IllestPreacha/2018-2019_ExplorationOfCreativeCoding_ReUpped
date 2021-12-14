-- Monad tranformers

{-

myComputation :: Either String Int
myComputation = do
  x <- Right 7  -- With one fail in a calculation like this, all fails
  y <- Right 8
  return(x+y)

-}


-- newtype ExceptT e m a 
-- ExceptT (M (Either e a ))


{-
-- --  myDatabaseLookup1 :: IO (Either String Int) -- Either use is due to the probability of having an error message
myDatabaseLookup1 = return $ Right 7 -- always give values from the monad
-- same as myDatabaseLookup1 = return $ return 7, return in haskell means to wrap the value rather than communication between - inside methods
-- it is an IO option that has no IO setup
--myDatabaseLookup1 = return $ Left " item not found in database"-
-}

type DatabaseIO = ExceptT String IO

myDatabaseLookup1 :: DatabaseIO  -- m Int
myDatabaseLookup1 = return 7
myDatabaseLookup1 = ExceptT $ return (Left "sorry this didn't work")
myDatabaseLookup1 = throwE "sorry this didn't work"



myDatabaseLookup2 :: DatabaseIO Int
myDatabaseLookup2 = return 8

myDatabaseProgram :: IO()
myDatabseProgram = do
  putStrLn "welcome to our awesome big data program:"
  z <- runExceptT $ do  -- z :: Either String Strig

    x <- runExceptT myDatabaseLookup1  -- DatabaseIO Int -- x :: int
    y <- runExceptT myDatabaseLookup2  -- DatabaseIO Int -- x :: int
    return $ "operation succesful: " ++ (show x+y)

  







{-return (x+y) -- now the return x+y works due to the fact that both x and y are ints rather than being either string int
  



case z of
    Left e -> putStrLn $ "uhoh there was an error;" ++ e
    Right a -> putStrLN $ "Operation succesful, yay : " ++ (show a)

-}
  -- return $ addTwoEithers x y

{-  
return $ case x of
    (Left a ) -> case y of
       (Left b) ->
       (Right b) ->
    (Right a) -> case y of

      (Left b) -> Left b
      (Right b) -> Right (a+b)

-- same as code seen below


-- pattern matching
addTwoEithers :: Ether String Int -> Either String Int -> Either String Int
addTwoEithers (Left x) _ = Left x
addTwoEithers _ (Left x) = Left x
addTwoEithers (Right x) (Right y) = Right (x+y)
--  /return (x+y) --- ???? doesnt really work due to this being an either string int
-}

-- hackage exceptT : a monad transformer that adds exceptions/either to other mondas
  -- e - the exception type
  -- m - the inner monad









