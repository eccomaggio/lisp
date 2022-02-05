(defvar *f* "/Users/paulwakelin/coding/lisp/day3.data")
(defvar *bit-len* 12)
; (defvar *test-data* (list "00100" "11110" "10110" "10111" "10101" "01111" "00111" "11100" "10000" "11001" "00010" "01010"))
; (if (not (null *test-data*)) (setf *bit-len* (length (first *test-data*))))

(defun get-data (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          until (null line)
          ; do (format t "~a~%" line) 
          collect line)))


; (defun challenge-a (data)
;   (let (
;         ; (data (get-data *f*)) 
;         (count 0) 
;         (totals (make-list *bit-len* :initial-element 0)) 
;         (gamma (make-list *bit-len* :initial-element 0)) 
;         (epsilon (make-list *bit-len* :initial-element 0))) 

;     (dolist (line data)
;       (incf count)
;       (dotimes (i *bit-len*)
;         (let ((this-digit (char line i)))
;           (if (string= this-digit "1")
;             (incf (nth i totals)))))
;       (format t "~a ~a (~a)~%" count totals line))

;     (dotimes (i *bit-len*) 
;       (setf (nth i gamma) (if (> (nth i totals) 500) 1 0))
;       (setf (nth i epsilon) (if (= (nth i gamma) 0) 1 0))
;       )

;     (setf 
;       gamma (parse-integer (format nil "~{~a~}" gamma) :radix 2) 
;       epsilon (parse-integer (format nil "~{~a~}" epsilon) :radix 2))

;     (format t "gamma: ~b (~a), epsilon: ~b (~a)~%" gamma gamma epsilon epsilon)
;     (format t "multiplied together = ~a~%~%" (* gamma epsilon))
;     ))




(defun life-support (values mode &optional (count 0))
  (let (
        (tally-0s 0) 
        (tally-1s 0)
        (filter-for "1")
        filtered-vals
        (result 0)
        (tmp 0)
        )

    ;; FIND MOST PREVALENT VALUE (O or 1)
    (dolist (line values)
      (if (string= (char line count) filter-for)
        (incf tally-1s)
        (incf tally-0s)))

    (if (= tally-0s tally-1s) 
      (setf filter-for mode)
      (setf filter-for (cond 
                         ((string= mode "1") (if (> tally-0s tally-1s) "0" "1"))
                         ((string= mode "0") (if (< tally-0s tally-1s) "0" "1")) 
                         ))
      )

    ;; REDUCE RESULTS
    (format t "~%Count: ~a, filter for ~a ([mode ~a] 0s ~a, 1s: ~a, bit-len: ~a)~%" count filter-for mode tally-0s tally-1s *bit-len*)
    (dolist (line values)
      (if (string= (char line count) filter-for)
       (progn
        (setf filtered-vals (append filtered-vals (list line))) 
         ; (format t "~2d.~3d: filter ~a > ~a~%" count tmp filter-for (last filtered-vals))
         (format t "~3d: ~a~%" tmp (last filtered-vals))
         (incf tmp)) 
        )
      )
    ; (return-from life-support filter-for)

    ; (if (= count (- *bit-len* 1))
    (if (or (= count (- *bit-len* 1)) (= (length filtered-vals) 1))
      (return-from life-support filtered-vals)
      (life-support filtered-vals mode (+ 1 count)))
    ))

(defun challenge-b (data)
  (let (oxygen co2)
    (setf oxygen (life-support data "1"))    
    (setf co2 (life-support data "0"))    
    (setf oxygen (parse-integer (format nil "~{~a~}" oxygen) :radix 2))
    (setf co2 (parse-integer (format nil "~{~a~}" co2) :radix 2))

    (format t "oxygen: ~a (~b), CO2: ~a (~b)~%" oxygen oxygen co2 co2)
    (format t "multiplied together = ~a~%" (* oxygen co2))
    ))





(let ((data (get-data *f*)))
; (let ((data *test-data*))
  ; (challenge-a data)
  (challenge-b data)
  )

; EXPLANATION
; 1st challenge:

; by col, choose the most prevalent bit

; 2nd:
; oxygen:
; by col, choose only numbers with most prevalent bit
; (if equal, choose numbers with 1)

; CO2:
; by col, choose only numbers with least prev bit
; (if equal, choose numbers with 0)
