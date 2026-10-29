||| Common types and instances for JSON interoperability.
|||
||| (C) The Idris Community, 2021
module Language.LSP.Message.Utils

import public Data.OneOf
import public JSON.Simple
import public JSON.Simple.Derive
import public JSON.RPC

%default total

||| Converts an `UntaggedEither` value to the isomorphic value in `Either`.
public export
toEither : OneOf [a, b] -> Either a b
toEither (Here x)  = Left x
toEither (There (Here x)) = Right x

||| Converts an `Either` value to the isomorphic value in `UntaggedEither`.
public export
fromEither : Either a b -> OneOf [a, b]
fromEither (Left x)  = Here x
fromEither (Right x) = There (Here x)

public export
toMaybe : OneOf [a, Null] -> Maybe a
toMaybe (Here x) = Just x
toMaybe (There (Here MkNull)) = Nothing

public export
fromMaybe : Maybe a -> OneOf [a, Null]
fromMaybe (Just x) = make x
fromMaybe Nothing = make MkNull

public export
ConstraintList : (Type -> Type) -> List Type -> Type
ConstraintList f [] = ()
ConstraintList f (x :: xs) = (f x, ConstraintList f xs)

export
ConstraintList ToJSON as => ToJSON (OneOf as) where
  toJSON (Here x) = toJSON x
  toJSON (There x) = toJSON x

export
Alternative (Either JSONErr) where
  empty = Left ([], "")
  (<|>) (Left e) (Left _) = Left e
  (<|>) (Left _) (Right v) = Right v
  (<|>) (Right v) _ = Right v

export
[ParserF] Functor (Parser v) where
  map f p = \x => map f (p x)

parseConstraints :
  {as : List Type} ->
  ConstraintList FromJSON as =>
  Parser JSON (OneOf as)
parseConstraints {as = []} = const $ fail "expected at least one element"
parseConstraints {as = (x :: xs)} @{(c, cs)}
  = let xx = map @{ParserF} (There {x}) (parseConstraints @{cs})
        yy = map @{ParserF} (Here {xs}) (fromJSON @{c})
    in xx <|> yy

export
{as : _} -> ConstraintList FromJSON as => FromJSON (OneOf as) where
  -- NOTE: The rightmost type is parsed first, since in the LSP specification
  --       the most specific type appears also rightmost.
  fromJSON {as} v = parseConstraints v

public export
data Only : JSON -> Type where
  OnlyValue : (v : JSON) -> Only v

export
{v : _} -> FromJSON (Only v) where
  fromJSON x = case x == v of
                    True => Right (OnlyValue v)
                    False => Left ([], "expected \{encode v}, but got \{encode x} instead")

export
ToJSON (Only v) where
  toJSON (OnlyValue x) = x

optionalParam : String -> Bool
optionalParam "parameters" = True
optionalParam _ = False

export
nullMissingFields : Options
nullMissingFields = {replaceMissingKeysWithNull := optionalParam} defaultOptions

renameKeyword : String -> String
renameKeyword "data_" = "data"
renameKeyword "parameters_" = "parameters"
renameKeyword "external_" = "external"
renameKeyword "implementation_" = "implementation"
renameKeyword x = x

export
renameKeywordOpts : Options
renameKeywordOpts = {fieldNameModifier := renameKeyword} defaultOptions

export
ToJSONLSP : List Name -> ParamTypeInfo -> Res (List TopLevel)
ToJSONLSP = customToJSON Export $
  { replaceMissingKeysWithNull := const True
  , fieldNameModifier := renameKeyword
  , unwrapUnary := False
  }
  defaultOptions

export
FromJSONLSP : List Name -> ParamTypeInfo -> Res (List TopLevel)
FromJSONLSP = customFromJSON Export ({replaceMissingKeysWithNull := const True, fieldNameModifier := renameKeyword} defaultOptions)
