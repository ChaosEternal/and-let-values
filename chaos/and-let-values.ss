;; Copyright 2023 Jun Sheng
;;
;; Licensed under the Apache License, Version 2.0 (the "License");
;; you may not use this file except in compliance with the License.
;; You may obtain a copy of the License at
;; 
;;     https://www.apache.org/licenses/LICENSE-2.0
;; 
;; Unless required by applicable law or agreed to in writing, software
;; distributed under the License is distributed on an "AS IS" BASIS,
;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;; See the License for the specific language governing permissions and
;; limitations under the License.
;;

(library (chaos and-let-values)
  (export and-let*-values
	  and-let*-values-check)
  (import (rnrs base)
	  (rnrs (6)))

  (define-syntax and-let*-values
    (lambda (stx)
      (syntax-case stx (else)
	((_ (?bind0 ?bind1 ...) ?body0 ... (else ?expr0 ...))
	 (syntax-case #'?bind0 ()
	   (((?b0 ?b1 ...) ?exp)
	    (identifier? #'?b0)
	    #`(let-values (?bind0)
		(if ?b0
		    (and-let*-values (?bind1 ...) ?body0 ...)
		    (begin ?expr0 ...))))))
	((_ () ?body0 ... (else ?expr0 ...))
	 #'(begin ?body0 ...))
	((_ (?bind0 ...) ?body0 ...)
	 #'(and-let*-values (?bind0 ...) ?body0 ... (else #f))))))

  (define-syntax and-let*-values-check
    (lambda (stx)
      (syntax-case stx (else)
	((kw (?bind0 ?bind1 ...) ?body0 ... (else ?expr0 ...))
	 (syntax-case #'?bind0 ()
	   (((?b0 ?b1 ...) ?exp)
	    (let* ((?check-b0 (car (generate-temporaries (list #'?b0)))))
	      #`(let-values (((#,?check-b0 ?b1 ...) ?exp))
		  (if (equal? #,?check-b0 ?b0)
		      (kw (?bind1 ...) ?body0 ...)
		      (begin ?expr0 ...)))))))
	((_ () ?body0 ... (else ?expr0 ...))
	 #'(begin ?body0 ...))
	((kw (?bind0 ...) ?body0 ...)
	 #'(kw (?bind0 ...) ?body0 ... (else #f)))))))
