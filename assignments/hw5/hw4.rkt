
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

; problem 1
; Write a function sequence that takes 3 arguments low, high, and stride, all assumed to be numbers.
; Further assume stride is positive. sequence produces a list of numbers from low to high (including
; low and possibly high) separated by stride and in sorted order. Sample solution: 4 lines. Examples:
;          Call               Result
;          (sequence 3 11 2)  '(3 5 7 9 11)
;          (sequence 3 8 3)   '(3 6)
;          (sequence 3 2 1)   '()
(define (sequence low high stride)
  (if (> low high) 
      null
      (cons low (sequence (+ low stride) high stride))))
