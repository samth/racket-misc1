#lang racket/base
;
; Dictionary Utilities
;

(require racket/contract
         racket/undefined
         racket/dict)

(provide
  (all-from-out racket/dict)
  (contract-out
    (dict-mref (->* (dict?) (#:default any/c) #:rest (listof any/c) any))
    (dict-merge (->* (dict?) () #:rest (listof dict?) dict?))
    (dict-merge! (->* (dict?) () #:rest (listof dict?) void?))))


(define (dict-mref dict #:default (default undefined) . keys)
  (if (eq? default undefined)
      (apply values (for/list ((key keys)) (dict-ref dict key)))
      (apply values (for/list ((key keys)) (dict-ref dict key default)))))


(define (dict-extend ext base)
  (define (update-key key dict)
    (dict-set dict key (dict-ref ext key)))
  (foldl update-key base (dict-keys ext)))


(define (dict-merge dict . other-dicts)
  (foldl dict-extend dict other-dicts))


(define (dict-merge! dict . other-dicts)
  (for ((other-dict other-dicts))
    (for (((key value) (in-dict other-dict)))
      (dict-set! dict key value))))


; vim:set ts=2 sw=2 et: