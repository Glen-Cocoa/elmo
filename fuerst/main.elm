import Browser
import String
import Char
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)

--Main

main =
    Browser.sandbox { init = init, update = update, view = view }

--Model

type alias Model = 
    { name : String
    , password : String
    , passwordAgain : String
    , age : String
    }

init : Model
init = 
    Model "" "" "" ""

--Update

type Msg
    = Name String
    | Password String
    | PasswordAgain String
    | Age String


update : Msg -> Model -> Model
update msg model = 
    case msg of
        Name name -> 
            { model | name = name }

        Password password -> 
            { model | password = password }

        PasswordAgain password ->
            { model | passwordAgain = password }

        Age age ->
            { model | age = age }


--View

view : Model -> Html Msg
view model = 
    div[]
        [ viewInput "text" "Name" model.name Name
        , viewInput "password" "Password" model.password Password
        , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
        , viewInput "Age" "enter age" model.age Age
        , viewValidation model
        ]

viewInput : String -> String -> String -> (String -> msg ) -> Html msg
viewInput t p v toMsg = 
    input [ type_ t, placeholder p, value v, onInput toMsg ] []

viewValidation : Model -> Html msg
viewValidation model =
    if model.password == model.passwordAgain
    && String.length model.password >= 8
    && String.any Char.isDigit model.password
    && String.any Char.isUpper model.password
    && String.any Char.isUpper model.password
    && String.all Char.isDigit model.age   
    then
        div [ style "color" "green" ][ text "OK"]
    else
        div [ style "color" "red" ][ text "NOT OK"]

