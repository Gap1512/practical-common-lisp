(defun hello-world () (format t "hello,world"))

(defun verbose-sum (x y)
  "Sum any two numbers after printing a message"
  (format t "Summing ~d and ~d.~%" x y)
  (+ x y))

(defun foo0 (a b &optional c d) (list a b c d))

(defun foo1 (a &optional (b 10)) (list a b))

(defun make-rectangle (width &optional (height width)) (list width height))

(defun foo2 (a b &optional (c 3 c-supplied-p))
  (list a b c c-supplied-p))

;; (defun format (stream string &rest values)...)
;; (defun + (&rest numbers)...)

(defun foo3 (&key a b c) (list a b c))

(defun foo4 (&key (a 0) (b 0 b-supplied-p) (c (+ a b)))
  (list a b c b-supplied-p))

(defun foo5 (&key ((:apple a)) ((:box b) 0) ((:charlie c) 0 c-supplied-p))
  (list a b c c-supplied-p))

;; (defun foo6 (x &optional y &key z) (list x y z))

(defun foo7 (&rest rest &key a b c) (list rest a b c))

(defun foo8 (n)
  (dotimes (i 10)
    (dotimes (j 10)
      (when (> (* i j) n)
	(return-from foo8 (list i j))))))

(defun plot (fn min max step)
  (loop for i from min to max by step do
       (loop repeat (funcall fn i) do (format t "*"))
       (format t "~%")))
