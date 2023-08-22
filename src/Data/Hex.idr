module Data.Hex

import Data.Bits
import Data.List

%default total

export
parseHex : Char -> Maybe (Fin 16)
parseHex '0' = Just 0
parseHex '1' = Just 1
parseHex '2' = Just 2
parseHex '3' = Just 3
parseHex '4' = Just 4
parseHex '5' = Just 5
parseHex '6' = Just 6
parseHex '7' = Just 7
parseHex '8' = Just 8
parseHex '9' = Just 9
parseHex 'a' = Just 10
parseHex 'A' = Just 10
parseHex 'b' = Just 11
parseHex 'B' = Just 11
parseHex 'c' = Just 12
parseHex 'C' = Just 12
parseHex 'd' = Just 13
parseHex 'D' = Just 13
parseHex 'e' = Just 14
parseHex 'E' = Just 14
parseHex 'f' = Just 15
parseHex 'F' = Just 15
parseHex _ = Nothing

export
hexDigit : Fin 16 -> Char
hexDigit 0 = '0'
hexDigit 1 = '1'
hexDigit 2 = '2'
hexDigit 3 = '3'
hexDigit 4 = '4'
hexDigit 5 = '5'
hexDigit 6 = '6'
hexDigit 7 = '7'
hexDigit 8 = '8'
hexDigit 9 = '9'
hexDigit 10 = 'a'
hexDigit 11 = 'b'
hexDigit 12 = 'c'
hexDigit 13 = 'd'
hexDigit 14 = 'e'
hexDigit 15 = 'f'

export
leftPad : Char -> Nat -> String -> String
leftPad paddingChar padToLength str =
  if length str < padToLength
    then pack (List.replicate (minus padToLength (length str)) paddingChar) ++ str
    else str

hexListLittleEndianToInteger : List (Fin 16) -> Integer
hexListLittleEndianToInteger = go 1
  where
    go : Integer -> List (Fin 16) -> Integer
    go multiplier [] = 0
    go multiplier (d :: ds) = cast d * multiplier + go (16 * multiplier) ds

||| Convert little-endian hex-string to Integer.
||| Fails if the string doesn't represent a hexadecimal number.
||| As for the latin letters in the hex-string, both lower- and upper- case letters represent valid hex characters.
||| Examples of valid hex-strings:
||| FFF ✔
||| fEA ✔
||| hello ✗
||| 1F62aA7 ✔
export
fromHexLittleEndian : String -> Maybe Integer
fromHexLittleEndian str = do
  hexList <- traverse parseHex (unpack str)
  Just (hexListLittleEndianToInteger hexList)

||| Just like `fromHexLittleEndian` but for big-endian hex-strings.
export
fromHexBigEndian : String -> Maybe Integer
fromHexBigEndian str = do
  hexList <- traverse parseHex (reverse (unpack str))
  Just (hexListLittleEndianToInteger hexList)
