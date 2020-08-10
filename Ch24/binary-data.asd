;;;; binary-data.asd

(asdf:defsystem #:binary-data
  :description "Describe binary-data here"
  :author "Gustavo Alves Pacheco <gap1512@gmail.com>"
  :license  "Specify license here"
  :version "0.0.1"
  :serial t
  :components ((:file "package")
	       (:file "macro-utilities")
               (:file "binary-data")))
