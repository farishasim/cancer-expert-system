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