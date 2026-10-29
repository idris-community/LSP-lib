module Language.LSP.Message.SelectionRange

import Language.LSP.Message.Location
import Language.LSP.Message.Progress
import Language.LSP.Message.TextDocument
import Language.LSP.Message.Utils
import Language.Reflection

import Data.Either

%language ElabReflection
%default total
%hide Text.Bounds.Position

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#textDocument_selectionRange
public export
record SelectionRangeClientCapabilities where
  constructor MkSelectionRangeClientCapabilities
  dynamicRegistration : Maybe Bool
%runElab derive "SelectionRangeClientCapabilities" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#textDocument_selectionRange
public export
record SelectionRangeOptions where
  constructor MkSelectionRangeOptions
  workDoneProgress : Maybe Bool
%runElab derive "SelectionRangeOptions" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#textDocument_selectionRange
public export
record SelectionRangeRegistrationOptions where
  constructor MkSelectionRangeRegistrationOptions
  workDoneProgress : Maybe Bool
  documentSelector : OneOf [DocumentSelector, Null]
  id               : Maybe String
%runElab derive "SelectionRangeRegistrationOptions" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#textDocument_selectionRange
public export
record SelectionRangeParams where
  constructor MkSelectionRangeParams
  workDoneToken      : Maybe ProgressToken
  partialResultToken : Maybe ProgressToken
  textDocument       : TextDocumentIdentifier
  positions          : List Location.Position
%runElab derive "SelectionRangeParams" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#textDocument_selectionRange
public export
record SelectionRange where
  constructor MkSelectionRange
  range  : Range
  parent : Maybe SelectionRange

%runElab derive "SelectionRange" [FromJSONLSP, ToJSONLSP]
