(import (chaos and-let-values))

(and-let*-values-check
 [(('("t12" 13 #t) c1)
   (values
    (and-let*-values
     (((t11 t12 t13 ) (values #t "t12" 13))
      ((t21 t22) (values #t #t)))
     (list t12 t13 t22))
    ;;=> ("t12" 13 #t)
    "testcase1"))
  ((#f c2)
   (values 
    (and-let*-values
     (((t11 t12 t13 ) (values #f "t12" 13))
      ((t21 t22) (values #t #t)))
     (list t12 t13 t22))
    ;;=> #f
    "testcase2"))
  ((#f c3)
   (values
    (and-let*-values-check
     (((12 t11) (values 12 "foo"))
      ((12 t21) (values 13 "bar")))
     (cons t11 t21))
    ;;=> #f
    "testcase3"))
  (('("foo" "bar" "baz" "t32baz") c4)
   (values
    (and-let*-values-check
	  ((('ok t11) (values 'ok "foo"))
	   (('ok t21) (values 'ok "bar"))
	   (('ok t31 t32) (values 'ok "baz" "t32baz")))
	  (list t11 t21 t31 t32))
    ;;=> ("foo" "bar" "baz" "t32baz")
    "testcase4"))
  (('("foo" . "bar") c5)
   (values
    (and-let*-values-check
     ((('ok t11) (values 'ok "foo"))
      (('ok t21) (values 'ok "bar")))
     (cons t11 t21))
    ;;=> ("foo" . "bar")
    "testcase5"))
  (('("foo" . "bar") c6)
   (values
    (and-let*-values-check
     (((#f t11) (values #f "foo"))
      ((#f t21) (values #f "bar")))
     (cons t11 t21))
    ;;=> ("foo" . "bar")
    "testcase6"))
  (('("foo" . "bar") c7)
   (values
    (let ((va 1)
	  (vb 2))
	(and-let*-values-check
	 (((va t11) (values 1 "foo"))
	  ((vb t21) (values 2 "bar")))
	 (cons t11 t21)))
    ;;=> ("foo" . "bar")
    "testcase7"))
  (('("foo" . "bar") c8)
   (values
    (let ((va 1))
      (and-let*-values-check
	 (((va t11) (values 1 "foo"))
	  ((t11 t21) (values "foo" "bar")))
	 (cons t11 t21)))
    ;;=> ("foo" . "bar")
    "testcase8"))]
 (format (current-output-port) "All these tests:\n ~s \n are finished successfully \n" 
	 (list c1 c2 c3 c4 c5 c6)))
