(defun get-data (filename)
  (with-open-file (stream filename)
    (loop for line = (read-line stream nil)
          until (null line)
          collect line)))

(defvar *f* "/Users/paulwakelin/coding/lisp/day2.data")



(let ((data (get-data *f*)) (hor-pos 0) (ver-pos 0) (aim 0) command amount) 
  (dolist (line data)
    (setf command (subseq line 0 (search " " line))) 
    (setf amount (parse-integer (subseq line (search " " line))))
    (cond 
      ((string-equal command "down") (incf aim amount))
      ((string-equal command "up") (incf aim (- amount)))
      ((string-equal command "forward") (progn (incf hor-pos amount) (incf ver-pos (* aim amount))))
      )
    (format t "~a,~a~%" command amount))
  (format t "~% horizontal: ~a, vertical: ~a, HxV=~a~%" hor-pos ver-pos (* hor-pos ver-pos))
  )
