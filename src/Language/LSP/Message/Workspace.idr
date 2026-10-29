module Language.LSP.Message.Workspace

import Data.SortedMap
import Language.LSP.Message.DocumentSymbols
import Language.LSP.Message.Location
import Language.LSP.Message.Progress
import Language.LSP.Message.TextDocument
import Language.LSP.Message.URI
import Language.LSP.Message.Utils
import Language.Reflection

%language ElabReflection
%default total

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#textEdit
public export
record TextEdit where
  constructor MkTextEdit
  range   : Range
  newText : String
%runElab derive "TextEdit" [FromJSONLSP, ToJSONLSP, Eq]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#textEdit
public export
record ChangeAnnotation where
  constructor MkChangeAnnotation
  label             : String
  needsConfirmation : Maybe Bool
  description       : Maybe String
%runElab derive "ChangeAnnotation" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#textEdit
public export
ChangeAnnotationIdentifier : Type
ChangeAnnotationIdentifier = String

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#textEdit
public export
record AnnotatedTextEdit where
  constructor MkAnnotatedTextEdit
  range        : Range
  newText      : String
  annotationId : ChangeAnnotationIdentifier
%runElab derive "AnnotatedTextEdit" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#textDocumentEdit
public export
record TextDocumentEdit where
  constructor MkTextDocumentEdit
  textDocument : OptionalVersionedTextDocumentIdentifier
  edits        : List (OneOf [TextEdit, AnnotatedTextEdit])
%runElab derive "TextDocumentEdit" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#textDocument_completion
public export
record InsertReplaceEdit where
  constructor MkInsertReplaceEdit
  newText : String
  insert  : Range
  replace : Range
%runElab derive "InsertReplaceEdit" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#resourceChanges
public export
record CreateFileOptions where
  constructor MkCreateFileOptions
  overwrite      : Maybe Bool
  ignoreIfExists : Maybe Bool
%runElab derive "CreateFileOptions" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#resourceChanges
public export
record RenameFileOptions where
  constructor MkRenameFileOptions
  overwrite      : Maybe Bool
  ignoreIfExists : Maybe Bool
%runElab derive "RenameFileOptions" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#resourceChanges
public export
record DeleteFileOptions where
  constructor MkDeleteFileOptions
  recursive         : Maybe Bool
  ignoreIfNotExists : Maybe Bool
%runElab derive "DeleteFileOptions" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#resourceChanges
public export
record CreateFile where
  constructor MkCreateFile
  kind         : Only (JString "create")
  uri          : DocumentURI
  options      : Maybe CreateFileOptions
  annotationId : ChangeAnnotationIdentifier
%runElab derive "CreateFile" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#resourceChanges
public export
record RenameFile where
  constructor MkRenameFile
  kind         : Only (JString "rename")
  oldUri       : DocumentURI
  newUri       : DocumentURI
  options      : Maybe RenameFileOptions
  annotationId : ChangeAnnotationIdentifier
%runElab derive "RenameFile" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#resourceChanges
public export
record DeleteFile where
  constructor MkDeleteFile
  kind         : Only (JString "delete")
  uri          : DocumentURI
  options      : Maybe DeleteFileOptions
  annotationId : ChangeAnnotationIdentifier
%runElab derive "DeleteFile" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspaceEdit
public export
record WorkspaceEdit where
  constructor MkWorkspaceEdit
  changes           : Maybe (SortedMap DocumentURI (List TextEdit))
  documentChanges   : Maybe (List (OneOf [TextDocumentEdit, CreateFile, RenameFile, DeleteFile]))
  changeAnnotations : Maybe (SortedMap String ChangeAnnotation)
%runElab derive "WorkspaceEdit" [FromJSONLSP, ToJSONLSP]

namespace ResourceOperationKind
  ||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspaceEditClientCapabilities
  public export
  data ResourceOperationKind = Create | Rename | Delete

export
ToJSON ResourceOperationKind where
  toJSON Create = JString "create"
  toJSON Rename = JString "rename"
  toJSON Delete = JString "delete"

export
FromJSON ResourceOperationKind where
  fromJSON (JString "create") = pure Create
  fromJSON (JString "rename") = pure Rename
  fromJSON (JString "delete") = pure Delete
  fromJSON _ = fail "not create|rename|delete"

namespace FailureHandlingKind
  ||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspaceEditClientCapabilities
  public export
  data FailureHandlingKind = Abort | Transactional | Undo | TextOnlyTransactional

export
ToJSON FailureHandlingKind where
  toJSON Abort                 = JString "abort"
  toJSON Transactional         = JString "transactional"
  toJSON Undo                  = JString "undo"
  toJSON TextOnlyTransactional = JString "textOnlyTransactional"

export
FromJSON FailureHandlingKind where
  fromJSON (JString "abort")                 = pure Abort
  fromJSON (JString "transactional")         = pure Transactional
  fromJSON (JString "undo")                  = pure Undo
  fromJSON (JString "textOnlyTransactional") = pure TextOnlyTransactional
  fromJSON _ = fail "not a failure handing, abort|transactional|undo|textOnlyTransactional"

namespace WorkspaceEditClientCapabilities
  ||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspaceEditClientCapabilities
  public export
  record ChangeAnnotationSupport where
    constructor MkChangeAnnotationSupport
    groupsOnLabel : Maybe Bool
  %runElab derive "ChangeAnnotationSupport" [FromJSONLSP, ToJSONLSP]


||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspaceEditClientCapabilities
public export
record WorkspaceEditClientCapabilities where
  constructor MkWorkspaceEditClientCapabilities
  documentChanges         : Maybe Bool
  resourceOperations      : Maybe (List ResourceOperationKind)
  failureHandling         : Maybe FailureHandlingKind
  normalizesLineEndings   : Maybe Bool
  changeAnnotationSupport : Maybe ChangeAnnotationSupport
%runElab derive "WorkspaceEditClientCapabilities" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_workspaceFolders
public export
record WorkspaceFoldersServerCapabilities where
  constructor MkWorkspaceFoldersServerCapabilities
  supported           : Maybe Bool
  changeNotifications : Maybe (OneOf [String, Bool])
%runElab derive "WorkspaceFoldersServerCapabilities" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_workspaceFolders
public export
record WorkspaceFolder where
  constructor MkWorkspaceFolder
  uri  : DocumentURI
  name : String
%runElab derive "WorkspaceFolder" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_didChangeWorkspaceFolders
public export
interface WorkspaceFoldersChangeEvent where
  added   : List WorkspaceFolder;
  removed : List WorkspaceFolder;
%runElab derive "WorkspaceFoldersChangeEvent" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_didChangeWorkspaceFolders
public export
record DidChangeWorkspaceFoldersParams where
  constructor MkDidChangeWorkspaceFoldersParams
  event : WorkspaceFoldersChangeEvent
%runElab derive "DidChangeWorkspaceFoldersParams" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_didChangeConfiguration
public export
record DidChangeConfigurationClientCapabilities where
  constructor MkDidChangeConfigurationClientCapabilities
  dynamicRegistration : Maybe Bool
%runElab derive "DidChangeConfigurationClientCapabilities" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_didChangeConfiguration
public export
record DidChangeConfigurationParams where
  constructor MkDidChangeConfigurationParams
  settings : JSON
%runElab derive "DidChangeConfigurationParams" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_configuration
public export
record ConfigurationItem where
  constructor MkConfigurationItem
  scopeUri : Maybe DocumentURI;
  section  : Maybe String
%runElab derive "ConfigurationItem" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_configuration
public export
record ConfigurationParams where
  constructor MkConfigurationParams
  items : List ConfigurationItem
%runElab derive "ConfigurationParams" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_didChangeWatchedFiles
public export
record DidChangeWatchedFilesClientCapabilities where
  constructor MkDidChangeWatchedFilesClientCapabilities
  dynamicRegistration : Maybe Bool
%runElab derive "DidChangeWatchedFilesClientCapabilities" [FromJSONLSP, ToJSONLSP]

namespace WatchKind
  ||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_didChangeWatchedFiles
  public export
  data WatchKind = Create | Change | Delete

watchKindToBits8 : WatchKind -> Bits8
watchKindToBits8 Create = 1
watchKindToBits8 Change = 2
watchKindToBits8 Delete = 4

export
ToJSON (List WatchKind) where
  toJSON = toJSON . foldr (prim__or_Bits8 . watchKindToBits8) 0

export
FromJSON (List WatchKind) where
  fromJSON (JInteger x) = pure $ filter ((/=) 0 . prim__and_Bits8 (cast $ cast {to = Integer} x) . watchKindToBits8) [Create, Change, Delete]
  fromJSON _ = fail "not a watch kind"

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_didChangeWatchedFiles
public export
record FileSystemWatcher where
  constructor MkFileSystemWatcher
  globPattern : String
  kind        : Maybe (List WatchKind)
%runElab derive "FileSystemWatcher" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_didChangeWatchedFiles
public export
record DidChangeWatchedFilesRegistrationOptions where
  constructor MkDidChangeWatchedFilesRegistrationOptions
  watchers : List FileSystemWatcher
%runElab derive "DidChangeWatchedFilesRegistrationOptions" [FromJSONLSP, ToJSONLSP]

namespace FileChangeType
  ||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_didChangeWatchedFiles
  public export
  data FileChangeType = Created | Changed | Deleted

export
ToJSON FileChangeType where
  toJSON Created = JInteger 1
  toJSON Changed = JInteger 2
  toJSON Deleted = JInteger 3

export
FromJSON FileChangeType where
  fromJSON (JInteger 1) = pure Created
  fromJSON (JInteger 2) = pure Changed
  fromJSON (JInteger 3) = pure Deleted
  fromJSON _ = fail "not a file change type, 1|2|3"

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_didChangeWatchedFiles
public export
record FileEvent where
  constructor MkFileEvent
  uri : DocumentURI
  type : FileChangeType
%runElab derive "FileEvent" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_didChangeWatchedFiles
public export
record DidChangeWatchedFilesParams where
  constructor MkDidChangeWatchedFilesParams
  changes : List FileEvent
%runElab derive "DidChangeWatchedFilesParams" [FromJSONLSP, ToJSONLSP]

namespace WorkspaceSymbolClientCapabilities
  ||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_symbol
  public export
  record SymbolKindClientCapabilities where
    constructor MkSymbolKindClientCapabilities
    valueSet : Maybe (List SymbolKind)
  %runElab derive "SymbolKindClientCapabilities" [FromJSONLSP, ToJSONLSP]

  ||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_symbol
  public export
  record TagSupportClientCapabilities where
    constructor MkTagSupportClientCapabilities
    valueSet : List SymbolTag
  %runElab derive "TagSupportClientCapabilities" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_symbol
public export
record WorkspaceSymbolClientCapabilities where
  constructor MkWorkspaceSymbolClientCapabilities
  dynamicRegistration : Maybe Bool
  symbolKind          : Maybe SymbolKindClientCapabilities
  tagSupport          : TagSupportClientCapabilities
%runElab derive "WorkspaceSymbolClientCapabilities" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_symbol
public export
record WorkspaceSymbolOptions where
  constructor MkWorkspaceSymbolOptions
  workDoneProgress : Maybe Bool
%runElab derive "WorkspaceSymbolOptions" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_symbol
public export
record WorkspaceSymbolRegistrationOptions where
  constructor MkWorkspaceSymbolRegistrationOptions
  workDoneProgress : Maybe Bool
%runElab derive "WorkspaceSymbolRegistrationOptions" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_symbol
public export
record WorkspaceSymbolParams where
  constructor MkWorkspaceSymbolParams
  partialResultToken : Maybe ProgressToken
  query              : String
%runElab derive "WorkspaceSymbolParams" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_applyEdit
public export
record ApplyWorkspaceEditParams where
  constructor MkApplyWorkspaceEditParams
  label : Maybe String
  edit  : WorkspaceEdit
%runElab derive "ApplyWorkspaceEditParams" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_applyEdit
public export
record ApplyWorkspaceEditResponse where
  constructor MkApplyWorkspaceEditResponse
  applied       : Bool
  failureReason : Maybe String
  failedChange  : Maybe Integer
%runElab derive "ApplyWorkspaceEditResponse" [FromJSONLSP, ToJSONLSP]

namespace FileOperationPatternKind
  ||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_willCreateFiles
  public export
  data FileOperationPatternKind = FileKind | FolderKind

export
ToJSON FileOperationPatternKind where
  toJSON FileKind   = JString "file"
  toJSON FolderKind = JString "folder"

export
FromJSON FileOperationPatternKind where
  fromJSON (JString "file")   = pure FileKind
  fromJSON (JString "folder") = pure FolderKind
  fromJSON _ = fail "not file|folder"

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_willCreateFiles
public export
record FileOperationPatternOptions where
  constructor MkFileOperationPatternOptions
  ignoreCase : Maybe Bool
%runElab derive "FileOperationPatternOptions" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_willCreateFiles
public export
record FileOperationPattern where
  constructor MkFileOperationPattern
  glob    : String
  matches : Maybe FileOperationPatternKind
  options : FileOperationPatternOptions
%runElab derive "FileOperationPattern" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_willCreateFiles
public export
record FileOperationFilter where
  constructor MkFileOperationFilter
  scheme  : Maybe String
  pattern : FileOperationPattern
%runElab derive "FileOperationFilter" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_willCreateFiles
public export
record FileOperationRegistrationOptions where
  constructor MkFileOperationRegistrationOptions
  filters : List FileOperationFilter
%runElab derive "FileOperationRegistrationOptions" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_willCreateFiles
public export
record FileCreate where
  constructor MkFileCreate
  uri : URI
%runElab derive "FileCreate" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_willCreateFiles
public export
record CreateFilesParams where
  constructor MkCreateFilesParams
  files : List FileCreate
%runElab derive "CreateFilesParams" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_willRenameFiles
public export
record FileRename where
  constructor MkFileRename
  oldUri : URI
  newUri : URI
%runElab derive "FileRename" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_willRenameFiles
public export
record RenameFilesParams where
  constructor MkRenameFilesParams
  files : List FileRename
%runElab derive "RenameFilesParams" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_didRenameFiles
public export
record FileDelete where
  constructor MkFileDelete
  uri : URI
%runElab derive "FileDelete" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#workspace_didRenameFiles
public export
record DeleteFilesParams where
  constructor MkDeleteFilesParams
  files : List FileDelete
%runElab derive "DeleteFilesParams" [FromJSONLSP, ToJSONLSP]
