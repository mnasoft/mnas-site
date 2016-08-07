;;;; package.lisp

(defpackage #:mnas-site
  (:use #:cl #:hunchentoot #:cl-who #:mnas-string #:mnas-dns #:dep11)
  (:export *mnas-site-acceptor*
	   mnas-site-start
	   mnas-site-stop
	   clean-dispatch-table
	   define-url-fn
	   allowed-address-p
	   allowed-address-list
	   ))

;;;;(declaim (optimize (space 0) (compilation-speed 0)  (speed 0) (safety 3) (debug 3)))


