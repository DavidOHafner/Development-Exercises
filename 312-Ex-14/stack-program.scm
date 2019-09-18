;Author: Samantha Hafner
;Content:
;Intent: Solution to CSC-312 Ex-14
;Attribution: Specification for stack program syntax and interpretation
;  adopted from John David Stone's Exercise 14 for CSC 312

#!r7rs
(import (scheme base) (scheme write)); (utilities eolp))

;Concrete grammar for stack program:
; program ::= {routine}*
; routine ::= print
; routine ::= push Int program pop

custom datatypes appearing in a stack program's abstract syntax tree
(define-datatype program program?
  (a-program (body list-of-routines?)))
(define-datatype routine routine?
  (print)
  (push-pop (value int?) (body program?)))

;list-of-routines?: SchemeVal -> Bool
;usage: (list-of-routines? test) returns #t iff test is a finite list of values which satisfy routine?
(define (list-of-routines? test)
  (or
   null? test
   (and
    (list? test)
    (routine? (car test))
    (list-of-routines? (cdr test)))))

;execute: program -> ∅
;usage: (execute stack-program) prints output according to the specified behavior of a stack program
(define (execute stack-program)
  (cases program stack-program
    (a-program (list-of-routines) (execute-list-of-routines list-of-routines "Empty Stack"))))

;execute: list-of-routines × SchemeVal -> ∅
;usage: prints output according to the specified behavior of a list-of-routines
;       with specified value at the top of the stack.
;       This procedure is more general than requiered by the stack program specification
;       but an error will still be thrown if a non integer is pushed onto the stack.
(define (execute-list-of-routines list-of-routines top-of-stack)
  (unless (null? list-of-routines)
    (begin
      (cases routine (car list-of-routines)
        (print () (display top-of-stack))
        (push-pop
         (value body)
         (cases program body
           (a-program (list-of-routines) (execute-list-of-routines list-of-routines value)))))
      (execute-list-of-routines (cdr list-of-routines) top-of-stack))))