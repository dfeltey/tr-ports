
(module utils typed/racket
  (provide shuffle-list)
  (: shuffle-list (All (a) ((Listof a) Natural -> (Listof a))))
  (define shuffle-list 
   (lambda (l c)
     (if (zero? c)
	 l
	 (let-values: ([([a :  (Listof a)] [b : (Listof a)])
		       (let ([half (floor (/ (length l) 2))])
			 (values
			  (let: loop : (Listof a) ([l : (Listof a) l][n : Natural half])
			    (if (zero? n)
				null
				(cons (car l) (loop (cdr l) (sub1 n)))))
			  (list-tail l half)))])
	   (shuffle-list
	    (let: loop : (Listof a)  ([a : (Listof a) a][b : (Listof a) b][l : (Listof a) null])
	      (cond
	       [(null? a) (append (reverse b) l)]
	       [(null? b) (append (reverse a) l)]
	       [(zero? (random 2))
		(loop (cdr a) b (cons (car a) l))]
	       [else
		(loop a (cdr b) (cons (car b) l))]))
	    (sub1 c)))))))
