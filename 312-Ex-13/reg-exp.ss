;Author: Samantha Hafner
;Content: Defines a datatype to represent classical regular expressions
;Intent: Solution to CSC-312 Ex-13

#!r7rs
(import (scheme base) (scheme write) (utilities eopl))

; Grammer:
; reg-exp ::= fail
; reg-exp ::= null-string
; reg-exp ::= character
; reg-exp ::= reg-exp concatination reg-exp
; reg-exp ::= reg-exp alternation reg-exp
; reg-exp ::= itteration of reg-exp

(define-datatype reg-exp reg-exp?
  (fail)
  (null-string)
  (char (value char-graphic?))
  (concatination (exp1 reg-exp?) (exp2 reg-exp?))
  (alternation (exp1 reg-exp?) (exp2 reg-exp?))
  (itteration (exp reg-exp?)))

;Test
(display (alternation
          (concatination
           (concatination
            #\b
            #\a)
           (concatination
            (itteration
             #\a)
            #\!))
          (null-string)))