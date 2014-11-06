
#lang racket

(provide (all-defined-out)) ;; so we can put tests in a second file

;; put your code below

; problem 1
;
; Write a function sequence that takes 3 arguments low, high, and stride, all assumed to be numbers.
; Further assume stride is positive. sequence produces a list of numbers from low to high (including
; low and possibly high) separated by stride and in sorted order. Sample solution: 4 lines. Examples:
;          Call               Result
;          (sequence 3 11 2)  '(3 5 7 9 11)
;          (sequence 3 8 3)   '(3 6)
;          (sequence 3 2 1)   '()
(define (sequence low high stride)
  (cond
    [(> low high) null]
    [#t (cons low (sequence (+ low stride) high stride))]))


; problem 2
;
; Write a function string-append-map that takes a list of strings xs and a string suffix and returns a
; list of strings. Each element of the output should be the corresponding element of the input appended
; with suffix (with no extra space between the element and suffix). You must use Racket-library
; functions map and string-append. Sample solution: 2 lines.
(define (string-append-map strings suffix)
  (map (lambda (str) (string-append str suffix)) strings))