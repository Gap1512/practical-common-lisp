(defparameter *set* ())
(adjoin 1 *set*)
(setf *set* (adjoin 1 *set*))
(pushnew 2 *set*)
(pushnew 2 *set*)

(subsetp '(3 2 1) '(1 2 3 4))
(subsetp '(1 2 3 4) '(3 2 1))

(assoc 'a '((a . 1) (b . 2) (c . 3)))
(assoc 'c '((a . 1) (b . 2) (c . 3)))
(assoc 'd '((a . 1) (b . 2) (c . 3)))

(cdr (assoc 'a '((a . 1) (b . 2) (c . 3))))

(assoc "a" '(("a" . 1) ("b" . 2) ("c" . 3)) :test #'string=)
(assoc "a" '(("a" . 1) ("b" . 2) ("c" . 3)))
(assoc 'a '((a . 10) (a . 1) (b . 2) (c . 3)))

(pairlis '(a b c) '(1 2 3))

(defparameter *plist* ())
(setf (getf *plist* :a) 1)
(setf (getf *plist* :a) 2)
(remf *plist* :a)

(defun process-properties (plist keys)
  (loop while plist do
       (multiple-value-bind (key value tail) (get-properties plist keys)
	 (when key (process-properties key value))
	 (setf plist (cddr tail)))))

(setf (get 'some-symbol 'my-key) "information")

(destructuring-bind (x y z) (list 1 2 3)
  (list :x x :y y :z z))
(destructuring-bind (x y z) (list 1 (list 2 20) 3)
  (list :x x :y y :z z))
(destructuring-bind (x (y1 y2) z) (list 1 (list 2 20) 3)
  (list :x x :y1 y1 :y2 y2 :z z))
(destructuring-bind (x (y1 &optional y2) z) (list 1 (list 2 20) 3)
  (list :x x :y1 y1 :y2 y2 :z z))
(destructuring-bind (x (y1 &optional y2) z) (list 1 (list 2) 3)
  (list :x x :y1 y1 :y2 y2 :z z))
(destructuring-bind (&key x y z) (list :x 1 :y 2 :z 3)
  (list :x x :y y :z z))
(destructuring-bind (&key x y z) (list :z 1 :y 2 :x 3)
  (list :x x :y y :z z))
(destructuring-bind (&whole whole &key x y z) (list :z 1 :y 2 :x 3)
  (list :x x :y y :z z :whole whole))
