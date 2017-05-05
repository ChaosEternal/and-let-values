(import (chaos and-let-values))



(display 
 (and-let*-values
  (((t11 t12 t13 ) (values #t "t12" 13))
   ((t21 t22) (values #t #t)))
  (list (list t12 t13 t22) "testcase1")))

(newline)
(display 
 (and-let*-values
  (((t11 t12 t13 ) (values #f "t12" 13))
   ((t21 t22) (values #t #t)))
  (list (list t12 t13 t22) "testcase2")))
(newline)


(display 
 (and-let*-values-check
  (((12 t11) (values 12 "haha"))
   ((12 t21) (values 13 "hehe")))
  (cons t11 t21));;=> #f
 )
(display "testcase3\n")

(display (and-let*-values-check
	  ((('ok t11) (values 'ok "foo"))
	   (('ok t21) (values 'ok "bar"))
	   (('ok t31 t32) (values 'ok "baz" "t32baz")))
	  (list t11 t21 t31 t32)))
(display "testcase4\n")

(display 
 (and-let*-values-check
  ((('ok t11) (values 'ok "haha"))
   (('ok t21) (values 'ok "hehe")))
  (cons t11 t21));;=> ("haha" . "hehe")
 )
(display "testcase5\n")
