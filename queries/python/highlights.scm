; extends

((string
   (string_start) @string.prefix)
 (#match? @string.prefix "^[fFrRbBtT]{1,2}['\"]$")
 (#offset! @string.prefix 0 0 0 -1))
