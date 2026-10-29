module Language.LSP.Message.Method

import public Data.DPair
import Language.LSP.Message.Utils
import Language.Reflection

%language ElabReflection
%default total

public export
data MethodFrom = Client | Server

public export
data MethodType = Notification | Request

public export
data Method : MethodFrom -> MethodType -> Type where
  Initialize                          : Method Client Request
  Initialized                         : Method Client Notification
  Shutdown                            : Method Client Request
  Exit                                : Method Client Notification
  SetTrace                            : Method Client Notification
  WindowWorkDoneProgressCancel        : Method Client Notification
  WorkspaceDidChangeWorkspaceFolders  : Method Client Notification
  WorkspaceDidChangeConfiguration     : Method Client Notification
  WorkspaceDidChangeWatchedFiles      : Method Client Notification
  WorkspaceSymbol                     : Method Client Request
  WorkspaceExecuteCommand             : Method Client Request
  WorkspaceWillCreateFiles            : Method Client Request
  TextDocumentDidOpen                 : Method Client Notification
  TextDocumentDidChange               : Method Client Notification
  TextDocumentWillSave                : Method Client Notification
  TextDocumentWillSaveWaitUntil       : Method Client Request
  TextDocumentDidSave                 : Method Client Notification
  TextDocumentDidClose                : Method Client Notification
  TextDocumentCompletion              : Method Client Request
  CompletionItemResolve               : Method Client Request
  TextDocumentHover                   : Method Client Request
  TextDocumentSignatureHelp           : Method Client Request
  TextDocumentDeclaration             : Method Client Request
  TextDocumentDefinition              : Method Client Request
  TextDocumentTypeDefinition          : Method Client Request
  TextDocumentImplementation          : Method Client Request
  TextDocumentReferences              : Method Client Request
  TextDocumentDocumentHighlight       : Method Client Request
  TextDocumentDocumentSymbol          : Method Client Request
  TextDocumentCodeAction              : Method Client Request
  CodeActionResolve                   : Method Client Request
  TextDocumentCodeLens                : Method Client Request
  CodeLensResolve                     : Method Client Request
  TextDocumentDocumentLink            : Method Client Request
  DocumentLinkResolve                 : Method Client Request
  TextDocumentDocumentColor           : Method Client Request
  TextDocumentFormatting              : Method Client Request
  TextDocumentRangeFormatting         : Method Client Request
  TextDocumentOnTypeFormatting        : Method Client Request
  TextDocumentRename                  : Method Client Request
  TextDocumentPrepareRename           : Method Client Request
  TextDocumentFoldingRange            : Method Client Request
  TextDocumentSelectionRange          : Method Client Request
  TextDocumentPrepareCallHierarchy    : Method Client Request
  CallHierarchyIncomingCalls          : Method Client Request
  CallHierarchyOutgoingCalls          : Method Client Request
  TextDocumentSemanticTokensFull      : Method Client Request
  TextDocumentSemanticTokensFullDelta : Method Client Request
  TextDocumentSemanticTokensRange     : Method Client Request
  TextDocumentLinkedEditingRange      : Method Client Request
  TextDocumentMoniker                 : Method Client Request

  LogTrace                            : Method Server Notification
  WindowShowMessage                   : Method Server Notification
  WindowShowMessageRequest            : Method Server Request
  WindowShowDocument                  : Method Server Request
  WindowLogMessage                    : Method Server Notification
  WindowWorkDoneProgressCreate        : Method Server Request
  TelemetryEvent                      : Method Server Notification
  ClientRegisterCapability            : Method Server Request
  ClientUnregisterCapability          : Method Server Request
  WorkspaceWorkspaceFolders           : Method Server Request
  WorkspaceConfiguration              : Method Server Request
  WorkspaceApplyEdit                  : Method Server Request
  TextDocumentPublishDiagnostics      : Method Server Notification
  WorkspaceCodeLensRefresh            : Method Server Request
  WorkspaceSemanticTokensRefresh      : Method Server Request

  CancelRequest                       : Method from   Notification
  Progress                            : Method from   Notification

export
methodType : Method type from -> MethodType
methodType Initialize = Request
methodType Initialized = Notification
methodType Shutdown = Request
methodType Exit = Notification
methodType SetTrace = Notification
methodType WindowWorkDoneProgressCancel = Notification
methodType WorkspaceDidChangeWorkspaceFolders = Notification
methodType WorkspaceDidChangeConfiguration = Notification
methodType WorkspaceDidChangeWatchedFiles = Notification
methodType WorkspaceSymbol = Request
methodType WorkspaceExecuteCommand = Request
methodType WorkspaceWillCreateFiles = Request
methodType TextDocumentDidOpen = Notification
methodType TextDocumentDidChange = Notification
methodType TextDocumentWillSave = Notification
methodType TextDocumentWillSaveWaitUntil = Request
methodType TextDocumentDidSave = Notification
methodType TextDocumentDidClose = Notification
methodType CompletionItemResolve = Request
methodType TextDocumentHover = Request
methodType TextDocumentSignatureHelp = Request
methodType TextDocumentDeclaration = Request
methodType TextDocumentDefinition = Request
methodType TextDocumentTypeDefinition = Request
methodType TextDocumentImplementation = Request
methodType TextDocumentReferences = Request
methodType TextDocumentDocumentHighlight = Request
methodType TextDocumentDocumentSymbol = Request
methodType TextDocumentCodeAction = Request
methodType CodeActionResolve = Request
methodType TextDocumentCodeLens = Request
methodType CodeLensResolve = Request
methodType TextDocumentDocumentLink = Request
methodType DocumentLinkResolve = Request
methodType TextDocumentDocumentColor = Request
methodType TextDocumentFormatting = Request
methodType TextDocumentRangeFormatting = Request
methodType TextDocumentOnTypeFormatting = Request
methodType TextDocumentRename = Request
methodType TextDocumentPrepareRename = Request
methodType TextDocumentFoldingRange = Request
methodType TextDocumentSelectionRange = Request
methodType TextDocumentPrepareCallHierarchy = Request
methodType CallHierarchyIncomingCalls = Request
methodType CallHierarchyOutgoingCalls = Request
methodType TextDocumentSemanticTokensFull = Request
methodType TextDocumentSemanticTokensFullDelta = Request
methodType TextDocumentSemanticTokensRange = Request
methodType WorkspaceSemanticTokensRefresh = Request
methodType TextDocumentLinkedEditingRange = Request
methodType TextDocumentMoniker = Request
methodType LogTrace = Notification
methodType WindowShowMessage = Notification
methodType WindowShowMessageRequest = Request
methodType WindowShowDocument = Request
methodType WindowLogMessage = Notification
methodType WindowWorkDoneProgressCreate = Request
methodType TelemetryEvent = Notification
methodType ClientRegisterCapability = Request
methodType ClientUnregisterCapability = Request
methodType WorkspaceWorkspaceFolders = Request
methodType WorkspaceConfiguration = Request
methodType WorkspaceApplyEdit = Request
methodType TextDocumentPublishDiagnostics = Notification
methodType TextDocumentCompletion = Request
methodType WorkspaceCodeLensRefresh = Request
methodType CancelRequest = Notification
methodType Progress = Notification

export
Show (Method type from) where
  show Initialize                          = "initialize"
  show Initialized                         = "initialized"
  show Shutdown                            = "shutdown"
  show Exit                                = "exit"
  show SetTrace                            = "$/setTrace"
  show WindowWorkDoneProgressCancel        = "window/workDoneProgress/cancel"
  show WorkspaceDidChangeWorkspaceFolders  = "workspace/didChangeWorkspaceFolders"
  show WorkspaceDidChangeConfiguration     = "workspace/didChangeConfiguration"
  show WorkspaceDidChangeWatchedFiles      = "workspace/didChangeWatchedFiles"
  show WorkspaceSymbol                     = "workspace/symbol"
  show WorkspaceExecuteCommand             = "workspace/executeCommand"
  show WorkspaceWillCreateFiles            = "workspace/willCreateFiles"
  show TextDocumentDidOpen                 = "textDocument/didOpen"
  show TextDocumentDidChange               = "textDocument/didChange"
  show TextDocumentWillSave                = "textDocument/willSave"
  show TextDocumentWillSaveWaitUntil       = "textDocument/willSaveWaitUntil"
  show TextDocumentDidSave                 = "textDocument/didSave"
  show TextDocumentDidClose                = "textDocument/didClose"
  show CompletionItemResolve               = "completionItem/resolve"
  show TextDocumentHover                   = "textDocument/hover"
  show TextDocumentSignatureHelp           = "textDocument/signatureHelp"
  show TextDocumentDeclaration             = "textDocument/declaration"
  show TextDocumentDefinition              = "textDocument/definition"
  show TextDocumentTypeDefinition          = "textDocument/typeDefinition"
  show TextDocumentImplementation          = "textDocument/implementation"
  show TextDocumentReferences              = "textDocument/references"
  show TextDocumentDocumentHighlight       = "textDocument/documentHighlight"
  show TextDocumentDocumentSymbol          = "textDocument/documentSymbol"
  show TextDocumentCodeAction              = "textDocument/codeAction"
  show CodeActionResolve                   = "codeAction/resolve"
  show TextDocumentCodeLens                = "textDocument/codeLens"
  show CodeLensResolve                     = "codeLens/resolve"
  show TextDocumentDocumentLink            = "textDocument/documentLink"
  show DocumentLinkResolve                 = "documentLink/resolve"
  show TextDocumentDocumentColor           = "textDocument/documentColor"
  show TextDocumentFormatting              = "textDocument/formatting"
  show TextDocumentRangeFormatting         = "textDocument/rangeFormatting"
  show TextDocumentOnTypeFormatting        = "textDocument/onTypeFormatting"
  show TextDocumentRename                  = "textDocument/rename"
  show TextDocumentPrepareRename           = "textDocument/prepareRename"
  show TextDocumentFoldingRange            = "textDocument/foldingRange"
  show TextDocumentSelectionRange          = "textDocument/selectionRange"
  show TextDocumentPrepareCallHierarchy    = "textDocument/prepareCallHierarchy"
  show CallHierarchyIncomingCalls          = "callHierarchy/incomingCalls"
  show CallHierarchyOutgoingCalls          = "callHierarchy/outgoingCalls"
  show TextDocumentSemanticTokensFull      = "textDocument/semanticTokens/full"
  show TextDocumentSemanticTokensFullDelta = "textDocument/semanticTokens/full/delta"
  show TextDocumentSemanticTokensRange     = "textDocument/semanticTokens/range"
  show WorkspaceSemanticTokensRefresh      = "workspace/semanticTokens/refresh"
  show TextDocumentLinkedEditingRange      = "textDocument/linkedEditingRange"
  show TextDocumentMoniker                 = "textDocument/moniker"
  show LogTrace                            = "$/logTrace"
  show WindowShowMessage                   = "window/showMessage"
  show WindowShowMessageRequest            = "window/showMessageRequest"
  show WindowShowDocument                  = "window/showDocument"
  show WindowLogMessage                    = "window/logMessage"
  show WindowWorkDoneProgressCreate        = "window/workDoneProgress/create"
  show TelemetryEvent                      = "telemetry/event"
  show ClientRegisterCapability            = "client/registerCapability"
  show ClientUnregisterCapability          = "client/unregisterCapability"
  show WorkspaceWorkspaceFolders           = "workspace/workspaceFolders"
  show WorkspaceConfiguration              = "workspace/configuration"
  show WorkspaceApplyEdit                  = "workspace/applyEdit"
  show TextDocumentPublishDiagnostics      = "textDocument/publishDiagnostics"
  show TextDocumentCompletion              = "textDocument/completion"
  show WorkspaceCodeLensRefresh            = "workspace/codeLens/refresh"
  show CancelRequest                       = "$/cancelRequest"
  show Progress                            = "$/progress"

export
ToJSON (Method type from) where
  toJSON = JString . show

export
FromJSON (Method Client Notification) where
  fromJSON (JString "initialized")                         = pure Initialized
  fromJSON (JString "exit")                                = pure Exit
  fromJSON (JString "$/setTrace")                          = pure SetTrace
  fromJSON (JString "window/workDoneProgress/cancel")      = pure WindowWorkDoneProgressCancel
  fromJSON (JString "workspace/didChangeWorkspaceFolders") = pure WorkspaceDidChangeWorkspaceFolders
  fromJSON (JString "workspace/didChangeConfiguration")    = pure WorkspaceDidChangeConfiguration
  fromJSON (JString "workspace/didChangeWatchedFiles")     = pure WorkspaceDidChangeWatchedFiles
  fromJSON (JString "textDocument/didOpen")                = pure TextDocumentDidOpen
  fromJSON (JString "textDocument/didChange")              = pure TextDocumentDidChange
  fromJSON (JString "textDocument/willSave")               = pure TextDocumentWillSave
  fromJSON (JString "textDocument/didSave")                = pure TextDocumentDidSave
  fromJSON (JString "textDocument/didClose")               = pure TextDocumentDidClose
  fromJSON (JString "$/cancelRequest")                     = pure CancelRequest
  fromJSON (JString "$/progress")                          = pure Progress
  fromJSON x = fail "invalid client notification: \{encode x}"

export
FromJSON (Method Client Request) where
  fromJSON (JString "initialize")                             = pure Initialize
  fromJSON (JString "shutdown")                               = pure Shutdown
  fromJSON (JString "workspace/symbol")                       = pure WorkspaceSymbol
  fromJSON (JString "workspace/executeCommand")               = pure WorkspaceExecuteCommand
  fromJSON (JString "workspace/willCreateFiles")              = pure WorkspaceWillCreateFiles
  fromJSON (JString "textDocument/willSaveWaitUntil")         = pure TextDocumentWillSaveWaitUntil
  fromJSON (JString "textDocument/completion")                = pure TextDocumentCompletion
  fromJSON (JString "completionItem/resolve")                 = pure CompletionItemResolve
  fromJSON (JString "textDocument/hover")                     = pure TextDocumentHover
  fromJSON (JString "textDocument/signatureHelp")             = pure TextDocumentSignatureHelp
  fromJSON (JString "textDocument/declaration")               = pure TextDocumentDeclaration
  fromJSON (JString "textDocument/definition")                = pure TextDocumentDefinition
  fromJSON (JString "textDocument/typeDefinition")            = pure TextDocumentTypeDefinition
  fromJSON (JString "textDocument/implementation")            = pure TextDocumentImplementation
  fromJSON (JString "textDocument/references")                = pure TextDocumentReferences
  fromJSON (JString "textDocument/documentHighlight")         = pure TextDocumentDocumentHighlight
  fromJSON (JString "textDocument/documentSymbol")            = pure TextDocumentDocumentSymbol
  fromJSON (JString "textDocument/codeAction")                = pure TextDocumentCodeAction
  fromJSON (JString "codeAction/resolve")                     = pure CodeActionResolve
  fromJSON (JString "textDocument/codeLens")                  = pure TextDocumentCodeLens
  fromJSON (JString "codeLens/resolve")                       = pure CodeLensResolve
  fromJSON (JString "textDocument/documentLink")              = pure TextDocumentDocumentLink
  fromJSON (JString "documentLink/resolve")                   = pure DocumentLinkResolve
  fromJSON (JString "textDocument/documentColor")             = pure TextDocumentDocumentColor
  fromJSON (JString "textDocument/formatting")                = pure TextDocumentFormatting
  fromJSON (JString "textDocument/rangeFormatting")           = pure TextDocumentRangeFormatting
  fromJSON (JString "textDocument/onTypeFormatting")          = pure TextDocumentOnTypeFormatting
  fromJSON (JString "textDocument/rename")                    = pure TextDocumentRename
  fromJSON (JString "textDocument/prepareRename")             = pure TextDocumentPrepareRename
  fromJSON (JString "textDocument/foldingRange")              = pure TextDocumentFoldingRange
  fromJSON (JString "textDocument/selectionRange")            = pure TextDocumentSelectionRange
  fromJSON (JString "textDocument/prepareCallHierarchy")      = pure TextDocumentPrepareCallHierarchy
  fromJSON (JString "callHierarchy/incomingCalls")            = pure CallHierarchyIncomingCalls
  fromJSON (JString "callHierarchy/outgoingCalls")            = pure CallHierarchyOutgoingCalls
  fromJSON (JString "textDocument/semanticTokens/full")       = pure TextDocumentSemanticTokensFull
  fromJSON (JString "textDocument/semanticTokens/full/delta") = pure TextDocumentSemanticTokensFullDelta
  fromJSON (JString "textDocument/semanticTokens/range")      = pure TextDocumentSemanticTokensRange
  fromJSON (JString "textDocument/linkedEditingRange")        = pure TextDocumentLinkedEditingRange
  fromJSON (JString "textDocument/moniker")                   = pure TextDocumentMoniker
  fromJSON x = fail "invalid client request: \{encode x}"

export
FromJSON (Method Server Notification) where
  fromJSON (JString "$/logTrace")                      = pure LogTrace
  fromJSON (JString "window/showMessage")              = pure WindowShowMessage
  fromJSON (JString "window/logMessage")               = pure WindowLogMessage
  fromJSON (JString "telemetry/event")                 = pure TelemetryEvent
  fromJSON (JString "textDocument/publishDiagnostics") = pure TextDocumentPublishDiagnostics
  fromJSON (JString "$/cancelRequest")                 = pure CancelRequest
  fromJSON (JString "$/progress")                      = pure Progress
  fromJSON x = fail "invalid server notification: \{encode x}"

export
FromJSON (Method Server Request) where
  fromJSON (JString "window/showMessageRequest")        = pure WindowShowMessageRequest
  fromJSON (JString "window/showDocument")              = pure WindowShowDocument
  fromJSON (JString "window/workDoneProgress/create")   = pure WindowWorkDoneProgressCreate
  fromJSON (JString "client/registerCapability")        = pure ClientRegisterCapability
  fromJSON (JString "client/unregisterCapability")      = pure ClientUnregisterCapability
  fromJSON (JString "workspace/workspaceFolders")       = pure WorkspaceWorkspaceFolders
  fromJSON (JString "workspace/configuration")          = pure WorkspaceConfiguration
  fromJSON (JString "workspace/applyEdit")              = pure WorkspaceApplyEdit
  fromJSON (JString "workspace/codeLens/refresh")       = pure WorkspaceCodeLensRefresh
  fromJSON (JString "workspace/semanticTokens/refresh") = pure WorkspaceSemanticTokensRefresh
  fromJSON x = fail "invalid server request \{encode x}"

export
FromJSON (from ** Method from Notification) where
  fromJSON arg =
    (fromJSON arg >>= \meth : Method Client Notification => pure (Client ** meth))
      `orElse` (fromJSON arg >>= \meth : Method Server Notification => pure (Server ** meth))

export
FromJSON (from ** Method from Request) where
  fromJSON arg =
    (fromJSON arg >>= \meth : Method Client Request => pure (_ ** meth))
      `orElse` (fromJSON arg >>= \meth : Method Server Request => pure (_ ** meth))

private infixl 5 `orElse`

export
FromJSON (from ** type ** Method from type) where
  fromJSON arg =
    (fromJSON arg >>= \meth : Method Client Notification => pure (_ ** _ ** meth))
      `orElse` (fromJSON arg >>= \meth : Method Client Request => pure (_ ** _ ** meth))
      `orElse` (fromJSON arg >>= \meth : Method Server Notification => pure (_ ** _ ** meth))
      `orElse` (fromJSON arg >>= \meth : Method Server Request => pure (_ ** _ ** meth))
