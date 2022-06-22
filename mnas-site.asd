;;;; mnas-site.asd

(defsystem #:mnas-site
  :description "Describe mnas-site here"
  :author "Mykola Matvyeyev <mnasoft@gmail.com>"
  :license "GNU GENERAL PUBLIC LICENSE Version 3, 29 June 2007 or later"  
  :serial t
  :depends-on (#:hunchentoot #:cl-who #:mnas-string #:mnas-dns #:mnas-passwd #:mnas-site-route)
  :components ((:file "package")
               (:file "mnas-site")))
