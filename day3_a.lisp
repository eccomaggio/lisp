(defvar *f* "/Users/paulwakelin/coding/lisp/day3.data")

(defun get-data (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          until (null line)
          ; do (format t "~a~%" line) 
          collect line)))


(let (
      (data (get-data *f*)) 
      (count 0) 
      (totals (make-list 12 :initial-element 0)) 
      (gamma (make-list 12 :initial-element 0)) 
      (epsilon (make-list 12 :initial-element 0))) 

  (dolist (line data)
    (incf count)
    (dotimes (i 12)
      (let ((this-digit (char line i)))
        (if (string= this-digit "1")
          (incf (nth i totals)))))
    (format t "~a ~a (~a)~%" count totals line))

  (dotimes (i 12) 
    (setf (nth i gamma) (if (> (nth i totals) 500) 1 0))
    (setf (nth i epsilon) (if (= (nth i gamma) 0) 1 0))
    )

  ; (setf gamma (parse-integer (format nil "~{~a~}" gamma) :radix 2))
  ; (setf epsilon (parse-integer (format nil "~{~a~}" epsilon) :radix 2))
  (setf 
    gamma (parse-integer (format nil "~{~a~}" gamma) :radix 2) 
    epsilon (parse-integer (format nil "~{~a~}" epsilon) :radix 2))

  (format t "gamma: ~b (~a), epsilon: ~b (~a)~%" gamma gamma epsilon epsilon)
  (format t "multiplied together = ~a~%" (* gamma epsilon))
  )
