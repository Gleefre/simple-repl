(defpackage #:simple-repl/server
  (:use #:cl)
  (:export #:run
           #:run-in-current-thread
           #:*close*)
  (:local-nicknames (#:bt #:bordeaux-threads)))

(in-package #:simple-repl/server)

(defvar *close*)

(defun repl (connection &aux (stream (usocket:socket-stream connection)))
  (unwind-protect
       (let ((*close* nil)
             (*standard-input* stream)
             (*standard-output* stream)
             (*package* (find-package :cl-user))
             cl:* cl:** cl:*** cl:+ cl:++ cl:+++ cl:/ cl:// cl:/// cl:-)
         (loop :until *close*
               :do (format t "~&* ")
                   (force-output)
                   (let ((- (read))
                         (values (gensym)))
                     (shiftf +++ ++ + -)
                     (eval
                      `(let ((,values (multiple-value-list ,-)))
                         (shiftf *** ** * (first ,values))
                         (shiftf /// // / ,values)
                         (format t "~&~{~s~%~}" ,values)))
                     (force-output))))
    (usocket:socket-close connection)))

(defun run-in-current-thread (port &optional (host "localhost"))
  (let* ((socket (usocket:socket-listen host port :reuse-address t))
         (connection (usocket:socket-accept socket :element-type 'character)))
    (unwind-protect
         (repl connection)
      (usocket:socket-close socket))))

(defun run (port &optional (host "localhost"))
  (bt:make-thread
   (lambda ()
     (run-in-current-thread port host))
   :name (format nil "simple repl [~a:~a]" host port)))
