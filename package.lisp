;;;; package.lisp

(defpackage #:mnas-site
  (:use #:cl #:mnas-string #:hunchentoot #:cl-who)
  (:export *mnas-site-acceptor*
	   mnas-site-start
	   mnas-site-stop
	   clean-dispatch-table
	   define-url-fn
	   ))

;;;;(declaim (optimize (space 0) (compilation-speed 0)  (speed 0) (safety 3) (debug 3)))

