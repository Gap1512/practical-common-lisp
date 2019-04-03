(vector)
(vector 1)
(vector 1 2)
(make-array 5 :initial-element nil)
(make-array 5 :fill-pointer 0)

(defparameter *x* (make-array 5 :fill-pointer 0))
(vector-push 'a *x*)
(vector-push 'b *x*)
(vector-push 'c *x*)
(vector-pop *x*)
(vector-pop *x*)
(vector-pop *x*)

(make-array 5 :fill-pointer 0 :adjustable t)

(make-array 5 :fill-pointer 0 :adjustable t :element-type 'character)
(make-array 5 :fill-pointer 0 :adjustable t :element-type 'bit)

(defparameter *y* (vector 1 2 3))
(length *y*)
(elt *y* 0)
(elt *y* 1)
(elt *y* 2)
(elt *y* 3)

(setf (elt *y* 0) 10)

(count 1 #(1 2 1 2 3 1 2 3 4))
(remove 1 #(1 2 1 2 3 1 2 3 4))
(remove 1 '(1 2 1 2 3 1 2 3 4))
(remove #\a "foobarbaz")
(substitute 10 1 #(1 2 1 2 3 1 2 3 4))
(substitute 10 1 '(1 2 1 2 3 1 2 3 4))
(find 1 #(1 2 1 2 3 1 2 3 4))
(find 10 #(1 2 1 2 3 1 2 3 4))
(position 1 #(1 2 1 2 3 1 2 3 4))

(count "foo" #("foo" "bar" "baz") :test #'string=)
(find 'c #((a 10) (b 20) (c 30) (d 40)) :key #'first)

(find 'a #((a 10) (b 20) (a 30) (b 40)) :key #'first)
(find 'a #((a 10) (b 20) (a 30) (b 40)) :key #'first :from-end t)

(remove #\a "foobarbaz" :count 1)
(remove #\a "foobarbaz" :count 1 :from-end t)

(defparameter *v* #((a 10) (b 20) (a 30) (b 40)))

(defun verbose-first (x) (format t "Looking at ~s~%" x) (first x))

(count 'a *v* :key #'verbose-first)
(count 'a *v* :key #'verbose-first :from-end t)

(count-if #'evenp #(1 2 3 4 5))
(count-if-not #'evenp #(1 2 3 4 5))
(position-if #'digit-char-p "abcd0001")
(remove-if-not #'(lambda (x) (char= (elt x 0) #\f))
	       #("foo" "bar" "baz" "foom"))

(count-if #'evenp #((1 a) (2 b) (3 c) (4 d) (5 e)) :key #'first)
(count-if-not #'evenp #((1 a) (2 b) (3 c) (4 d) (5 e)) :key #'first)
(remove-if-not #'alpha-char-p
	      #("foo" "bar" "1baz") :key #'(lambda (x) (elt x 0)))

(remove-duplicates #(1 2 1 2 3 1 2 3 4))

(concatenate 'vector #(1 2 3) '(4 5 6))
(concatenate 'list #(1 2 3) '(4 5 6))
(concatenate 'string "abc" '(#\d #\e #\f))

(sort (vector "foo" "bar" "baz") #'string<)
(merge 'vector #(1 3 5) #(2 4 6) #'<)
(merge 'list #(1 3 5) #( 2 4 6) #'<)

(subseq "foobarbaz" 3)
(subseq "foobarbaz" 3 6)

(defparameter *z* (copy-seq "foobarbaz"))

(setf (subseq *z* 3 6) "xxx")
(setf (subseq *z* 3 6) "abcd")
(setf (subseq *z* 3 6) "xx")

(fill *z* #\x)

(position #\b "foobarbaz")
(search "bar" "foobarbaz")

(mismatch "foobarbaz" "foom")
(mismatch "foobar" "bar" :from-end t)

(every #'evenp #(1 2 3 4 5))
(some #'evenp #(1 2 3 4 5))
(notany #'evenp #(1 2 3 4 5))
(notevery #'evenp #(1 2 3 4 5))

(every #'> #(1 2 3 4) #(5 4 3 2))
(some #'> #(1 2 3 4) #(5 4 3 2))
(notany #'> #(1 2 3 4) #(5 4 3 2))
(notevery #'> #(1 2 3 4) #(5 4 3 2))

(map 'vector #'* #(1 2 3 4 5) '(10 9 8 7 6))
(map-into (make-array 1) #'+ #(1) #(2) #(3))

(reduce #'+ #(1 2 3 4 5 6 7 8 9 10))

(defparameter *h* (make-hash-table))
(gethash 'foo *h*)
(setf (gethash 'foo *h*) 'quux)
(gethash 'foo *h*)

(defun show-value (key hash-table)
  (multiple-value-bind (value present) (gethash key hash-table)
    (if present
	(format nil "Value ~a actually present." value)
	(format nil "Value ~a because key not found." value))))

(setf (gethash 'bar *h*) nil)

(show-value 'foo *h*)
(show-value 'bar *h*)
(show-value 'baz *h*)

(remhash 'foo *h*)
(clrhash *h*)

(maphash #'(lambda (k v) (format t "~a => ~a~%" k v)) *h*)
(maphash #'(lambda (k v) (when (< v 10) (remhash k *h*))) *h*)

(loop for k being the hash-keys in *h* using (hash-value v)
     do (format t "~a => ~a~%" k v))
