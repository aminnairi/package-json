module Main exposing ( main )

-- IMPORTS

import Browser
import Html exposing ( Html )
import Html.Attributes
import Html.Events
import Json.Encode
import List.Extra


-- MAIN


main : Program () Model Message
main =
  Browser.sandbox
    { init    = init
    , update  = update
    , view    = view
    }


-- VIEW


view : Model -> Html Message
view model =
  Html.div
    []
    [ Html.h1 [] [ Html.text "package.json generator" ]
    , viewPrivate model.private
    , viewName model.name
    , viewDescription model.description
    , viewVersion model.version
    , viewHomepage model.homepage
    , viewLicense model.license
    , viewMain model.main
    , viewBrowser model.browser
    , viewBugs model.bugs
    , viewAuthor model.author
    , viewRepository model.repository
    , viewEngines model.engines
    , viewCpus model.cpus
    , viewOperatingSystems model.operatingSystems
    , viewFiles model.files
    , viewKeywords model.keywords
    , viewContributors model.contributors
    , viewFundings model.fundings
    , viewScripts model.scripts
    , viewConfigurations model.configurations
    , viewDependencies model.dependencies
    , viewDevelopmentDependencies model.developmentDependencies
    , viewPeerDependencies model.peerDependencies
    , viewBundledDependencies model.bundledDependencies
    , viewOptionalDependencies model.optionalDependencies
    , viewModel model
    ]


viewKeywords : List String -> Html Message
viewKeywords keywords =
  Html.div
    []
    <| List.append
        [ Html.label [] [ Html.text "Keywords" ]
        , Html.button [ Html.Events.onClick AddKeyword ] [ Html.text "Add" ]
        ]
        <| List.indexedMap viewKeyword keywords


viewKeyword : Int -> String -> Html Message
viewKeyword index keyword =
  Html.div
    []
    [ Html.label [ Html.Attributes.for <| "keyword-" ++ String.fromInt index ] [ Html.text "Keyword" ]
    , Html.input
      [ Html.Attributes.id <| "keyword-" ++ String.fromInt index 
      , Html.Attributes.value keyword
      , Html.Events.onInput <| UpdateKeyword index
      ]
      []
    , Html.button [ Html.Events.onClick <| RemoveKeyword index ] [ Html.text "Keyword" ]
    ]


viewFiles : List String -> Html Message
viewFiles files =
  Html.div
    []
    <| List.append
        [ Html.label [] [ Html.text "Files" ]
        , Html.button [ Html.Events.onClick AddFile ] [ Html.text "Add" ]
        ]
        <| List.indexedMap viewFile files


viewFile : Int -> String -> Html Message
viewFile index file =
  Html.div
    []
    [ Html.label [ Html.Attributes.for <| "file-" ++ String.fromInt index ] [ Html.text "File name" ]
    , Html.input
      [ Html.Attributes.value file
      , Html.Attributes.id <| "file-" ++ String.fromInt index 
      , Html.Events.onInput <| UpdateFile index
      ]
      []
    , Html.button [ Html.Events.onClick <| RemoveFile index ] [ Html.text "Remove" ]
    ]


viewOperatingSystems : List String -> Html Message
viewOperatingSystems operatingSystems =
  Html.div
    []
    <| List.append
        [ Html.label [] [ Html.text "Operating systems" ]
        , Html.button [ Html.Events.onClick AddOperatingSystem ] [ Html.text "Add" ]
        ]
        <| List.indexedMap viewOperatingSystem operatingSystems


viewOperatingSystem : Int -> String -> Html Message
viewOperatingSystem index operatingSystem =
  Html.div
    []
    [ Html.label [ Html.Attributes.for <| "operating-system-" ++ String.fromInt index ] [ Html.text "OS name" ]
    , Html.input
      [ Html.Attributes.id <| "operating-system-" ++ String.fromInt index 
      , Html.Attributes.value operatingSystem
      , Html.Events.onInput <| UpdateOperatingSystem index
      ]
      []
    , Html.button [ Html.Events.onClick <| RemoveOperatingSystem index ] [ Html.text "Remove" ]
    ]


viewCpus : List String -> Html Message
viewCpus cpus =
  Html.div
    []
    <| List.append
        [ Html.label [] [ Html.text "CPUs" ]
        , Html.button [ Html.Events.onClick AddCpu ] [ Html.text "Add" ]
        ]
        <| List.indexedMap viewCpu cpus


viewCpu : Int -> String -> Html Message
viewCpu index cpu =
  Html.div
    []
    [ Html.label [ Html.Attributes.for <| "cpu-" ++ String.fromInt index ] [ Html.text "CPU name" ]
    , Html.input
      [ Html.Attributes.id <| "cpu-" ++ String.fromInt index
      , Html.Attributes.value cpu
      , Html.Events.onInput <| UpdateCpu index
      ]
      []
    , Html.button [ Html.Events.onClick <| RemoveCpu index ] [ Html.text "Remove" ]
    ]



viewBrowser : String -> Html Message
viewBrowser browser =
  Html.div
    []
    [ Html.label [ Html.Attributes.for "browser" ] [ Html.text "Browser" ]
    , Html.input
      [ Html.Attributes.value browser
      , Html.Attributes.id "browser"
      , Html.Events.onInput UpdateBrowser
      ]
      []
    ]


viewMain : String -> Html Message
viewMain entrypoint =
  Html.div
    []
    [ Html.label [ Html.Attributes.for "main" ] [ Html.text "Main" ]
    , Html.input
      [ Html.Attributes.value entrypoint
      , Html.Attributes.id "main"
      , Html.Events.onInput UpdateMain
      ]
      []
    ]


viewLicense : String -> Html Message
viewLicense license =
  Html.div
    []
    [ Html.label [ Html.Attributes.for "license" ] [ Html.text "License" ]
    , Html.input
      [ Html.Attributes.value license
      , Html.Attributes.id "license"
      , Html.Events.onInput UpdateLicense
      ]
      []
    ]


viewHomepage : String -> Html Message
viewHomepage homepage =
  Html.div
    []
    [ Html.label [ Html.Attributes.for "homepage" ] [ Html.text "Home page" ]
    , Html.input
      [ Html.Attributes.value homepage
      , Html.Attributes.id "homepage"
      , Html.Events.onInput UpdateHomepage
      ]
      []
    ]


viewVersion : String -> Html Message
viewVersion version =
  Html.div
    []
    [ Html.label [ Html.Attributes.for "version" ] [ Html.text "Version" ]
    , Html.input
      [ Html.Attributes.value version
      , Html.Attributes.id "version"
      , Html.Events.onInput UpdateVersion
      ]
      []
    ]


viewDescription : String -> Html Message
viewDescription description =
  Html.div
    []
    [ Html.label [ Html.Attributes.for "description" ] [ Html.text "Description" ]
    , Html.input
      [ Html.Attributes.value description
      , Html.Attributes.id "description"
      , Html.Events.onInput UpdateDescription
      ]
      []
    ]


viewName : String -> Html Message
viewName name =
  Html.div
    []
    [ Html.label [ Html.Attributes.for "name" ] [ Html.text "Name" ]
    , Html.input
      [ Html.Attributes.value name
      , Html.Attributes.id "name"
      , Html.Events.onInput UpdateName
      ]
      []
    ]


viewPrivate : Bool -> Html Message
viewPrivate private =
  Html.div
    []
    [ Html.input
      [ Html.Attributes.checked private
      , Html.Events.onCheck UpdatePrivate
      , Html.Attributes.type_ "checkbox"
      , Html.Attributes.id "private"
      ]
      []
    , Html.label [ Html.Attributes.for "private" ] [ Html.text "Private" ]
    ]


viewEngines : Engines -> Html Message
viewEngines engines =
  Html.div
    []
    [ viewEnginesNode engines.node
    , viewEnginesNpm engines.npm
    ]


viewEnginesNode : String -> Html Message
viewEnginesNode node =
  Html.div
    []
    [ Html.label [ Html.Attributes.for "engines-node" ] [ Html.text "Node version" ]
    , Html.input
      [ Html.Attributes.value node
      , Html.Events.onInput UpdateEnginesNode
      , Html.Attributes.id "engines-node"
      ]
      []
    ]


viewEnginesNpm : String -> Html Message
viewEnginesNpm npm =
  Html.div
    []
    [ Html.label [ Html.Attributes.for "engines-npm" ] [ Html.text "NPM version" ]
    , Html.input
      [ Html.Attributes.value npm
      , Html.Events.onInput UpdateEnginesNpm
      , Html.Attributes.id "engines-npm"
      ]
      []
    ]


viewRepository : Repository -> Html Message
viewRepository repository =
  Html.div
    []
    [ viewRepositoryKind repository.kind
    , viewRepositoryUrl repository.url
    ]


viewRepositoryKind : String -> Html Message
viewRepositoryKind kind =
  Html.div
    []
    [ Html.label [ Html.Attributes.for "repository-type" ] [ Html.text "Repository type" ]
    , Html.input
      [ Html.Attributes.value kind
      , Html.Events.onInput UpdateRepositoryKind
      , Html.Attributes.id "repository-type"
      ]
      []
    ]


viewRepositoryUrl : String -> Html Message
viewRepositoryUrl url =
  Html.div
    []
    [ Html.label [ Html.Attributes.for "repository-url" ] [ Html.text "Repository URL" ]
    , Html.input
      [ Html.Attributes.value url
      , Html.Events.onInput UpdateRepositoryUrl
      , Html.Attributes.id "repository-url"
      ]
      []
    ]


viewAuthor : Author -> Html Message
viewAuthor author =
  Html.div
    []
    [ viewAuthorName author.name
    , viewAuthorUrl author.url
    , viewAuthorEmail author.email
    ]


viewAuthorName : String -> Html Message
viewAuthorName name =
  Html.div
    []
    [ Html.label [ Html.Attributes.for "author-name" ] [ Html.text "Author name" ] 
    , Html.input
      [ Html.Attributes.value name
      , Html.Events.onInput UpdateAuthorName
      , Html.Attributes.id "author-name"
      ]
      [] 
    ]


viewAuthorUrl : String -> Html Message
viewAuthorUrl url =
  Html.div
    []
    [ Html.label [ Html.Attributes.for "author-url" ] [ Html.text "Author URL" ] 
    , Html.input
      [ Html.Attributes.value url
      , Html.Events.onInput UpdateAuthorUrl
      , Html.Attributes.id "author-url"
      ]
      [] 
    ]


viewAuthorEmail : String -> Html Message
viewAuthorEmail email =
  Html.div
    []
    [ Html.label [ Html.Attributes.for "author-email" ] [ Html.text "Author Email" ] 
    , Html.input
      [ Html.Attributes.value email
      , Html.Events.onInput UpdateAuthorEmail
      , Html.Attributes.id "author-email"
      ]
      [] 
    ]


viewBugs : Bugs -> Html Message
viewBugs bugs =
  Html.div
    []
    [ viewBugsUrl bugs.url
    , viewBugsEmail bugs.email
    ]


viewBugsUrl : String -> Html Message
viewBugsUrl url =
  Html.div
    []
    [ Html.label [ Html.Attributes.for "bugs-url" ] [ Html.text "Bugs URL" ]
    , Html.input
      [ Html.Attributes.value url
      , Html.Events.onInput UpdateBugsUrl
      , Html.Attributes.for "bugs-url"
      ]
      []
    ]


viewBugsEmail : String -> Html Message
viewBugsEmail email =
  Html.div
    []
    [ Html.label [ Html.Attributes.for "bugs-email" ] [ Html.text "Bugs email" ]
    , Html.input
      [ Html.Attributes.value email
      , Html.Events.onInput UpdateBugsEmail
      , Html.Attributes.id "bugs-email"
      ]
      []
    ]


viewOptionalDependencies : List OptionalDependency -> Html Message
viewOptionalDependencies optionalDependencies =
  Html.div
    []
    <| List.append
        [ Html.label [] [ Html.text "Optional dependencies" ]
        , Html.button [ Html.Events.onClick AddOptionalDependency ] [ Html.text "Add" ]
        ]
        <| List.indexedMap viewOptionalDependency optionalDependencies


viewOptionalDependency : Int -> OptionalDependency -> Html Message
viewOptionalDependency index optionalDependency =
  Html.div
    []
    [ Html.div
      []
      [ Html.label [ Html.Attributes.for <| "optional-dependency-key-" ++ String.fromInt index ] [ Html.text "Key" ]
      , Html.input
        [ Html.Attributes.value optionalDependency.key
        , Html.Events.onInput <| UpdateOptionalDependencyKey index
        , Html.Attributes.id <| "optional-dependency-key-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.div
      []
      [ Html.label [ Html.Attributes.for <| "optional-dependency-value-" ++ String.fromInt index ] [ Html.text "Value" ]
      , Html.input
        [ Html.Attributes.value optionalDependency.value
        , Html.Events.onInput <| UpdateOptionalDependencyValue index
        , Html.Attributes.id <| "optional-dependency-value-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.button [ Html.Events.onClick <| RemoveOptionalDependency index ] [ Html.text "Remove" ]
    ]


viewBundledDependencies : List BundledDependency -> Html Message
viewBundledDependencies bundledDependencies =
  Html.div
    []
    <| List.append
        [ Html.label [] [ Html.text "Bundled dependencies" ]
        , Html.button [ Html.Events.onClick AddBundledDependency ] [ Html.text "Add" ]
        ]
        <| List.indexedMap viewBundledDependency bundledDependencies


viewBundledDependency : Int -> BundledDependency -> Html Message
viewBundledDependency index bundledDependency =
  Html.div
    []
    [ Html.div
      []
      [ Html.label [ Html.Attributes.for <| "bundled-dependency-key-" ++ String.fromInt index ] [ Html.text "Key" ]
      , Html.input
        [ Html.Attributes.value bundledDependency.key
        , Html.Events.onInput <| UpdateBundledDependencyKey index
        , Html.Attributes.id <| "bundled-dependency-key-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.div
      []
      [ Html.label [ Html.Attributes.for <| "bundled-dependency-value-" ++ String.fromInt index ] [ Html.text "Value" ]
      , Html.input
        [ Html.Attributes.value bundledDependency.value
        , Html.Events.onInput <| UpdateBundledDependencyValue index
        , Html.Attributes.id <| "bundled-dependency-value-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.button [ Html.Events.onClick <| RemoveBundledDependency index ] [ Html.text "Remove" ]
    ]


viewPeerDependencies : List PeerDependency -> Html Message
viewPeerDependencies peerDependencies =
  Html.div
    []
    <| List.append
        [ Html.label [] [ Html.text "Peer dependencies" ]
        , Html.button [ Html.Events.onClick AddPeerDependency ] [ Html.text "Add" ]
        ]
        <| List.indexedMap viewPeerDependency peerDependencies


viewPeerDependency : Int -> PeerDependency -> Html Message
viewPeerDependency index peerDependency =
  Html.div
    []
    [ Html.div
      []
      [ Html.label [ Html.Attributes.for <| "peer-dependency-key-" ++ String.fromInt index ] [ Html.text "Key" ]
      , Html.input
        [ Html.Attributes.value peerDependency.key
        , Html.Events.onInput <| UpdatePeerDependencyKey index
        , Html.Attributes.id <| "peer-dependency-key-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.div
      []
      [ Html.label [ Html.Attributes.for <| "peer-dependency-value-" ++ String.fromInt index ] [ Html.text "Value" ]
      , Html.input
        [ Html.Attributes.value peerDependency.value
        , Html.Events.onInput <| UpdatePeerDependencyValue index
        , Html.Attributes.id <| "peer-dependency-value-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.button [ Html.Events.onClick <| RemovePeerDependency index ] [ Html.text "Remove" ]
    ]


viewDevelopmentDependencies : List DevelopmentDependency -> Html Message
viewDevelopmentDependencies developmentDependencies =
  Html.div
    []
    <| List.append
        [ Html.label [] [ Html.text "Development dependencies" ]
        , Html.button [ Html.Events.onClick AddDevelopmentDependency ] [ Html.text "Add" ]
        ]
        <| List.indexedMap viewDevelopmentDependency developmentDependencies


viewDevelopmentDependency : Int -> DevelopmentDependency -> Html Message
viewDevelopmentDependency index developmentDependency =
  Html.div
    []
    [ Html.div
      []
      [ Html.label [ Html.Attributes.for <| "development-dependency-key-" ++ String.fromInt index ] [ Html.text "Key" ]
      , Html.input
        [ Html.Events.onInput <| UpdateDevelopmentDependencyKey index 
        , Html.Attributes.value developmentDependency.key
        , Html.Attributes.id <| "development-dependency-key-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.div
      []
      [ Html.label [ Html.Attributes.for <| "development-dependency-value-" ++ String.fromInt index ] [ Html.text "Value" ]
      , Html.input
        [ Html.Events.onInput <| UpdateDevelopmentDependencyValue index
        , Html.Attributes.value developmentDependency.value
        , Html.Attributes.id <| "development-dependency-value-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.button [ Html.Events.onClick <| RemoveDevelopmentDependency index ] [ Html.text "Remove" ]
    ]


viewDependencies : List Dependency -> Html Message
viewDependencies dependencies =
  Html.div
    []
    <| List.append
        [ Html.label [] [ Html.text "Dependencies" ]
        , Html.button [ Html.Events.onClick AddDependency ] [ Html.text "Add" ]
        ]
        <| List.indexedMap viewDependency dependencies


viewDependency : Int -> Dependency -> Html Message
viewDependency index dependency =
  Html.div
    []
    [ Html.div
      []
      [ Html.label [ Html.Attributes.for <| "dependency-key-" ++ String.fromInt index ] [ Html.text "Key" ]
      , Html.input
        [ Html.Events.onInput <| UpdateDependencyKey index
        , Html.Attributes.value dependency.key
        , Html.Attributes.id <| "dependency-key-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.div
      []
      [ Html.label [ Html.Attributes.for <| "dependency-value-" ++ String.fromInt index ] [ Html.text "Value" ]
      , Html.input
        [ Html.Events.onInput <| UpdateDependencyValue index
        , Html.Attributes.value dependency.value
        , Html.Attributes.id <| "dependency-value-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.button [ Html.Events.onClick <| RemoveDependency index ] [ Html.text "Remove" ]
    ]


viewConfigurations : List Configuration -> Html Message
viewConfigurations configurations =
  Html.div
    []
    <| List.append
        [ Html.label [] [ Html.text "Configurations" ]
        , Html.button [ Html.Events.onClick AddConfiguration ] [ Html.text "Add" ]
        ]
        <| List.indexedMap viewConfiguration configurations


viewConfiguration : Int -> Configuration -> Html Message
viewConfiguration index configuration =
  Html.div
    []
    [ Html.div
      []
      [ Html.label [ Html.Attributes.for <| "configuration-key-" ++ String.fromInt index ] [ Html.text "Key" ]
      , Html.input
        [ Html.Events.onInput <| UpdateConfigurationKey index
        , Html.Attributes.value configuration.key
        , Html.Attributes.id <| "configuration-key-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.div
      []
      [ Html.label [ Html.Attributes.for <| "configuration-value-" ++ String.fromInt index ] [ Html.text "Value" ]
      , Html.input
        [ Html.Events.onInput <| UpdateConfigurationValue index
        , Html.Attributes.value configuration.value
        , Html.Attributes.id <| "configuration-value-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.button [ Html.Events.onClick <| RemoveConfiguration index ] [ Html.text "Remove" ]
    ]


viewScripts : List Script -> Html Message
viewScripts scripts =
  Html.div
    []
    <| List.append
        [ Html.label [] [ Html.text "Scripts" ]
        , Html.button [ Html.Events.onClick AddScript ] [ Html.text "Add" ]
        ]
        <| List.indexedMap viewScript scripts


viewScript : Int -> Script -> Html Message
viewScript index script =
  Html.div
    []
    [ Html.div
      []
      [ Html.label [ Html.Attributes.for <| "script-key-" ++ String.fromInt index ] [ Html.text "Key" ]
      , Html.input
        [ Html.Events.onInput <| UpdateScriptKey index
        , Html.Attributes.value script.key
        , Html.Attributes.id <| "script-key-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.div
      []
      [ Html.label [ Html.Attributes.for <| "script-command-" ++ String.fromInt index ] [ Html.text "Command" ]
      , Html.input
        [ Html.Events.onInput <| UpdateScriptCommand index
        , Html.Attributes.value script.command
        , Html.Attributes.id <| "script-command-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.button [ Html.Events.onClick <| RemoveScript index ] [ Html.text "Remove" ]
    ]


viewFundings : List Funding -> Html Message
viewFundings fundings =
  Html.div
    []
    <| List.append
        [ Html.label [] [ Html.text "Fundings" ]
        , Html.button [ Html.Events.onClick AddFunding ] [ Html.text "Add" ]
        ]
        <| List.indexedMap viewFunding fundings


viewFunding : Int -> Funding -> Html Message
viewFunding index funding =
  Html.div
    []
    [ Html.div
      []
      [ Html.label [ Html.Attributes.for <| "funding-type-" ++ String.fromInt index ] [ Html.text "Type" ]
      , Html.input
        [ Html.Events.onInput <| UpdateFundingKind index
        , Html.Attributes.value funding.kind
        , Html.Attributes.id <| "funding-type-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.div
      []
      [ Html.label [ Html.Attributes.for <| "funding-url-" ++ String.fromInt index ] [ Html.text "Url" ]
      , Html.input
        [ Html.Events.onInput <| UpdateFundingUrl index
        , Html.Attributes.value funding.url
        , Html.Attributes.id <| "funding-url-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.button [ Html.Events.onClick <| RemoveFunding index ] [ Html.text "Remove" ]
    ]


viewContributors : List Contributor -> Html Message
viewContributors contributors =
  Html.div []
    <| List.append
        [ Html.label [] [ Html.text "Contributors" ]
        , Html.button [ Html.Events.onClick AddContributor ] [ Html.text "Add" ]
        ]
        <| List.indexedMap viewContributor contributors


viewContributor : Int -> Contributor -> Html Message
viewContributor index contributor =
  Html.div
    []
    [ Html.div
      []
      [ Html.label [ Html.Attributes.for <| "contributor-name-" ++ String.fromInt index ] [ Html.text "Name" ]
      , Html.input
        [ Html.Events.onInput <| UpdateContributorName index
        , Html.Attributes.value contributor.name
        , Html.Attributes.id <| "contributor-name-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.div
      []
      [ Html.label [ Html.Attributes.for <| "contributor-email-" ++ String.fromInt index ] [ Html.text "Email" ]
      , Html.input
        [ Html.Events.onInput <| UpdateContributorEmail index
        , Html.Attributes.value contributor.email
        , Html.Attributes.id <| "contributor-email-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.div
      []
      [ Html.label [ Html.Attributes.for <| "contributor-url-" ++ String.fromInt index ] [ Html.text "URL" ]
      , Html.input
        [ Html.Events.onInput <| UpdateContributorUrl index
        , Html.Attributes.value contributor.url
        , Html.Attributes.id <| "contributor-url-" ++ String.fromInt index 
        ]
        []
      ]
    , Html.button [ Html.Events.onClick <| RemoveContributor index ] [ Html.text "Remove" ]
    ]


viewModel : Model -> Html Message
viewModel model =
  Html.pre [] [ Html.code [] [ Html.text <| encodeModel model ] ]


-- VIEW HELPERS


encodeModel : Model -> String
encodeModel model =
  Json.Encode.encode 2
    <| Json.Encode.object 
        [ encodeName model.name
        , encodeDescription model.description
        , encodeVersion model.version
        , encodeHomepage model.homepage
        , encodeLicense model.license
        , encodeMain model.main
        , encodeBrowser model.browser
        , encodePrivate model.private
        , encodeBugs model.bugs
        , encodeAuthor model.author
        , encodeRepository model.repository
        , encodeEngines model.engines
        , encodeCpus model.cpus
        , encodeOperatingSystems model.operatingSystems
        , encodeFiles model.files
        , encodeKeywords model.keywords
        , encodeContributors model.contributors
        , encodeFundings model.fundings
        , encodeScripts model.scripts
        , encodeConfigurations model.configurations
        , encodeDependencies model.dependencies
        , encodeDevelopmentDependencies model.developmentDependencies
        , encodePeerDependencies model.peerDependencies
        , encodeBundledDependencies model.bundledDependencies
        , encodeOptionalDependencies model.optionalDependencies
        ]


encodeFiles : List String -> ( String, Json.Encode.Value )
encodeFiles files =
  ( "files", Json.Encode.list Json.Encode.string files )


encodeKeywords : List String -> ( String, Json.Encode.Value )
encodeKeywords keywords =
  ( "keywords", Json.Encode.list Json.Encode.string keywords )


encodeOperatingSystems : List String -> ( String, Json.Encode.Value )
encodeOperatingSystems operatingSystems =
  ( "os", Json.Encode.list Json.Encode.string operatingSystems )


encodeCpus : List String -> ( String, Json.Encode.Value )
encodeCpus cpus =
  ( "cpu", Json.Encode.list Json.Encode.string cpus )


encodeEngines : Engines -> ( String, Json.Encode.Value )
encodeEngines engines =
  ( "engines"
  , Json.Encode.object
    [ ( "node", Json.Encode.string engines.node )
    , ( "npm", Json.Encode.string engines.npm )
    ]
  )


encodeRepository : Repository -> ( String, Json.Encode.Value )
encodeRepository repository =
  ( "repository"
  , Json.Encode.object
    [ ( "type", Json.Encode.string repository.kind )
    , ( "url", Json.Encode.string repository.url )
    ]
  )


encodeAuthor : Author -> ( String, Json.Encode.Value )
encodeAuthor author =
  ( "author"
  , Json.Encode.object
    [ ( "name", Json.Encode.string author.name )
    , ( "url", Json.Encode.string author.url )
    , ( "email", Json.Encode.string author.email )
    ]
  )


encodeBugs : Bugs -> ( String, Json.Encode.Value )
encodeBugs bugs =
  ( "bugs"
  , Json.Encode.object
    [ ( "url", Json.Encode.string bugs.url )
    , ( "email", Json.Encode.string bugs.email )
    ]
  )


encodeOptionalDependencies : List OptionalDependency -> ( String, Json.Encode.Value )
encodeOptionalDependencies optionalDependencies =
  ( "optionalDependencies", Json.Encode.object <| List.map encodeOptionalDependency optionalDependencies )


encodeOptionalDependency : OptionalDependency -> ( String, Json.Encode.Value )
encodeOptionalDependency optionalDependency =
  ( optionalDependency.key, Json.Encode.string optionalDependency.value )


encodeBundledDependencies : List BundledDependency -> ( String, Json.Encode.Value )
encodeBundledDependencies bundledDependencies =
  ( "bundledDependencies", Json.Encode.object <| List.map encodeBundledDependency bundledDependencies )


encodeBundledDependency : BundledDependency -> ( String, Json.Encode.Value )
encodeBundledDependency bundledDependency =
  ( bundledDependency.key, Json.Encode.string bundledDependency.value )


encodePeerDependencies : List PeerDependency -> ( String, Json.Encode.Value )
encodePeerDependencies peerDependencies =
  ( "peerDependencies", Json.Encode.object <| List.map encodePeerDependency peerDependencies )


encodePeerDependency : PeerDependency -> ( String, Json.Encode.Value )
encodePeerDependency peerDependency =
  ( peerDependency.key, Json.Encode.string peerDependency.value )


encodeDependencies : List Dependency -> ( String, Json.Encode.Value )
encodeDependencies dependencies =
  ( "dependencies", Json.Encode.object <| List.map encodeDependency dependencies )


encodeDependency : Dependency -> ( String, Json.Encode.Value )
encodeDependency dependency =
  ( dependency.key, Json.Encode.string dependency.value )


encodeDevelopmentDependencies : List DevelopmentDependency -> ( String, Json.Encode.Value )
encodeDevelopmentDependencies developmentDependencies =
  ( "devDependencies", Json.Encode.object <| List.map encodeDevelopmentDependency developmentDependencies )


encodeDevelopmentDependency : DevelopmentDependency -> ( String, Json.Encode.Value )
encodeDevelopmentDependency developmentDependency =
  ( developmentDependency.key, Json.Encode.string developmentDependency.value )


encodePrivate : Bool -> ( String, Json.Encode.Value )
encodePrivate private =
  ( "private", Json.Encode.bool private )


encodeBrowser : String -> ( String, Json.Encode.Value )
encodeBrowser browser =
  ( "browser", Json.Encode.string browser )


encodeMain : String -> ( String, Json.Encode.Value )
encodeMain mainFile =
  ( "main", Json.Encode.string mainFile )


encodeLicense : String -> ( String, Json.Encode.Value )
encodeLicense license =
  ( "license", Json.Encode.string license )


encodeHomepage : String -> ( String, Json.Encode.Value )
encodeHomepage homepage =
  ( "homepage", Json.Encode.string homepage )


encodeVersion : String -> ( String, Json.Encode.Value )
encodeVersion version =
  ( "version", Json.Encode.string version )


encodeDescription : String -> ( String, Json.Encode.Value )
encodeDescription description =
  ( "description", Json.Encode.string description )


encodeName : String -> ( String, Json.Encode.Value )
encodeName name =
  ( "name", Json.Encode.string name )


encodeConfigurations : List Configuration -> ( String, Json.Encode.Value )
encodeConfigurations configurations =
  ( "config", Json.Encode.object <| List.map encodeConfiguration configurations )


encodeConfiguration : Configuration -> ( String, Json.Encode.Value )
encodeConfiguration configuration =
  ( configuration.key, Json.Encode.string configuration.value )


encodeScripts : List Script -> ( String, Json.Encode.Value )
encodeScripts scripts =
  ( "scripts", Json.Encode.object <| List.map encodeScript scripts )


encodeScript : Script -> ( String, Json.Encode.Value )
encodeScript script =
  ( script.key, Json.Encode.string script.command )


encodeFundings : List Funding -> ( String, Json.Encode.Value )
encodeFundings fundings =
  ( "fundings", Json.Encode.list encodeFunding fundings )


encodeFunding : Funding -> Json.Encode.Value
encodeFunding funding =
  Json.Encode.object
    [ ( "type", Json.Encode.string funding.kind )
    , ( "url", Json.Encode.string funding.url )
    ]


encodeContributors : List Contributor -> ( String, Json.Encode.Value )
encodeContributors contributors =
  ( "contributors", Json.Encode.list encodeContributor contributors )


encodeContributor : Contributor -> Json.Encode.Value
encodeContributor contributor =
  Json.Encode.object
    [ ( "name", Json.Encode.string contributor.name )
    , ( "email", Json.Encode.string contributor.email )
    , ( "url", Json.Encode.string contributor.url )
    ]


-- UPDATE


update : Message -> Model -> Model
update message model =
  case message of
    UpdateName name ->
      { model | name = name }

    UpdateDescription description ->
      { model | description = description }

    UpdateVersion version ->
      { model | version = version }

    UpdateHomepage homepage ->
      { model | homepage = homepage }

    UpdateLicense license ->
      { model | license = license }

    UpdateMain newMain ->
      { model | main = newMain }

    UpdateBrowser browser ->
      { model | browser = browser }

    UpdatePrivate private ->
      { model | private = private }

    UpdateBugsUrl url ->
      { model | bugs = updateBugsUrl url model.bugs }

    UpdateBugsEmail email ->
      { model | bugs = updateBugsEmail email model.bugs }

    UpdateAuthorName name ->
      { model | author = updateAuthorName name model.author }

    UpdateAuthorEmail email ->
      { model | author = updateAuthorEmail email model.author }

    UpdateAuthorUrl url ->
      { model | author = updateAuthorUrl url model.author }

    UpdateRepositoryKind kind ->
      { model | repository = updateRepositoryKind kind model.repository }

    UpdateRepositoryUrl url ->
      { model | repository = updateRepositoryUrl url model.repository }

    UpdateEnginesNode node ->
      { model | engines = updateEnginesNode node model.engines }

    UpdateEnginesNpm npm ->
      { model | engines = updateEnginesNpm npm model.engines }

    AddCpu ->
      { model | cpus = List.append model.cpus [ "" ] }

    UpdateCpu index value ->
      { model | cpus = List.Extra.updateAt index ( always value ) model.cpus }

    RemoveCpu index ->
      { model | cpus = List.Extra.removeAt index model.cpus }

    AddOperatingSystem ->
      { model | operatingSystems = List.append model.operatingSystems [ "" ] }

    UpdateOperatingSystem index operatingSystem ->
      { model | operatingSystems = List.Extra.updateAt index ( always operatingSystem ) model.operatingSystems }

    RemoveOperatingSystem index ->
      { model | operatingSystems = List.Extra.removeAt index model.operatingSystems }

    AddFile ->
      { model | files = List.append model.files [ "" ] }

    UpdateFile index value ->
      { model | files = List.Extra.updateAt index ( always value ) model.files }

    RemoveFile index ->
      { model | files = List.Extra.removeAt index model.files }

    AddKeyword ->
      { model | keywords = List.append model.keywords [ "" ] }

    UpdateKeyword index value ->
      { model | keywords = List.Extra.updateAt index ( always value ) model.keywords }

    RemoveKeyword index ->
      { model | keywords = List.Extra.removeAt index model.keywords }

    AddContributor ->
      { model | contributors = List.append model.contributors [ { name = "", email = "", url = "" } ] }

    RemoveContributor index ->
      { model | contributors = List.Extra.removeAt index model.contributors }

    UpdateContributorName index name ->
      { model | contributors = List.Extra.updateAt index ( updateContributorName name ) model.contributors }

    UpdateContributorEmail index email ->
      { model | contributors = List.Extra.updateAt index ( updateContributorEmail email ) model.contributors }

    UpdateContributorUrl index url ->
      { model | contributors = List.Extra.updateAt index ( updateContributorUrl url ) model.contributors }

    AddFunding ->
      { model | fundings = List.append model.fundings [ { kind = "", url = "" } ] }

    UpdateFundingKind index kind ->
      { model | fundings = List.Extra.updateAt index ( updateFundingKind kind ) model.fundings }

    UpdateFundingUrl index url ->
      { model | fundings = List.Extra.updateAt index ( updateFundingUrl url ) model.fundings }

    RemoveFunding index ->
      { model | fundings = List.Extra.removeAt index model.fundings }

    AddScript ->
      { model | scripts = List.append model.scripts [ { key = "", command = "" } ] }

    RemoveScript index ->
      { model | scripts = List.Extra.removeAt index model.scripts }

    UpdateScriptKey index key ->
      { model | scripts = List.Extra.updateAt index ( updateScriptKey key ) model.scripts }

    UpdateScriptCommand index command ->
      { model | scripts = List.Extra.updateAt index ( updateScriptCommand command ) model.scripts }

    AddConfiguration ->
      { model | configurations = List.append model.configurations [ { key = "", value = "" } ] }

    RemoveConfiguration index ->
      { model | configurations = List.Extra.removeAt index model.configurations }

    UpdateConfigurationKey index key ->
      { model | configurations = List.Extra.updateAt index ( updateConfigurationKey key ) model.configurations }

    UpdateConfigurationValue index value ->
      { model | configurations = List.Extra.updateAt index ( updateConfigurationValue value ) model.configurations }

    AddDependency ->
      { model | dependencies = List.append model.dependencies [ { key = "", value = "" } ] }

    RemoveDependency index ->
      { model | dependencies = List.Extra.removeAt index model.dependencies }

    UpdateDependencyKey index key ->
      { model | dependencies = List.Extra.updateAt index ( updateDependencyKey key ) model.dependencies }
    
    UpdateDependencyValue index value ->
      { model | dependencies = List.Extra.updateAt index ( updateDependencyValue value ) model.dependencies }

    AddDevelopmentDependency ->
      { model | developmentDependencies = List.append model.developmentDependencies [ { key = "", value = "" } ] }

    UpdateDevelopmentDependencyValue index value ->
      { model | developmentDependencies = List.Extra.updateAt index ( updateDevelopmentDependencyValue value ) model.developmentDependencies }

    UpdateDevelopmentDependencyKey index key ->
      { model | developmentDependencies = List.Extra.updateAt index ( updateDevelopmentDependencyKey key ) model.developmentDependencies }

    RemoveDevelopmentDependency index ->
      { model | developmentDependencies = List.Extra.removeAt index model.developmentDependencies }

    AddPeerDependency ->
      { model | peerDependencies = List.append model.peerDependencies [ { key = "", value = "" } ] }

    UpdatePeerDependencyKey index key ->
      { model | peerDependencies = List.Extra.updateAt index ( updatePeerDependencyKey key ) model.peerDependencies }

    UpdatePeerDependencyValue index value ->
      { model | peerDependencies = List.Extra.updateAt index ( updatePeerDependencyValue value ) model.peerDependencies }

    RemovePeerDependency index ->
      { model | peerDependencies = List.Extra.removeAt index model.peerDependencies }

    AddBundledDependency ->
      { model | bundledDependencies = List.append model.bundledDependencies [ { key = "", value = "" } ] }

    RemoveBundledDependency index ->
      { model | bundledDependencies = List.Extra.removeAt index model.bundledDependencies }

    UpdateBundledDependencyKey index key ->
      { model | bundledDependencies = List.Extra.updateAt index ( updateBundledDependencyKey key ) model.bundledDependencies }

    UpdateBundledDependencyValue index value ->
      { model | bundledDependencies = List.Extra.updateAt index ( updateBundledDependencyValue value ) model.bundledDependencies }

    AddOptionalDependency ->
      { model | optionalDependencies = List.append model.optionalDependencies [ { key = "", value = "" } ] }

    UpdateOptionalDependencyKey index key ->
      { model | optionalDependencies = List.Extra.updateAt index ( updateOptionalDependencyKey key ) model.optionalDependencies }

    UpdateOptionalDependencyValue index value ->
      { model | optionalDependencies = List.Extra.updateAt index ( updateOptionalDependencyValue value ) model.optionalDependencies }
  
    RemoveOptionalDependency index ->
      { model | optionalDependencies = List.Extra.removeAt index model.optionalDependencies }


updateEnginesNode : String -> Engines -> Engines
updateEnginesNode node engines =
  { engines | node = node }


updateEnginesNpm : String -> Engines -> Engines
updateEnginesNpm npm engines =
  { engines | npm = npm }


updateRepositoryKind : String -> Repository -> Repository
updateRepositoryKind kind repository =
  { repository | kind = kind }


updateRepositoryUrl : String -> Repository -> Repository
updateRepositoryUrl url repository =
  { repository | url = url }


updateAuthorName : String -> Author -> Author
updateAuthorName name author =
  { author | name = name }


updateAuthorUrl : String -> Author -> Author
updateAuthorUrl url author =
  { author | url = url }


updateAuthorEmail : String -> Author -> Author
updateAuthorEmail email author =
  { author | email = email }


updateBugsEmail : String -> Bugs -> Bugs
updateBugsEmail email bugs =
  { bugs | email = email }


updateBugsUrl : String -> Bugs -> Bugs
updateBugsUrl url bugs =
  { bugs | url = url }


updateOptionalDependencyValue : String -> OptionalDependency -> OptionalDependency
updateOptionalDependencyValue value optionalDependency =
  { optionalDependency | value = value }


updateOptionalDependencyKey : String -> OptionalDependency -> OptionalDependency
updateOptionalDependencyKey key optionalDependency =
  { optionalDependency | key = key }


updateBundledDependencyValue : String -> BundledDependency -> BundledDependency
updateBundledDependencyValue value bundledDependency =
  { bundledDependency | value = value }


updateBundledDependencyKey : String -> BundledDependency -> BundledDependency
updateBundledDependencyKey key bundledDependency =
  { bundledDependency | key = key }


updatePeerDependencyKey : String -> PeerDependency -> PeerDependency
updatePeerDependencyKey key peerDependency =
  { peerDependency | key = key }


updatePeerDependencyValue : String -> PeerDependency -> PeerDependency
updatePeerDependencyValue value peerDependency =
  { peerDependency | value = value }


updateDevelopmentDependencyKey : String -> DevelopmentDependency -> DevelopmentDependency
updateDevelopmentDependencyKey key developmentDependency =
  { developmentDependency | key = key }


updateDevelopmentDependencyValue : String -> DevelopmentDependency -> DevelopmentDependency
updateDevelopmentDependencyValue value developmentDependency =
  { developmentDependency | value = value }


updateDependencyValue : String -> Dependency -> Dependency
updateDependencyValue value dependency =
  { dependency | value = value }


updateDependencyKey : String -> Dependency -> Dependency
updateDependencyKey key dependency =
  { dependency | key = key }


updateConfigurationValue : String -> Configuration -> Configuration
updateConfigurationValue value configuration =
  { configuration | value = value }


updateConfigurationKey : String -> Configuration -> Configuration
updateConfigurationKey key configuration =
  { configuration | key = key }


updateScriptCommand : String -> Script -> Script
updateScriptCommand command script =
  { script | command = command }


updateScriptKey : String -> Script -> Script
updateScriptKey key script =
  { script | key = key }


updateFundingUrl : String -> Funding -> Funding
updateFundingUrl url funding =
  { funding | url = url }


updateFundingKind : String -> Funding -> Funding
updateFundingKind kind funding =
  { funding | kind = kind }


updateContributorUrl : String -> Contributor -> Contributor
updateContributorUrl url contributor =
  { contributor | url = url }


updateContributorEmail : String -> Contributor -> Contributor
updateContributorEmail email contributor =
  { contributor | email = email }


updateContributorName : String -> Contributor -> Contributor
updateContributorName name contributor =
  { contributor | name = name }


-- INIT


init : Model
init =
  { name = ""
  , description = ""
  , version = ""
  , homepage = ""
  , license = ""
  , main = ""
  , browser = ""
  , private = False
  , bugs =
    { url = ""
    , email = ""
    }
  , author =
    { name = ""
    , url = ""
    , email = ""
    }
  , repository =
    { kind = ""
    , url = ""
    }
  , engines =
    { node = ""
    , npm = ""
    }
  , cpus = []
  , operatingSystems = []
  , files = []
  , keywords = []
  , contributors = []
  , fundings = []
  , scripts = []
  , configurations = []
  , dependencies = []
  , developmentDependencies = []
  , peerDependencies = []
  , bundledDependencies = []
  , optionalDependencies = []
  }


-- TYPES ( MODEL )


type alias Model =
  { name : String
  , description : String
  , version : String
  , homepage : String
  , license : String
  , main : String
  , browser : String
  , private : Bool
  , bugs : Bugs
  , author : Author
  , repository : Repository
  , engines : Engines
  , cpus : List String
  , operatingSystems : List String
  , files : List String
  , keywords : List String
  , contributors : List Contributor
  , fundings : List Funding
  , scripts : List Script
  , configurations : List Configuration
  , dependencies : List Dependency
  , developmentDependencies : List DevelopmentDependency
  , peerDependencies : List PeerDependency
  , bundledDependencies : List BundledDependency
  , optionalDependencies : List OptionalDependency
  }


type alias Engines =
  { node : String
  , npm : String
  }


type alias Repository =
  { kind : String
  , url : String
  }


type alias Author =
  { name : String
  , url : String
  , email : String
  }


type alias Bugs =
  { url : String
  , email : String
  }


type alias OptionalDependency =
  { key : String
  , value : String
  }


type alias BundledDependency =
  { key : String
  , value : String
  }


type alias PeerDependency =
  { key : String
  , value : String
  }


type alias DevelopmentDependency =
  { key : String
  , value : String
  }


type alias Dependency =
  { key : String
  , value : String
  }


type alias Configuration =
  { key : String
  , value : String
  }


type alias Script =
  { key : String
  , command : String
  }


type alias Funding =
  { kind : String
  , url : String
  }


type alias Contributor =
  { name : String
  , email : String
  , url : String
  }


-- TYPES ( MESSAGE )


type Message
  = UpdateName String
  | UpdateDescription String
  | UpdateVersion String
  | UpdateHomepage String
  | UpdateLicense String
  | UpdateMain String
  | UpdateBrowser String
  | UpdatePrivate Bool
  | UpdateBugsUrl String
  | UpdateBugsEmail String
  | UpdateAuthorName String
  | UpdateAuthorEmail String
  | UpdateAuthorUrl String
  | UpdateRepositoryKind String
  | UpdateRepositoryUrl String
  | UpdateEnginesNode String
  | UpdateEnginesNpm String
  | AddCpu
  | RemoveCpu Int
  | UpdateCpu Int String
  | AddOperatingSystem
  | UpdateOperatingSystem Int String
  | RemoveOperatingSystem Int
  | AddFile
  | UpdateFile Int String
  | RemoveFile Int
  | AddKeyword
  | UpdateKeyword Int String
  | RemoveKeyword Int
  | AddContributor
  | RemoveContributor Int
  | UpdateContributorName Int String
  | UpdateContributorEmail Int String
  | UpdateContributorUrl Int String
  | AddFunding
  | UpdateFundingKind Int String
  | UpdateFundingUrl Int String
  | RemoveFunding Int
  | AddScript
  | UpdateScriptKey Int String
  | UpdateScriptCommand Int String
  | RemoveScript Int
  | AddConfiguration
  | UpdateConfigurationKey Int String
  | UpdateConfigurationValue Int String
  | RemoveConfiguration Int
  | AddDependency
  | RemoveDependency Int
  | UpdateDependencyKey Int String
  | UpdateDependencyValue Int String
  | AddDevelopmentDependency
  | UpdateDevelopmentDependencyKey Int String
  | UpdateDevelopmentDependencyValue Int String
  | RemoveDevelopmentDependency Int
  | AddPeerDependency
  | UpdatePeerDependencyKey Int String
  | UpdatePeerDependencyValue Int String
  | RemovePeerDependency Int
  | AddBundledDependency
  | RemoveBundledDependency Int
  | UpdateBundledDependencyKey Int String
  | UpdateBundledDependencyValue Int String
  | AddOptionalDependency
  | RemoveOptionalDependency Int
  | UpdateOptionalDependencyKey Int String
  | UpdateOptionalDependencyValue Int String
