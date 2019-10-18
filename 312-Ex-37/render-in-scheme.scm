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

;type: ListOf(String) | (ListOf(Char) . ListOf(String) -> String
;usage: returns the concatenation of all elements in list-of-strings
(define (string-concatenate list-of-strings)
  (if (null? list-of-strings) ""
   (if 
    (string? (car list-of-strings))
    (string-concatenate
     (cons
      (string->list (car list-of-strings))
      (cdr list-of-strings)))
    (if
     (null? (cdr list-of-strings))
     (list->string (car list-of-strings))
     (string-concatenate
      (cons
       (append
        (car list-of-strings)
        (string->list (cadr list-of-strings)))
       (cddr list-of-strings)))))))

;type: program -> String
;usage: returns prog compiled to Scheme code as a String
(define (render-in-scheme prog)
  (cases program prog
    (a-program (exp)
               (exp-in-scheme exp))))

;type: expression -> String
;usage: returns exp compiled to Scheme code as a String
(define (exp-in-scheme exp)
  (cases expression exp
    (const-exp (num)
               (number->string num))
    (var-exp (var)
             (symbol->string var))
    (diff-exp (exp1 exp2) (string-concatenate (list "(- " (exp-in-scheme exp1) " "
                                                          (exp-in-scheme exp2) ")")))
    (zero?-exp (exp1) (string-concatenate (list "(zero? " (exp-in-scheme exp1) ")")))
    (if-exp (exp1 exp2 exp3) (string-concatenate (list "(if " (exp-in-scheme exp1) " "
                                                        (exp-in-scheme exp2) " "
                                                        (exp-in-scheme exp3) ")")))
    (let-exp (var exp1 exp2) (string-concatenate (list "(let ((" (symbol->string var) " "
                                                        (exp-in-scheme exp1) ")) "
                                                        (exp-in-scheme exp2) ")")))))

(define (LET-to-scheme program)
  (render-in-scheme (scan&parse program)))

;Tests of helper method string-concatenate
(display (string-concatenate '()))
(newline)
(display (string-concatenate (list "13")))
(newline)
(display (string-concatenate (list "1" "23")))
(newline)
(display (string-concatenate (list (string->list "abc") "acbar" "3")))
(newline)

;Cumulative test
(display (LET-to-scheme "
let x = -(12, 4) in
 let y = -(x, x) in
  if
   if zero?(y) then zero?(y) else zero?(x)
  then
   -(x, 3)
  else
   let z = 8 in
    zero?(-(x, z))
"))
(newline)
(display
 (let ((x (- 12 4))) (let ((y (- x x))) (if (if (zero? y) (zero? y) (zero? x)) (- x 3) (let ((z 8)) (zero? (- x z))))))
)

;Copyright 2019 Samantha Orion Hafner: CC BY 4.0