;Author: Samantha Hafner
;Content: Mirrors binary search trees
;Intent: Solution to CSC-312 Ex-2
;Attribution: BinTree definition and specification of reverse-tree adopted from course textbook.

#!r7rs
(import (scheme base) (scheme write) (scheme cxr))

;reverse-symbol: Symbol -> Symbol
;usage: (reverse-symbol symbol) returns symbol with its letters reversed
(define (reverse-symbol symbol)
  (string->symbol (list->string
                   (reverse
                    (string->list (symbol->string symbol))))))

;BinTree := int | (Symbol BinTree BinTree)
;mirror-tree BinTree -> BinTree
;usage: (mirror-tree tree) returns the given tree mirrored according to the following rules:
; A mirrored integer is its additive inverse
; A mirrored tree of the form (A B C) is (reverse-of-A mirror-of-C mirror-of-B)
(define (mirror-tree tree)
  (if (integer? tree)
      (- tree)
      (list
       (reverse-symbol (car tree))
       (mirror-tree (caddr tree))
       (mirror-tree (cadr tree)))))

;Test, output should be: -1
(display (mirror-tree 1))
(newline)
;Test, output should be: (CBA (rab 5 (zyx 0 4)) (oof -23 -1))
(display (mirror-tree '(ABC (foo 1 23) (bar (xyz -4 0) -5))))

;.35 (.17, .18)