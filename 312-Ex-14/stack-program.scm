;Author: Samantha Hafner
;Content: Grammar, datatype definitions, and interpreter for the stack program language.
;Intent: Solution to CSC-312 Ex-14
;Attribution: Specification for stack program syntax and interpretation
;  adopted from John David Stone's Exercise 14 for CSC 312

#!r7rs
(import (scheme base) (scheme write) (utilities eopl))


;Concrete grammar for stack programs:
; program ::= {routine}*
; routine ::= print
; routine ::= push Int program pop

;custom datatypes appearing in a stack program's abstract syntax tree
(define-datatype program program?
  (a-program (body list-of-routines?)))
(define-datatype routine routine?
  (print)
  (push-pop (value integer?) (body program?)))

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
;       Due to the recursive nature of this procedure, the Scheme call stack records
;       the stack program stack and so passing the entire stack would be redundant.
(define (execute-list-of-routines list-of-routines top-of-stack)
  (unless (null? list-of-routines)
    (begin
      (cases routine (car list-of-routines)
        (print () (begin (display top-of-stack) (newline)))
        (push-pop
         (value body)
         (cases program body
           (a-program (list-of-routines) (execute-list-of-routines list-of-routines value)))))
      (execute-list-of-routines (cdr list-of-routines) top-of-stack))))


;Test: output should be "Empty Stack\n"
(execute (a-program (list (print))))
(newline)
;Test: output should be "2\n1\n"
(execute (a-program (list
  (push-pop
    1 
    (a-program (list
      (push-pop
        2
        (a-program (list
          (print))))
      (print)))))))
(newline)
;Test: output should be "1\n2\n2\n3\n1\n"
(execute (a-program (list
  (push-pop
    1 
    (a-program (list
      (print)
      (push-pop
        2
        (a-program (list
          (print)
          (print)
          (push-pop
            3
            (a-program (list
              (print)))))))
      (print)))))))
