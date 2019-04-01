(defun test-+0 ()
  (and
   (= (+ 1 2) 3)
   (= (+ 1 2 3) 6)
   (= (+ -1 -3) -4)))

(defun test-+1 ()
  (format t "~:[FAIL~;PASS~] ... ~a~%" (= (+ 1 2) 3) '(= (+ 1 2) 3))
  (format t "~:[FAIL~;PASS~] ... ~a~%" (= (+ 1 2 3) 6) '(= (+ 1 2 3) 6))
  (format t "~:[FAIL~;PASS~] ... ~a~%" (= (+ -1 -3) -4) '(= (+ -1 -3) -4)))

(defun report-result0 (result form)
  (format t "~:[FAIL~;pass~] ... ~a~%" result form))

(defun test-+2 ()
  (report-result0 (= (+ 1 2) 3) '(= (+ 1 2) 3))
  (report-result0 (= (+ 1 2 3) 6) '(= (+ 1 2 3) 6))
  (report-result0 (= (+ -1 -3) -4) '(= (+ -1 -3) -4)))

(defmacro check0 (form)
  `(report-result0 ,form ',form))

(defun test-+3 ()
  (check0 (= (+ 1 2) 3))
  (check0 (= (+ 1 2 3) 6))
  (check0 (= (+ -1 -3) -4)))

(defmacro check1 (&body forms)
  `(progn
     ,@(loop for f in forms collect `(report-result0 ,f ',f))))

(defun test-+4 ()
  (check1 (= (+ 1 2) 3)
	  (= (+ 1 2 3) 6)
	  (= (+ -1 -3) -4)))

(defun report-result1 (result form)
  (format t "~:[FAIL~;pass~] ... ~a~%" result form)
  result)

(defmacro with-gensyms ((&rest names) &body body)
  `(let ,(loop for n in names collect `(,n (gensym)))
     ,@body))

(defmacro combine-results (&body forms)
  (with-gensyms (result)
    `(let ((,result t))
       ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
       ,result)))

(defmacro check2 (&body forms)
  `(combine-results
     ,@(loop for f in forms collect `(report-result1 ,f ',f))))

(defun test-+5 ()
  (check2 (= (+ 1 2) 3)
	  (= (+ 1 2 3) 6)
	  (= (+ -1 -3) -4)))

(defun test-*0 ()
  (check2 (= (* 2 2) 4)
	  (= (* 3 5) 15)))

(defun test-arithmetic0 ()
  (combine-results
    (test-+5)
    (test-*0)))

(defvar *test-name* nil)

(defun report-result2 (result form)
  (format t "~:[FAIL~;pass~] ... ~a: ~a~%" result *test-name* form)
  result)

(defmacro check3 (&body forms)
  `(combine-results
     ,@(loop for f in forms collect `(report-result2 ,f ',f))))

(defun test-+6 ()
  (let ((*test-name* 'test-+))
    (check3 (= (+ 1 2) 3)
	    (= (+ 1 2 3) 6)
	    (= (+ -1 -3) -4))))

(defun test-*1 ()
  (let ((*test-name* 'test-*))
    (check3 (= (* 2 2) 4)
	    (= (* 3 5) 15))))

(defun test-arithmetic1 ()
  (combine-results
    (test-+6)
    (test-*1)))

(defmacro deftest (name parameters &body body)
  `(defun ,name ,parameters
     (let ((*test-name* (append *test-name* (list ',name))))
       ,@body)))

(deftest test-+7 ()
  (check3
    (= (+ 1 2) 3)
    (= (+ 1 2 3) 6)
    (= (+ -1 -3) -4)))

(deftest test-*2 ()
  (check3 (= (* 2 2) 4)
	  (= (* 3 5) 15))))

(deftest test-arithmetic2 ()
(combine-results
  (test-+7)
  (test-*2)))

(deftest test-math ()
(test-arithmetic2))

;;------ Final Code ------

(defvar *test-name* nil)

(defmacro deftest (name parameters &body body)
"Define a test function. Within a test function we can call
other test functions or use 'check' to run individual test cases."
`(defun ,name ,parameters
   (let ((*test-name* (append *test-name* (list ',name))))
     ,@body)))

(defmacro check (&body forms)
"Run each expression in 'forms' as a test case."
`(combine-results
   ,@(loop for f in forms collect `(report-result ,f ',f))))

(defmacro combine-results (&body forms)
"Combine the results (as booleans) of evaluating 'forms' in order."
(with-gensyms (result)
  `(let ((,result t))
     ,@(loop for f in forms collect `(unless ,f (setf ,result nil)))
     ,result)))

(defun report-result (result form)
"Report the results of a single test case. Called by 'check'."
(format t "~:[FAIL~;pass~] ... ~a: ~a~%" result *test-name* form)
result)
