x :: Int
x = 7

y :: String
y = "sometext"

f :: Int -> Int -> Int
f x y = x + y 

g :: Int -> Int
g x = x + 1

h :: (Int,Int) -> Int
h x = snd x + 1

i ::(a,Int) -> Int
i x = snd x + 1

type String = [Char] -- type snonym

type Age = Int

nextBrthday :: Age -> Age

data -- Let us declare new type of thins, with whatever structures, proeprties we need them to have
