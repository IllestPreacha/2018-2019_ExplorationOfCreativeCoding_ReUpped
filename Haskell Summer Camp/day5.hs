import Text.Parsec
import Text.ParserCombinators.Parsec.Prim hiding (try)
import Data.Functor.Identity
import Text.Parsec.Token as P

-- to avoid clashing, use qualified, hiding, try , as 


data LiveCodingLanguage =
  SuperCollider |
  TidalCycles |
  Extempore |
  Hydra |
  Gibber |
  SonicPi 
  deriving (Show,Eq)


-- myTokenParser :: GenTokenParser s u m   -- wouldnt work cause it will work under all conditions
-- myTokenParser :: Stream s m Char => GenTokenParser s u m   -- not as efficient as the one below
myTokenParser :: P.GenTokenParser [Char] () Identity
myTokenParser = P.makeTokenParser ourLanguageDef

identifier = P.identifier myTokenParser
reserved = P.reserved myTokenParser
operator = P.operator myTokenParser
reservedOp = P.reservedOp myTokenParser
charLiteal = P.charLiteral myTokenParser
strongLiteral = P.stringLiteral myTokenParser
integer = P.integer myTokenParser
float = P.float myTokenParser
naturalOrFloat = P.naturalOrFloat myTokenParser
decimal = P.decimal myTokenParser
hexadecimal = P.hexadecimal myTokenParser
octal = P.octal myTokenParser
symbol = P.symbol myTokenParser
lexeme = P.lexeme myTokenParser
whiteSpace = P.whiteSpace myTokenParser
parens = P.parens myTokenParser
braces = P.braces myTokenParser
angles = P.angles myTokenParser
brackets = P.brackets myTokenParser
squares = P.squares myTokenParser
semi = P.semi myTokenParser 
comma = P.comma myTokenParser
colon = P.colon myTokenParser
dot = P.dot myTokenParser
semiSep = P.semiSep myTokenParser
semiSep1 = P.semiSep1 myTokenParser
commaSep = P.commaSep myTokenParser
commaSep1 = P.commaSep1 myTokenParser


ourLanguageDef :: P.GenLanguageDef [Char] () Identity
ourLanguageDef = P.LanguageDef{
  P.commentStart = "@",
  P.commentEnd = "@",
  P.commentLine = "@@",
  P.nestedComments = False,
  P.identStart = letter <|> char '_',
  P.identLetter = letter <|> char '_',
  P.opStart = oneOf "",
  P.opLetter = oneOf "",
  P.reservedNames =  ["SuperCollider", "TidalCycles", "Extempore","Hydra","Gibber","SonicPi"],
  P.reservedOpNames = [],
  P.caseSensitive = False
 }



type Praser = ParsecT [Char] () Identity 

-- parsing is simply going from input to output, the stream of characters turns into something else

liveCodingLanguage :: Parser LiveCodingLanguage  -- ParsecT [Char] -> Indentity 
liveCodingLanguage = do
  -- x <- string "SuperCollider" -- x :: String
  P.whiteSpace
  superCollider
  <|> tidalCycles
  <|> (P.reserved "Extempore" >> return Extempore)
  <|> (P.reserved "Hydra" >> return Hydra)
  <|> sonicPi
  <|> (P.reserved "Gibber" >> return Gibber)

--Taken care of all the variations in our parsing system that we will except
  
superCollider :: Parser LiveCodingLanguage  -- making case senstive means we can have other stuff
superCollider = do
  try (P.reserved "SuperCollider") <|> try (P.reserved "SC")
  x <- natural <|> (return 3)
  -- if there is a number use that as a version , if there is a number default to version 3
  return (SuperCollider fromIntegral x)

tidalCycles :: Parser LiveCodingLanguage  -- making case senstive means we can have other stuff
tidalCycles = do
  try (P.reserved "TidalCycles") <|> try (P.reserved "Tidal")
  return TidalCycles

sonicPi :: Parser LiveCodingLanguage  -- making case senstive means we can have other stuff
sonicPi = do
  try (P.reserved "SonicPi") <|> try (P.reserved "SP")
  return sonicPi


 --  return SuperCollider -- if the next characters we are consuming are related to the string above, return that value (pure to a change)

myParser :: String -> Either ParseError LiveCodingLanguage
myParser x = parse liveCodingLanguage "" x
  -- myParser = parser LiveCodingLanguage 


{-

*Main> myParser "Extempore"
Right Extempore
*Main> myParser "SonicPi"
Left (line 1, column 1):
unexpected "o"
expecting "SuperCollider"
*Main> myParser "Gibber"
Right Gibber
*Main> myParser "TudalCycles"
Left (line 1, column 1):
unexpected "u"
expecting "TidalCycles"
*Main> 


-- Sonic Pi clashed with SuperCollider since they both start with the same letter
-- the try monad helps prevent the parser beleiving it has consume an an input 

-}
