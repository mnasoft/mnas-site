;;;; mnas-site.lisp

(in-package #:mnas-site)

;;; "mnas-site" goes here. Hacks and glory await!

(setf (html-mode) :HTML5)

(defun clean-dispatch-table()
  (if (> (length *dispatch-table*) 1)
      (setf *dispatch-table* (last *dispatch-table*)))
  *dispatch-table*)

(defmacro define-url-fn ((name) &body body)
  `(progn (defun ,name() ,@body)
	  (push (create-prefix-dispatcher ,(format nil "/~(~a~)" name) ',name) *dispatch-table*)))
