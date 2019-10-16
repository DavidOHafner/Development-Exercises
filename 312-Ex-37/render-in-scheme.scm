;Author: Samantha Hafner
;Content: Compiles programs in the LET language to scheme.
;Intent: Solution to CSC-312 Ex-37
;Attribution: utilizes methods and utilities by John David Stone

#!r7rs
(import (scheme base)
        (scheme write) 
        (utilities eopl)
        (LET parser)
        (LET syntax-trees))

(define (render-in-scheme exp)
  (cases expression exp
    (const-exp (num)
               (number->string num))
    (var-exp (var)
             (symbol->string 'num)
    (diff-exp (exp1 exp2) (string-concatenate (list "(" (render-in-scheme exp1) "-"
                                                        (render-in-scheme exp2) ")")))
    (zero?-exp (exp1) (string-concatenate (list "(zero? " (render-in-scheme exp1) ")"))
    (if-exp (exp1 exp2 exp3) (string-concatenate (list "(if " (render-in-scheme exp1) " "
                                                        (render-in-scheme exp2) " "
                                                        (render-in-scheme exp3) ")")))
    (let-exp (var exp1 exp2) (string-concatenate (list "(let ((" (symbol->string var) " "
                                                        (render-in-scheme exp1) ")) "
                                                        (render-in-scheme exp2) ")")))))))

(define (LET-to-scheme program)
  (render-in-scheme (scan&parse program)))

;Copyright 2019 Samantha Orion Hafner: CC BY 4.0