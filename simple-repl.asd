(defsystem "simple-repl"
  :description "Very simple REPL to use over TCP."
  :version "0.0.1"
  :author "Grolter <varedif.a.s@gmail.com>"
  :license "Apache 2.0"
  :depends-on ("simple-repl/server" "simple-repl/client"))

(defsystem "simple-repl/server"
  :description "Very simple REPL to use over TCP - server"
  :version "0.0.1"
  :author "Grolter <varedif.a.s@gmail.com>"
  :license "Apache 2.0"
  :depends-on ("usocket" "bordeaux-threads")
  :components ((:file "server")))

(defsystem "simple-repl/client"
  :description "Very simple REPL to use over TCP - client."
  :version "0.0.1"
  :author "Grolter <varedif.a.s@gmail.com>"
  :license "Apache 2.0"
  :depends-on ("usocket" "bordeaux-threads")
  :components ((:file "client")))
