-- Functors

fmap :: (a ->) - > f a -> f b

-- reverse functor  can be use for string such as "fmap (reverse) getLine

-- Left as a fail/error message and right as successful read


-- applicative functors

<*> :: f( a->b) -> f a -> f b
-- above code means that a wrapped( a to then b) leads to a wrap 'a' which then leads to a wrap 'b'

-- list are non determinstic 

{-

Prelude> :t getLine
getLine :: IO String
Prelude> fmap (reverse) getLine
something
"gnihtemos"
Prelude> Left "this sucks"
Left "this sucks"
Prelude> Right 7
Right 7
Prelude> fmap (+2) (Right 7)
Right 9
Prelude> fmap (+2) (Left "ooops this didnt work")
Left "ooops this didnt work"
Prelude> (+2) <$> [1,2,3,4]
[3,4,5,6]

Prelude> (+) <$> [1,2,3,4] <*> [5,6,7,8]
[6,7,8,9,7,8,9,10,8,9,10,11,9,10,11,12]
Prelude> 

-}

<$> = fmap

{-

Prelude> :t (+) <$> [1,2,3,4]
(+) <$> [1,2,3,4] :: Num a => [a -> a]

same as

fmap (+) [1,2,3,4
-}



-- monads

"bind" >>= :: m a -> (a -> m b) -> m b

lambda function

Prelude> [1,2,3,4]  >>= (\x -> [x+2])
[3,4,5,6]

GHCI Output

Prelude> [1,2,3,4]  >>= (\x -> putStrLn $ show $ (x+2))

<interactive>:22:23: error:
    • Couldn't match type ‘IO’ with ‘[]’
      Expected type: [()]
        Actual type: IO ()
    • In the expression: putStrLn $ show $ (x + 2)
      In the second argument of ‘(>>=)’, namely
        ‘(\ x -> putStrLn $ show $ (x + 2))’
      In the expression:
        [1, 2, 3, 4] >>= (\ x -> putStrLn $ show $ (x + 2))


-- do notation + io



