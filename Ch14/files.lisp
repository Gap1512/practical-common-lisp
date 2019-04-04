(open "./name.txt")

(let ((in (open "./name.txt")))
  (format t "~a~%" (read-line in))
  (close in))

(let ((in (open "./name1.txt" :if-does-not-exist nil)))
  (format t "~a~%" (read-line in))
  (close in))

(let ((in (open "./name.txt" :if-does-not-exist nil)))
  (when in
    (loop for line = (read-line in nil)
       while line do (format t "~a~%" line))
    (close in)))

(defparameter *s* (open "./name.txt"))
(read *s*)
(read *s*)
(read *s*)
(read *s*)
(close *s*)

(open "./name1.txt" :direction :output :if-exists :supersede)

(let ((stream (open "/.name1.txt")))
  ;; do stuff with stream
  (close stream))

(with-open-file (stream "./name.txt")
  (format t "~a~%" (read-line stream)))

(with-open-file (stream "./name1.txt" :direction :output :if-exists :supersede)
  (format stream "Some text."))

(pathname-directory (pathname "/foo/bar/baz.txt"))
(pathname-name (pathname "/foo/bar/baz.txt"))
(pathname-type (pathname "/foo/bar/baz.txt"))
#p"/foo/bar/baz.txt"

(namestring #p"/foo/bar/baz.txt")
(directory-namestring #p"/foo/bar/baz.txt")
(file-namestring #p"/foo/bar/baz.txt")

(make-pathname
 :directory '(:absolute "foo" "bar")
 :name "baz"
 :type "txt")

;;(make-pathname :type "html" :defaults input-file)
;;(make-pathname :type "html" :version :newest :defaults input-file)
;;(make-pathname :directory '(:relative "backups") :defaults input-file)

(merge-pathnames #p"foo/bar.html" #p"/www/html/")
(merge-pathnames #p"foo/bar.html" #p"html/")
(enough-namestring #p"/www/html/foo/bar.html" #p"/www/")
(merge-pathnames
 (enough-namestring #p"/www/html/foo/bar/baz.html" #p"/www/")
 #p"/www-backups/")

(make-pathname :directory '(:absolute "foo") :name "bar")
(make-pathname :directory '(:absolute "foo" "bar"))

;;(with-open-file (in filename :element-type '(unsigned-byte 8))
;;  (file-length in))

(let ((s (make-string-input-stream "1.23")))
  (unwind-protect (read s)
    (close s)))

(with-input-from-string (s "(+ 1 2)")
  (read s))

(with-output-to-string (out)
  (format out "hello, world ")
  (format out "~s" (list 1 2 3)))
