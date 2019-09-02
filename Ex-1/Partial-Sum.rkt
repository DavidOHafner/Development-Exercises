#!r7rs
(import (scheme base) (scheme write))

;partial-sum-i: ListOf(Int) X Int -> ListOf(Int)
;usage: (partial-sum-i ls i) = the partial sums of ls with innitial value i
(define (partial-sum-i ls i) (if (null? ls) ls (cons (+ i (car ls)) (partial-sum-i (cdr ls) (+ i (car ls))))))

;partial-sum-i: ListOf(Int) -> ListOf(Int)
;usage: (partial-sum ls) = the partial sums of ls
(define (partial-sum ls) (partial-sum-i ls 0))

;Test, output should be: (3 8 6 13 12)
(display (partial-sum '(3 5 -2 7 -1)))

;1.2