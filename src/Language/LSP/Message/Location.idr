module Language.LSP.Message.Location

import Data.URI
import Language.LSP.Message.URI
import Language.LSP.Message.Utils
import Language.Reflection

%hide Prelude.Range
%hide Text.Bounds.Position
%language ElabReflection
%default total

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#position
public export
record Position where
  constructor MkPosition
  line      : Int
  character : Int
%runElab derive "Position" [FromJSONLSP, ToJSONLSP, Eq]


||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#range
public export
record Range where
  constructor MkRange
  start : Position
  end   : Position
%runElab derive "Range" [FromJSONLSP, ToJSONLSP, Eq]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#location
public export
record Location where
  constructor MkLocation
  uri   : URI
  range : Range
%runElab derive "Location" [FromJSONLSP, ToJSONLSP, Eq]


||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#locationLink
public export
record LocationLink where
  constructor MkLocationLink
  originSelectionRange : Maybe Range
  targetUri            : URI
  targetRange          : Range
  targetSelectionRange : Range
%runElab derive "LocationLink" [FromJSONLSP, ToJSONLSP]
