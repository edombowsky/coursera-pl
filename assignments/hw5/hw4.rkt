
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


; problem 3
; 
; Write a function list-nth-mod that takes a list xs and a number n . If the number is negative, terminate
; the computation with (error "list-nth-mod: negative number"). Else if the list is empty, terminate the
; computation with (error "list-nth-mod: empty list"). Else return the ith element of the list where we
; count from zero and i is the remainder produced when dividing n by the list's length. Library functions
; length, remainder, car, and list-tail are all useful - see the Racket documentation. Sample solution is 6 lines
(define (list-nth-mod xs n)
  (cond [(negative? n) (error "list-nth-mod: negative number")]
        [(null? xs) (error "list-nth-mod: empty list")]
        [#t (car (list-tail xs (remainder n (length xs))))]))


; problem 4
;
; Write a function stream-for-n-steps that takes a stream s and a number n. It returns a list holding
; the first n values produced by s in order. Assume n is non-negative. Sample solution: 5 lines. Note:
; You can test your streams with this function instead of the graphics code.
(define (stream-for-n-steps s n)
  (if (<= n 0) null
      (cons (car (s)) (stream-for-n-steps (cdr (s)) (- n 1)))))


; problem 5
;
; Write a stream funny-number-stream that is like the stream of natural numbers (i.e., 1, 2, 3, ...)
; except numbers divisble by 5 are negated (i.e., 1, 2, 3, 4, -5, 6, 7, 8, 9, -10, 11, ...). Remember a
; stream is a thunk that when called produces a pair. Here the car of the pair will be a number and the
; cdr will be another stream.
(define (funny-number-stream)
  (define (th x)
    (cons (if (= 0 (remainder x 5)) (- x) x)
          (lambda ( ) (th (+ x 1)))))
  (th 1))


; problem 6
;
; Write a stream dan-then-dog, where the elements of the stream alternate between the strings "dan.jpg"
; and "dog.jpg" (starting with "dan.jpg"). More specifcally, dan-then-dog should be a thunk that when
; called produces a pair of "dan.jpg" and a thunk that when called produces a pair of "dog.jpg" and a
; thunk that when called... etc. Sample solution: 4 lines.
(define (dan-then-dog)
  (define (th x)
    (cons (if (even? x) "dog.jpg" "dan.jpg")
          (lambda ( ) (th (+ x 1)))))
  (th 1))