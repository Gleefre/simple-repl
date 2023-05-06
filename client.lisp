(defpackage #:simple-repl/client
  (:use #:cl)
  (:export #:run)
  (:local-nicknames (#:bt #:bordeaux-threads)))

(in-package #:simple-repl/client)

(defun redirect (in out)
  (loop :for char = (read-char in nil :eof)
        :until (or (eq char :eof)
                   (not (open-stream-p out)))
        :do (handler-case
                (progn
                  (write-char char out)
                  (force-output out))
              (error (c)
                (declare (ignore c))
                (return)))))

(defun run (port &optional (host "localhost"))
  (usocket:with-client-socket (socket stream host port :element-type 'character)
    (bt:make-thread
     (lambda ()
       (redirect stream *standard-output*))
     :name "simple repl - output redirect")
    (redirect *standard-input* stream)))
