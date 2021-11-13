(defrule ask-mean-concave-point
	(initial-fact)
	=>
  (printout t "Mean concave point? ")
	(assert (mean-concave-point (read) ) )	
)

(defrule ask-worst-radius
	?mean-concave <- (mean-concave-point ?value)
	(test (<= ?value 0.05))
 =>
 	(retract ?mean-concave)
  (printout t "Worst radius? ")
 	(assert (worst-radius (read) ) )	
)

(defrule ask-worst-perimeter
	?mean-concave <- (mean-concave-point ?value)
	(test (> ?value 0.05))
 =>
 	(retract ?mean-concave)
    (printout t "Worst perimeter? ")
 	(assert (worst-perimeter (read) ) )	
)

; Jika worst perimeter > 114.45
(defrule ask-worst-texture-1
	?worstPerimeter <- (worst-perimeter ?value)
	(test (> ?value 114.45))
 =>
 	(retract ?worstPerimeter)
 	(assert (finish 0)) ; completed state	
)

; Jika worst perimeter <= 114.45
(defrule ask-worst-texture-2
	?worstPerimeter <- (worst-perimeter ?value)
	(test (<= ?value 114.45))
 =>
 	(retract ?worstPerimeter)
    (printout t "Worst texture? ")
 	(assert (worst-texture (read) ) )	
)

; Jika worst texture < 25.65
(defrule ask-worst-concave-points
	?worstTexture <- (worst-texture ?value)
	(test (<= ?value 25.65))
 =>
 	(retract ?worstTexture)
    (printout t "Worst concave points? ")
 	(assert (worst-concave-points (read) ) )	
)

; Jika worst concave points <= 0.17
(defrule bad-worst-concave-points
	?worstConcavePoints <- (worst-concave-points ?value)
	(test (<= ?value 0.17))
 =>
 	(retract ?worstConcavePoints)
 	(assert (finish 1) )	
)

; Jika worst concave points > 0.17
(defrule good-worst-concave-points
	?worstConcavePoints <- (worst-concave-points ?value)
	(test (> ?value 0.17))
 =>
 	(retract ?worstConcavePoints)
 	(assert (finish 0) )	
)

; Jika worst texture > 25.65
(defrule ask-perimeter-error
	?worstTexture <- (worst-texture ?value)
	(test (> ?value 25.65))
 =>
 	(retract ?worstTexture)
    (printout t "Perimeter error? ")
 	(assert (perimeter-error (read) ) )	
)

; Jika perimeter error <= 1.56
(defrule ask-mean-radius
	?perimeterError <- (perimeter-error ?value)
	(test (<= ?value 1.56))
 =>
 	(retract ?perimeterError)
    (printout t "Mean radius? ")
 	(assert (mean-radius (read) ) )	
)

; Jika perimeter error > 1.56
(defrule perimeter-error-completed
	?perimeterError <- (perimeter-error ?value)
	(test (> ?value 1.56))
 =>
 	(retract ?perimeterError)
 	(assert (finish 0) )	
)

; Jika mean radius <= 13.34
(defrule good-mean-radius
	?meanRadius <- (mean-radius ?value)
	(test (<= ?value 13.34))
 =>
 	(retract ?meanRadius)
 	(assert (finish 0) )	
)

; Jika mean radius <= 13.34
(defrule bad-mean-radius
	?meanRadius <- (mean-radius ?value)
	(test (> ?value 13.34))
 =>
 	(retract ?meanRadius)
 	(assert (finish 1) )	
)


(defrule bad-completed-state 
	?complete <- (finish ?value)
	(finish 1)
	=>
	 	(retract ?complete)
	  (printout t "Hasil prediksi = Terprediksi kanker payudara" crlf)
)

(defrule good-completed-state
	?complete <- (finish ?value)
	(finish 0)
	=>
		 	(retract ?complete)
	  (printout t "Hasil prediksi = Terprediksi tidak terkena kanker payudara" crlf)
)