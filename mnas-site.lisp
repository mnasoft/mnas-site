;;;; mnas-site.lisp

(in-package :mnas-site)

;;; "mnas-site" goes here. Hacks and glory await!

(setf (html-mode) :HTML5)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun dep11-allowed-ip ()
  (apply #'append 
	 (mapcar #'(lambda (el) (ip-by-name el)) 
		 (append *localhost* *dep11-comps* *dep-oakts-comps*))))

(defparameter *dep11-allowed-ip* (dep11-allowed-ip))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *i* 0)

(defparameter *sleep-time* 300)

(export 'update-ip)
(defun update-ip () (setf *dep11-allowed-ip* (dep11-allowed-ip)))

(defun update-ip-in-thread ()
  (sb-thread:make-thread 
   #'(lambda ()
       (do () (nil)
	 (update-ip)
	 (setf *i* (incf *i*))
	 (sleep *sleep-time*)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defparameter *mnas-site-document-root*
  (cond
    ((string= (machine-instance) "MNASOFT-01")  "D:/PRG/msys32/home/namatv/public_html/" )
    ((string= (machine-instance) "N133907")     "\\\\N000171\\home\\_namatv\\public_html\\" )
    ((string= (machine-instance) "N000466")     "\\\\N000171\\home\\_namatv\\public_html\\" )
    (t "/home/namatv/public_html/")))

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

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun allowed-address-list()
  (let ((m-inst (machine-instance)))
    (cond
      ((or (string= m-inst "hp1.zorya.com")
	   (string= m-inst "N133907")
           (string= m-inst "N000466"))
       *dep11-allowed-ip*)
      ((or (string= m-inst "mnasoft-00")
	   (string= m-inst "mnasoft-pi")
	   (string= m-inst "MNASOFT-01"))
       (append *localhost-ip* *mnasoft-comps-ip*))
      (t  (append *localhost-ip*)))))

(defun allowed-address-p()
  (let ((m-inst (machine-instance)))
    (cond
      ((string= m-inst "mnasoft-pi") t)
      ((string= m-inst "mnasoft-00") (append *localhost-ip*  *mnasoft-comps-ip*))
      (t (member (real-remote-addr)  (allowed-address-list) :test #'equal)))))

(defun mnas-site-set-document-root ()
  (setf (acceptor-document-root *mnas-site-acceptor*) *mnas-site-document-root*))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(update-ip-in-thread)

;;;; (update-ip)
