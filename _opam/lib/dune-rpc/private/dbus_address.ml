# 2 "otherlibs/dune-rpc/private/dbus_address.mll"
 
(*
 * Copyright : (c) 2008, Jeremie Dimino <jeremie@dimino.org>
 * Licence   : BSD3
 *
 * This file is a part of obus, an ocaml implementation of D-Bus.
 *)
  exception Fail of int * string

  let pos lexbuf = lexbuf.Lexing.lex_start_p.Lexing.pos_cnum

  let fail lexbuf fmt =
    Printf.ksprintf
      (fun msg -> raise (Fail(pos lexbuf, msg)))
      fmt

  let decode_char ch = match ch with
    | '0'..'9' -> Char.code ch - Char.code '0'
    | 'a'..'f' -> Char.code ch - Char.code 'a' + 10
    | 'A'..'F' -> Char.code ch - Char.code 'A' + 10
    | _ -> raise (Invalid_argument "decode_char")

  let hex_decode hex =
    if String.length hex mod 2 <> 0 then raise (Invalid_argument "OBus_util.hex_decode");
    let len = String.length hex / 2 in
    let str = Bytes.create len in
    for i = 0 to len - 1 do
      Bytes.unsafe_set str i
        (char_of_int
           ((decode_char (String.unsafe_get hex (i * 2)) lsl 4) lor
              (decode_char (String.unsafe_get hex (i * 2 + 1)))))
    done;
    Bytes.unsafe_to_string str

  type t =
    { name : string
    ; args : (string * string) list
    }

  type error =
    { position : int
    ; reason : string
    }


# 48 "otherlibs/dune-rpc/private/dbus_address.ml"
let __ocaml_lex_tables = {
  Lexing.lex_base =
   "\000\000\253\255\254\255\004\000\001\000\254\255\255\255\002\000\
    \255\255\008\000\254\255\012\000\020\000\254\255\024\000\001\000\
    \255\255\011\000\255\255\043\000\254\255\255\255\118\000\141\000\
    \255\255";
  Lexing.lex_backtrk =
   "\255\255\255\255\255\255\000\000\255\255\255\255\255\255\001\000\
    \255\255\002\000\255\255\000\000\002\000\255\255\000\000\001\000\
    \255\255\001\000\255\255\002\000\255\255\255\255\001\000\255\255\
    \255\255";
  Lexing.lex_default =
   "\003\000\000\000\000\000\003\000\005\000\000\000\000\000\255\255\
    \000\000\011\000\000\000\011\000\014\000\000\000\014\000\255\255\
    \000\000\255\255\000\000\255\255\000\000\000\000\255\255\255\255\
    \000\000";
  Lexing.lex_trans =
   "\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\255\255\016\000\000\000\000\000\
    \255\255\000\000\000\000\000\000\255\255\000\000\000\000\000\000\
    \255\255\000\000\002\000\255\255\008\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\010\000\255\255\255\255\
    \018\000\255\255\000\000\000\000\000\000\000\000\255\255\255\255\
    \020\000\013\000\255\255\255\255\000\000\255\255\000\000\000\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\000\000\021\000\
    \000\000\000\000\021\000\000\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\021\000\021\000\
    \021\000\021\000\021\000\021\000\021\000\021\000\023\000\023\000\
    \023\000\023\000\023\000\023\000\023\000\023\000\023\000\023\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\023\000\
    \023\000\023\000\023\000\023\000\023\000\024\000\024\000\024\000\
    \024\000\024\000\024\000\024\000\024\000\024\000\024\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\024\000\024\000\
    \024\000\024\000\024\000\024\000\000\000\000\000\000\000\023\000\
    \023\000\023\000\023\000\023\000\023\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\024\000\024\000\
    \024\000\024\000\024\000\024\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \001\000\006\000\000\000\000\000\255\255\000\000\000\000\000\000\
    \255\255\000\000\000\000\000\000\255\255\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\255\255\000\000\000\000\000\000\
    \255\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
    \000\000\000\000\000\000\000\000\000\000\000\000";
  Lexing.lex_check =
   "\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\000\000\015\000\255\255\255\255\
    \003\000\255\255\255\255\255\255\009\000\255\255\255\255\255\255\
    \011\000\255\255\000\000\000\000\007\000\000\000\003\000\003\000\
    \012\000\003\000\009\000\009\000\014\000\009\000\011\000\011\000\
    \017\000\011\000\255\255\255\255\255\255\255\255\012\000\012\000\
    \019\000\012\000\014\000\014\000\255\255\014\000\255\255\255\255\
    \019\000\019\000\019\000\019\000\019\000\019\000\019\000\019\000\
    \019\000\019\000\019\000\019\000\019\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\019\000\019\000\019\000\019\000\
    \019\000\019\000\019\000\019\000\019\000\019\000\019\000\019\000\
    \019\000\019\000\019\000\019\000\019\000\019\000\019\000\019\000\
    \019\000\019\000\019\000\019\000\019\000\019\000\255\255\019\000\
    \255\255\255\255\019\000\255\255\019\000\019\000\019\000\019\000\
    \019\000\019\000\019\000\019\000\019\000\019\000\019\000\019\000\
    \019\000\019\000\019\000\019\000\019\000\019\000\019\000\019\000\
    \019\000\019\000\019\000\019\000\019\000\019\000\022\000\022\000\
    \022\000\022\000\022\000\022\000\022\000\022\000\022\000\022\000\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\022\000\
    \022\000\022\000\022\000\022\000\022\000\023\000\023\000\023\000\
    \023\000\023\000\023\000\023\000\023\000\023\000\023\000\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\023\000\023\000\
    \023\000\023\000\023\000\023\000\255\255\255\255\255\255\022\000\
    \022\000\022\000\022\000\022\000\022\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\023\000\023\000\
    \023\000\023\000\023\000\023\000\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \000\000\004\000\255\255\255\255\003\000\255\255\255\255\255\255\
    \009\000\255\255\255\255\255\255\011\000\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\012\000\255\255\255\255\255\255\
    \014\000\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
    \255\255\255\255\255\255\255\255\255\255\255\255";
  Lexing.lex_base_code =
   "";
  Lexing.lex_backtrk_code =
   "";
  Lexing.lex_default_code =
   "";
  Lexing.lex_trans_code =
   "";
  Lexing.lex_check_code =
   "";
  Lexing.lex_code =
   "";
}

let rec address lexbuf =
   __ocaml_lex_address_rec lexbuf 0
and __ocaml_lex_address_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
let
# 51 "otherlibs/dune-rpc/private/dbus_address.mll"
              name
# 189 "otherlibs/dune-rpc/private/dbus_address.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 51 "otherlibs/dune-rpc/private/dbus_address.mll"
                   (
        check_colon lexbuf;
        let args = parameters lexbuf in
        check_eof lexbuf;
        { name ; args }
      )
# 198 "otherlibs/dune-rpc/private/dbus_address.ml"

  | 1 ->
# 57 "otherlibs/dune-rpc/private/dbus_address.mll"
          (
        fail lexbuf "empty transport name"
      )
# 205 "otherlibs/dune-rpc/private/dbus_address.ml"

  | 2 ->
# 60 "otherlibs/dune-rpc/private/dbus_address.mll"
          (
        fail lexbuf "address expected"
      )
# 212 "otherlibs/dune-rpc/private/dbus_address.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_address_rec lexbuf __ocaml_lex_state

and check_eof lexbuf =
   __ocaml_lex_check_eof_rec lexbuf 4
and __ocaml_lex_check_eof_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 65 "otherlibs/dune-rpc/private/dbus_address.mll"
          ( () )
# 224 "otherlibs/dune-rpc/private/dbus_address.ml"

  | 1 ->
let
# 66 "otherlibs/dune-rpc/private/dbus_address.mll"
           ch
# 230 "otherlibs/dune-rpc/private/dbus_address.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 66 "otherlibs/dune-rpc/private/dbus_address.mll"
              ( fail lexbuf "invalid character %C" ch )
# 234 "otherlibs/dune-rpc/private/dbus_address.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_check_eof_rec lexbuf __ocaml_lex_state

and check_colon lexbuf =
   __ocaml_lex_check_colon_rec lexbuf 7
and __ocaml_lex_check_colon_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 69 "otherlibs/dune-rpc/private/dbus_address.mll"
          ( () )
# 246 "otherlibs/dune-rpc/private/dbus_address.ml"

  | 1 ->
# 70 "otherlibs/dune-rpc/private/dbus_address.mll"
         ( fail lexbuf "colon expected after transport name" )
# 251 "otherlibs/dune-rpc/private/dbus_address.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_check_colon_rec lexbuf __ocaml_lex_state

and parameters lexbuf =
   __ocaml_lex_parameters_rec lexbuf 9
and __ocaml_lex_parameters_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
let
# 73 "otherlibs/dune-rpc/private/dbus_address.mll"
              key
# 264 "otherlibs/dune-rpc/private/dbus_address.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 73 "otherlibs/dune-rpc/private/dbus_address.mll"
                  (
        check_equal lexbuf;
        let value = value (Buffer.create 42) lexbuf in
        if coma lexbuf then
          (key, value) :: parameters_plus lexbuf
        else
          [(key, value)]
      )
# 275 "otherlibs/dune-rpc/private/dbus_address.ml"

  | 1 ->
# 81 "otherlibs/dune-rpc/private/dbus_address.mll"
          ( fail lexbuf "empty key" )
# 280 "otherlibs/dune-rpc/private/dbus_address.ml"

  | 2 ->
# 82 "otherlibs/dune-rpc/private/dbus_address.mll"
         ( [] )
# 285 "otherlibs/dune-rpc/private/dbus_address.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_parameters_rec lexbuf __ocaml_lex_state

and parameters_plus lexbuf =
   __ocaml_lex_parameters_plus_rec lexbuf 12
and __ocaml_lex_parameters_plus_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
let
# 85 "otherlibs/dune-rpc/private/dbus_address.mll"
              key
# 298 "otherlibs/dune-rpc/private/dbus_address.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos lexbuf.Lexing.lex_curr_pos in
# 85 "otherlibs/dune-rpc/private/dbus_address.mll"
                  (
        check_equal lexbuf;
        let value = value (Buffer.create 42) lexbuf in
        if coma lexbuf then
          (key, value) :: parameters_plus lexbuf
        else
          [(key, value)]
      )
# 309 "otherlibs/dune-rpc/private/dbus_address.ml"

  | 1 ->
# 93 "otherlibs/dune-rpc/private/dbus_address.mll"
          ( fail lexbuf "empty key" )
# 314 "otherlibs/dune-rpc/private/dbus_address.ml"

  | 2 ->
# 94 "otherlibs/dune-rpc/private/dbus_address.mll"
         ( fail lexbuf "parameter expected" )
# 319 "otherlibs/dune-rpc/private/dbus_address.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_parameters_plus_rec lexbuf __ocaml_lex_state

and coma lexbuf =
   __ocaml_lex_coma_rec lexbuf 15
and __ocaml_lex_coma_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 97 "otherlibs/dune-rpc/private/dbus_address.mll"
          ( true )
# 331 "otherlibs/dune-rpc/private/dbus_address.ml"

  | 1 ->
# 98 "otherlibs/dune-rpc/private/dbus_address.mll"
         ( false )
# 336 "otherlibs/dune-rpc/private/dbus_address.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_coma_rec lexbuf __ocaml_lex_state

and check_equal lexbuf =
   __ocaml_lex_check_equal_rec lexbuf 17
and __ocaml_lex_check_equal_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
# 101 "otherlibs/dune-rpc/private/dbus_address.mll"
          ( () )
# 348 "otherlibs/dune-rpc/private/dbus_address.ml"

  | 1 ->
# 102 "otherlibs/dune-rpc/private/dbus_address.mll"
         ( fail lexbuf "equal expected after key" )
# 353 "otherlibs/dune-rpc/private/dbus_address.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_check_equal_rec lexbuf __ocaml_lex_state

and value buf lexbuf =
   __ocaml_lex_value_rec buf lexbuf 19
and __ocaml_lex_value_rec buf lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
let
# 105 "otherlibs/dune-rpc/private/dbus_address.mll"
                                                          ch
# 366 "otherlibs/dune-rpc/private/dbus_address.ml"
= Lexing.sub_lexeme_char lexbuf lexbuf.Lexing.lex_start_pos in
# 105 "otherlibs/dune-rpc/private/dbus_address.mll"
                                                             (
        Buffer.add_char buf ch;
        value buf lexbuf
      )
# 373 "otherlibs/dune-rpc/private/dbus_address.ml"

  | 1 ->
# 109 "otherlibs/dune-rpc/private/dbus_address.mll"
          (
        Buffer.add_string buf (unescape lexbuf);
        value buf lexbuf
      )
# 381 "otherlibs/dune-rpc/private/dbus_address.ml"

  | 2 ->
# 113 "otherlibs/dune-rpc/private/dbus_address.mll"
         (
        Buffer.contents buf
      )
# 388 "otherlibs/dune-rpc/private/dbus_address.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_value_rec buf lexbuf __ocaml_lex_state

and unescape lexbuf =
   __ocaml_lex_unescape_rec lexbuf 22
and __ocaml_lex_unescape_rec lexbuf __ocaml_lex_state =
  match Lexing.engine __ocaml_lex_tables __ocaml_lex_state lexbuf with
      | 0 ->
let
# 118 "otherlibs/dune-rpc/private/dbus_address.mll"
                                                                 str
# 401 "otherlibs/dune-rpc/private/dbus_address.ml"
= Lexing.sub_lexeme lexbuf lexbuf.Lexing.lex_start_pos (lexbuf.Lexing.lex_start_pos + 2) in
# 119 "otherlibs/dune-rpc/private/dbus_address.mll"
        ( hex_decode str )
# 405 "otherlibs/dune-rpc/private/dbus_address.ml"

  | 1 ->
# 121 "otherlibs/dune-rpc/private/dbus_address.mll"
        ( fail lexbuf "two hexdigits expected after '%%'" )
# 410 "otherlibs/dune-rpc/private/dbus_address.ml"

  | __ocaml_lex_state -> lexbuf.Lexing.refill_buff lexbuf;
      __ocaml_lex_unescape_rec lexbuf __ocaml_lex_state

;;

# 123 "otherlibs/dune-rpc/private/dbus_address.mll"
 
  let of_string str =
    try
      Ok (address (Lexing.from_string str))
    with Fail(position, reason) ->
      Error { position ; reason }

  let to_string { name ; args } =
    let buf = Buffer.create 42 in
    let escape = String.iter begin fun ch -> match ch with
      | '0'..'9' | 'A'..'Z' | 'a'..'z'
      | '_' | '-' | '/' | '.' | '\\' ->
          Buffer.add_char buf ch
      | _ ->
          Printf.bprintf buf "%%%02x" (Char.code ch)
    end in
    let concat ch f = function
      | [] -> ()
      | x :: l -> f x; List.iter (fun x -> Buffer.add_char buf ch; f x) l
    in
    Buffer.add_string buf name;
    Buffer.add_char buf ':';
    concat ','
      (fun (k, v) ->
         Buffer.add_string buf k;
         Buffer.add_char buf '=';
         escape v)
      args;
    Buffer.contents buf


# 449 "otherlibs/dune-rpc/private/dbus_address.ml"
