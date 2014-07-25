#lang racket/base
;
; FFI bindings for the libuuid library
;

(require
  (rename-in ffi/unsafe (-> -->)))

(require ffi/unsafe/define)

(provide uuid-generate
         uuid-generate/random
         uuid-generate/time)


(define-ffi-definer define-uuid
                    (ffi-lib "libuuid" '("1" "")))


(define-uuid uuid-generate
             (_fun (out : _bytes = (make-bytes 16))
                   --> _void
                   --> (uuid-unparse out))
             #:c-id uuid_generate)

(define-uuid uuid-generate/random
             (_fun (out : _bytes = (make-bytes 16))
                   --> _void
                   --> (uuid-unparse out))
             #:c-id uuid_generate_random)

(define-uuid uuid-generate/time
             (_fun (out : _bytes = (make-bytes 16))
                   --> _void
                   --> (uuid-unparse out))
             #:c-id uuid_generate_time)

(define-uuid uuid-unparse
             (_fun (uuid : _bytes)
                   (out : _bytes = (make-bytes 32))
                   --> _void
                   --> (cast out _bytes _string/utf-8))
             #:c-id uuid_unparse)


; vim:set ts=2 sw=2 et:
