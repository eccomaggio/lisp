(defun get-data (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          until (null line)
          ; collect line)))
          collect (parse-integer line))))

(defvar *f* "/Users/paulwakelin/coding/lisp/day1.data")


;; one way to read line-by-line from a file
; (with-open-file (stream *f*)
;   (loop for line = (read-line stream nil)
;         until (null line)
;         do (format t "using 'loop': ~a," line)))

;; another way to read line-by-line from file
; (with-open-file (stream *f*)
;   (do ((line (read-line stream nil)
;              (read-line stream nil)))
;     ((null line))
;     (format t "using 'do': ~a_" line)))

; (let ((paul (get-data *f*)))
;       (format t "~a~%" paul))

; (let ((data '(2 5 7 3 2 4 6 10)) (prev -1) (total 0) (i 0)) 
(let ((data (get-data *f*)) (prev -1) (total 0) (i 0)) 
  (dolist (x data) 
    (if (> i 0)
      (if (> x prev) (incf total)))
    ; (format t "~a=>~a~%" x (> x prev))
    (format t "~a=>~:[no increase~;increased! (~a)~]~%" x (> x prev) total)
    (incf i)
    (setf prev x))
  (format t "Total increases: ~a" total))
