;;;; package.lisp

(defpackage #:mnas-site
  (:use #:cl #:mnas-string #:hunchentoot #:cl-who)
  (:export clean-dispatch-table define-url-fn))

;;;;(declaim (optimize (space 0) (compilation-speed 0)  (speed 0) (safety 3) (debug 3)))
