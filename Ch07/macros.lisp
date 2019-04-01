(defmacro when0 (condition &rest body)
  `(if ,condition (progn ,@body)))

(defmacro unless0 (condition &rest body)
  `(if (not ,condition) (progn ,@body)))

(dolist (x '(1 2 3)) (print x))

(dolist (x '(1 2 3)) (print x) (if (evenp x) return))

(dotimes (x 20)
  (dotimes (y 20)
    (format t "~3d " (* (+1 x) (+1 y))))
(format t "~%"))

(do ((n 0 (1+ n))
     (cur 0 next)
     (next 1 (+ cur next)))
((= 10 n) cur))

(do ((i 0 (1+ i)))
    ((>= i 4))
  (print i))

(dotimes (i 4) (print i))

(defparameter *some-future-date* 375898936811)

(do ()
    ((> (get-universal-time) *some-future-date*))
  (format t "Waiting~%")
  (sleep 60))

(loop
   (when (> (get-universal-time) *some-future-date*)
     (return))
   (format t "Waiting~%")
   (sleep 60))

(do ((nums nil) (i 1 (1+ i)))
    ((> i 10) (nreverse nums))
  (push i nums))

(loop for i from 1 to 10 collecting i)

(loop for x across "the quick brown fox jumps over the lazy dog"
     counting (find x "aeiou"))

(loop
   for i below 10
   and a = 0 then b
   and b = 1 then (+ b a)
   finally (return a))
