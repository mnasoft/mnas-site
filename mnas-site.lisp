;;;; mnas-site.lisp

(in-package #:mnas-site)

;;; "mnas-site" goes here. Hacks and glory await!

(setf (html-mode) :HTML5)

(defparameter *mnas-site-document-root* "/home/namatv/public_html/")

(defparameter *mnas-site-acceptor* nil)

(defparameter *mnas-site-port* 8000)

(defun mnas-site-start()
  (if (null *mnas-site-acceptor*)
      (progn (setf *mnas-site-acceptor* (start (make-instance 'easy-acceptor :port *mnas-site-port* )))
	     (mnas-site-set-document-root))))

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

(defun allowed-address-p()
  (let ((m-inst (machine-instance)))
    (cond
      ((string= m-inst "mnasoft-pi") t) ;; (list "127.0.0.1" "192.168.0.100" "192.168.0.101" "192.168.0.102" "192.168.0.103" "192.168.0.110")
      ((string= m-inst "mnasoft-00")
       (append *localhost-ip*  *mnasoft-comps-ip*))
      (t (member (real-remote-addr)  (allowed-address-list) :test #'equal)))))

(defun allowed-address-list()
  (let ((m-inst (machine-instance)))
    (cond
      ((or (string= m-inst "mnasoft-00") (string= m-inst "mnasoft-pi"))
       (append *localhost-ip*  *mnasoft-comps-ip*))
      ((or (string= m-inst "hp1.zorya.com"))
       (apply
	#'append 
	(mapcar
	 #'(lambda (el) (ip-by-name el)) 
	 (append
	  *localhost*
	  *dep11-comps*
	  *dep-oakts-comps*)))))))

(defun mnas-site-set-document-root ()
  (setf (acceptor-document-root *mnas-site-acceptor*) *mnas-site-document-root*))
