type token =
  | Param of (string)
  | AUTHOR
  | Version of (string)
  | See of (Types.see_ref)
  | Since of (string)
  | Before of (string)
  | DEPRECATED
  | Raise of (string)
  | RETURN
  | INLINE
  | Custom of (string)
  | Canonical of (string)
  | BEGIN
  | END
  | Title of (int * string option)
  | Style of (Types.style_kind)
  | LIST
  | ENUM
  | Item of (bool)
  | Ref of (Types.ref_kind * string)
  | Special_Ref of (Types.special_ref_kind)
  | Code of (string)
  | Pre_Code of (string)
  | Verb of (string)
  | Target of (string option * string)
  | HTML_Bold of (string)
  | HTML_END_BOLD
  | HTML_Center of (string)
  | HTML_END_CENTER
  | HTML_Left of (string)
  | HTML_END_LEFT
  | HTML_Right of (string)
  | HTML_END_RIGHT
  | HTML_Italic of (string)
  | HTML_END_ITALIC
  | HTML_Title of (string * int)
  | HTML_END_Title of (int)
  | HTML_List of (string)
  | HTML_END_LIST
  | HTML_Enum of (string)
  | HTML_END_ENUM
  | HTML_Item of (string)
  | HTML_END_ITEM
  | MINUS
  | PLUS
  | NEWLINE
  | EOF
  | BLANK
  | Char of (string)
  | DOT
  | Ref_part of (string)

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> Types.t
val reference_parts :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> (string option * string) list
