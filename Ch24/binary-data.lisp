;binary-data.lisp

(in-package #:binary-data)

(defun as-keyword (sym)
  (intern (string sym) :keyword))

(defun slot->defclass-slot (spec)
  (let ((name (first spec)))
    `(,name :initarg ,(as-keyword name) :accessor ,name)))

(defgeneric read-value (type stream &key)
  (:documentation "Read a value of the given type from the stream."))

(defun slot->read-value (spec stream)
  (destructuring-bind (name (type &rest args)) (normalize-slot-spec spec)
    `(setf ,name (read-value ',type ,stream ,@args))))

(defun normalize-slot-spec (spec)
  (list (first spec) (mklist (second spec))))

(defun mklist (x)
  (if (listp x) x  (list x)))

(defgeneric write-value (type stream value &key)
  (:documentation "Write a value as the given type to the stream."))

(defun slot->write-value (spec stream)
  (destructuring-bind (name (type &rest args)) (normalize-slot-spec spec)
    `(write-value ',type ,stream ,name ,@args)))
