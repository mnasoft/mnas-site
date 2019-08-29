;;;; package.lisp

(defpackage #:mnas-site
  (:use #:cl #:hunchentoot #:cl-who #:mnas-string #:mnas-dns #:mnas-site-route)
  (:export *mnas-site-acceptor*
	   *mnas-site-port*
	   mnas-site-start
	   mnas-site-stop
	   clean-dispatch-table
	   define-url-fn
	   allowed-address-p
	   allowed-address-list
	   ))

;;;;(declaim (optimize (space 0) (compilation-speed 0)  (speed 0) (safety 3) (debug 3)))



;;;; (declaim (optimize (compilation-speed 0) (debug 3) (safety 0) (space 0) (speed 0)))
