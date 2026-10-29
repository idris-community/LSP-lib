module Language.LSP.Message.Registration

import Language.LSP.Message.Utils
import Language.Reflection

%language ElabReflection
%default total

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#client_registerCapability
public export
record Registration where
  constructor MkRegistration
  id              : String
  method          : String
  registerOptions : Maybe JSON
%runElab derive "Registration" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#client_registerCapability
public export
record RegistrationParams where
  constructor MkRegistrationParams
  registrations : List Registration
%runElab derive "RegistrationParams" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#client_unregisterCapability
public export
record Unregistration where
  constructor MkUnregistration
  id     : String
  method : String
%runElab derive "Unregistration" [FromJSONLSP, ToJSONLSP]

||| Refer to https://microsoft.github.io/language-server-protocol/specification.html#client_unregisterCapability
public export
record UnregistrationParams where
  constructor MkUnregistrationParams
  -- NOTE: not my typo, but see the specification link in the record documentation
  unregisterations : List Unregistration
%runElab derive "UnregistrationParams" [FromJSONLSP, ToJSONLSP]
