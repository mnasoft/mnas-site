;;;; mnas-site.asd

(asdf:defsystem #:mnas-site
  :description "Describe mnas-site here"
  :author "Your Name <your.name@example.com>"
  :license "Specify license here"
  :serial t
  :depends-on (#:hunchentoot #:cl-who #:mnas-string #:mnas-dns #:mnas-passwd #:mnas-site-route)
  :components ((:file "package")
               (:file "mnas-site")))
