(defun get-data (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          until (null line)
          ; collect line)))
          collect (parse-integer line))))

(defvar *f* "/Users/paulwakelin/coding/lisp/day1.data")
(defvar *win-size* 2)   ; i.e. 3 (counting from 1)

; (defun get-data (filename)
;   (list 00 11 22 33 44 55 66 77 88 99))


(let ((data (get-data *f*)) (prev '(0 0 0)) (total 0) (window nil)
                            prev-total this-total) 
  (do 
    ; ((i 0 (+ i 3)) )
    ((i 0 (1+ i)) )
    ((null (nth (+ i *win-size*) data)))

    (setf window (loop for tmp from i to (+ i *win-size*) collect (or (nth tmp data) 0)))
    ; (let ((prev-total (reduce '+ prev)) (this-total (reduce '+ window)))
    ;   format t "~a: ~a => ~a vs ~a~%" j window prev-total this-total)
    (setf prev-total (reduce '+ prev))
    (setf this-total (reduce '+ window))
    (if (> i 0)
      (if (> this-total prev-total) (incf total)))    
    (format t "~a: ~a = ~a " i window this-total)
    (format t "~:[no increase~;increased! (~a)~]" (> this-total prev-total) total)
    (format t "~%")
    (setf prev window))
  (format t "Total increases: ~a" total))










;; MISUNDERSTANDING (this compares each consecutive block of 3)
; (let ((data (get-data *f*)) (prev '(0 0 0)) (total 0) (window nil)
;                             prev-total this-total) 
;   (do 
;     ((i 0 (+ i 3)) )
;     ((null (nth i data)))

;     (setf window (loop for tmp from i to (+ i 2) collect (or (nth tmp data) 0)))
;     ; (let ((prev-total (reduce '+ prev)) (this-total (reduce '+ window)))
;     ;   format t "~a: ~a => ~a vs ~a~%" j window prev-total this-total)
;     (setf prev-total (reduce '+ prev))
;     (setf this-total (reduce '+ window))
;     (if (> i 0)
;       (if (> this-total prev-total) (incf total)))    
;     (format t "~a: ~a = ~a " i window this-total)
;     (format t "~:[no increase~;increased! (~a)~]" (> this-total prev-total) total)
;     (format t "~%")
;     (setf prev window))
;   (format t "Total increases: ~a" total))
