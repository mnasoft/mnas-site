;;;; mnas-site.lisp

(in-package #:mnas-site)

;;; "mnas-site" goes here. Hacks and glory await!

(setf (html-mode) :HTML5)

(defparameter *mnas-site-acceptor* nil)

(defun mnas-site-start()
  (if (null *mnas-site-acceptor*)
      (setf *mnas-site-acceptor* (start (make-instance 'easy-acceptor :port 8000)))))

(defun mnas-site-stop()
  (if *mnas-site-acceptor*
      (progn (stop *mnas-site-acceptor*)
	     (setf *mnas-site-acceptor* nil))))

(defun clean-dispatch-table(disp-tbl)
  (mapcar #'(lambda(el)
	      (setf *dispatch-table* (remove el *dispatch-table*)))
	  (eval disp-tbl))
  (set disp-tbl nil) *dispatch-table*)

(defmacro define-url-fn ((name disp-tbl) &body body)
  `(progn (defun ,name() ,@body)
	  (let  ((pr-disp (create-prefix-dispatcher ,(format nil "/~(~a~)" name) ',name)))
	    (push pr-disp *dispatch-table*)
	    (push pr-disp ,disp-tbl))))

;;;;(defmacro define-url-fn ((name) &body body) `(progn (defun ,name() ,@body) (push (create-prefix-dispatcher ,(format nil "/~(~a~)" name) ',name) *dispatch-table*)))
