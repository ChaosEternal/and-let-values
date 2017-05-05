(library (chaos and-let-values)
  (export and-let*-values
	  and-let*-values-check)
  (import (rnrs base)
	  (rnrs (6)))

  (define-syntax and-let*-values
    (lambda (stx)
      (syntax-case stx ()
	((_ (?bind0 ?bind1 ...) ?body0 ...)
	 (syntax-case #'?bind0 ()
	   (((?b0 ?b1 ...) ?exp)
	    (identifier? #'?b0)
	    #`(let-values (?bind0)
		(and ?b0
		     (and-let*-values (?bind1 ...) ?body0 ...))))))
	((_ () ?body0 ...)
	 #'(begin ?body0 ...)))))

  (define-syntax and-let*-values-check
    (lambda (stx)
      (syntax-case stx ()
	((kw (?bind0 ?bind1 ...) ?body0 ...)
	 (syntax-case #'?bind0 ()
	   (((?b0 ?b1 ...) ?exp)
	    (let* ((?check-b0 (car (generate-temporaries (list #'?b0)))))
	      #`(let-values (((#,?check-b0 ?b1 ...) ?exp))
		  (and (equal? #,?check-b0 ?b0)
		       (kw (?bind1 ...) ?body0 ...)))))))
	((_ () ?body0 ...)
	 #'(begin ?body0 ...))))))
