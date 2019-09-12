;Author: Samantha Hafner
;Content: computes the partial sum of a list of integers
;Intent: Revised 1 solution to-CSC 312 Ex-1

#!r7rs
(import (scheme base) (scheme write))

;partial-sum-i: ListOf(Int) × Int -> ListOf(Int)
;usage: (partial-sum-i ls i) = the partial sums of ls with initial value i
(define (partial-sum-i ls i)
  (if
   (null? ls)
   '()
   (let ((next-i (+ i (car ls))))
     (cons
      next-i
      (partial-sum-i (cdr ls) next-i)))))

;partial-sum-i: ListOf(Int) -> ListOf(Int)
;usage: (partial-sum ls) = the partial sums of ls
(define (partial-sum ls)
   (partial-sum-i ls 0))

;Test, output should be: (3 8 6 13 12)
(display (partial-sum '(3 5 -2 7 -1)))

;1.2
;.37