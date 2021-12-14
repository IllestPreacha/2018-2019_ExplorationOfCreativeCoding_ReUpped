import Text.Parsec 
import Text.ParserCombinators.Parsec.Prim hiding (try)
import Data.Functor.Identity
import qualified Text.Parsec.Token as P

data LiveCodingLanguage = 
  SuperCollider Int |
  TidalCycles |
  Extempore |
  Hydra |
  SonicPi 
  deriving (Show,Eq)

-- myTokenParser :: GenTokenParser s u m -- wouldn't work at all
-- myTokenParser :: Stream s m Char => GenTokenParser s u m -- would work but is a bit lazy
myTokenParser :: P.GenTokenParser [Char] () Identity
myTokenParser = P.makeTokenParser ourLanguageDef
identifier = P.identifier myTokenParser
reserved = P.reserved myTokenParser
operator = P.operator myTokenParser
reservedOp = P.reservedOp myTokenParser
charLiteral = P.charLiteral myTokenParser
stringLiteral = P.stringLiteral myTokenParser
natural = P.natural myTokenParser
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
ourLanguageDef = P.LanguageDef {
  P.commentStart = "@",
  P.commentEnd = "@",
  P.commentLine = "@@",
  P.nestedComments = False,
  P.identStart = letter <|> char '_',
  P.identLetter = letter <|> char '_',
  P.opStart = oneOf "",
  P.opLetter = oneOf "",
  P.reservedNames = [ "SuperCollider","SC","TidalCycles","Tidal","Hydra","Extempore","SonicPi" ],
  P.reservedOpNames = [],
  P.caseSensitive = False
  }

liveCodingLanguage :: Parser LiveCodingLanguage 
liveCodingLanguage = do
  whiteSpace
  superCollider
    <|> tidalCycles 
    <|> (reserved "Extempore" >> return Extempore)
    <|> (reserved "Hydra" >> return Hydra)
    <|> (reserved "SonicPi" >> return SonicPi)

superCollider :: Parser LiveCodingLanguage
superCollider = do
  try (reserved "SuperCollider") <|> try (reserved "SC")
  x <- natural <|> (return 3)
  return (SuperCollider (fromIntegral x))
tidalCycles :: Parser LiveCodingLanguage
tidalCycles = do
  try (reserved "TidalCycles") <|> try (reserved "Tidal") 
  return TidalCycles

myParser :: String -> Either ParseError LiveCodingLanguage
myParser x = parse liveCodingLanguage "" x
-- myParser = parse liveCodingLanguage

