-- functors

fmap :: (a -> b) -> f a -> f b

-- applicative functors
<*> :: f (a -> b) -> f a -> f b

-- monad
>>= :: m a -> (a -> m b) -> m b

Lists
Maybe
Either a
IO
-- making things exist and interact in the browser
Parsing - > -- source things can be consumed to produce values of interest or maybe not

-- Parsing means taking text characters and turning it into a different form of things -- Translation into tree systems and help the branching persons

-- parsec : Monadic ParasER Combinator


--ParserT monad transformer and Parser type


data ParsecT s u m a , -- a is a value contained in the monad      
-- stream type s = what we are consuming , user state type u = what results you have previously stored
-- underlying monad m and a return type a


type Parsec s u = ParsecT s u Indentity , -- a type wrapping value a

data ParsecT s u m        a
type Parsec s u = ParsecT s u Identity
type GenParser tok st - parsec [tok] st
type Parser = Parsec String () = ParsecT String () Identity

myParserForCoolStuff :: Parser Int ....... ParsecT String () Identity Int

myIOProgram :; IO()
myIOProgram = do
  putStrLn "hello" -- :: String -> IO ()

eof :: (Stream s m t , show t) => ParsecT s u m ()
-- followed by NotFollowedby
-- use as an end of input solution to parsing

Control.Text.Parsec.Char

