; (defmethod ask-question ((?question STRING) (?lower INTEGER) (?upper INTEGER))
;    (printout t ?question " (" ?lower " - " ?upper") ")
;    (bind ?answer (read))
;    (if (lexemep ?answer) then (bind ?answer (lowcase ?answer)))
;    (while (or (not (integerp ?answer))
;               (< ?answer ?lower)
;               (> ?answer ?upper)) do

;       (bind ?answer (read)))
;    ?answer)

(defmethod ask-question ((?question STRING))
	(printout t ?question)
	(bind ?answer (read))
	(if (lexemep ?answer) then (bind ?answer (lowcase ?answer)))
	(while (not (integerp ?answer)) do
		(printout t "Value must be integer." crlf)
		(printout t ?question)
		(bind ?answer (read)))
	?answer)

(defrule ask-mean-concave-point
	(initial-fact)
=>
	(bind ?input (ask-question "Mean concave point? "))
	(assert (mean-concave-point ?input))	
)

(defrule ask-worst-radius
    ?mean-concave <- (mean-concave-point ?value)
    (test (<= ?value 0.05))
=>
    (retract ?mean-concave)
	(bind ?input (ask-question "Worst radius? "))
	(assert (worst-radius ?input))	
)

; function (?nama-rule)
; while {
; 	?input <- (?nama-rule (read))
; }
; (assert ?input)

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

; Jika worst-radius <= 16.83
(defrule ask-radius-error
	?worst-radius <- (worst-radius ?value)
	(test (<= ?value 16.83))
 =>
 	(retract ?worst-radius)
    (printout t "Radius error? ")
 	(assert (radius-error (read) ) )	
)

; Jika radius error > 0.63
(defrule ask-mean-smoothness
	?radius-error <- (radius-error ?value)
	(test (> ?value 0.63))
 =>
 	(retract ?radius-error)
    (printout t "Mean smoothness? ")
 	(assert (mean-smoothness (read) ) )	
)

; Jika radius error <= 0.63
(defrule ask-worst-texture
	?radius-error <- (radius-error ?value)
	(test (<= ?value 0.63))
 =>
 	(retract ?radius-error)
    (printout t "Worst texture? ")
 	(assert (worst-texture (read) ) )	
)

; Jika mean smoothness > 0.09
(defrule mean-smoothness-high
	?mean-smoothness <- (mean-smoothness ?value)
	(test (> ?value 0.09))
=>
	(retract ?mean-smoothness)
	(assert (finish 0))
)

; Jika mean-smoothness <= 0.09
(defrule mean-smoothness-low
	?mean-smoothness <- (mean-smoothness ?value)
	(test (<= ?value 0.09))
=>
	(retract ?mean-smoothness)
	(assert (finish 1))
)

; Jika worst-radius > 16.83
(defrule ask-mean-texture
	?worst-radius <- (worst-radius ?value)
	(test (> ?value 16.83))
 =>
 	(retract ?worst-radius)
    (printout t "Mean texture? ")
 	(assert (mean-texture (read) ) )	
)

; Jika mean texture <= 16.19
(defrule mean-texture-low
	?mean-texture <- (mean-texture ?value)
	(test (<= ?value 16.19))
=>
	(printout t "Mean texture low atas")
	(retract ?mean-texture)
	(assert (finish 1))
)

; Jika mean-texture > 16.19
(defrule ask-concave-points-error
	?mean-texture <- (mean-texture ?value)
	(test (> ?value 16.19))
 =>
 	(retract ?mean-texture)
    (printout t "Concave points error? ")
 	(assert (concave-points-error (read) ) )	
)

; Jika concave points error <= 0.01
(defrule concave-points-error-low
	?concave-points-error <- (concave-points-error ?value)
	(test (<= ?value 0.01))
=>
	(retract ?concave-points-error)
	(assert (finish 0))
)

; Jika concave points error > 0.01
(defrule concave-points-error-high
	?concave-points-error <- (concave-points-error ?value)
	(test (> ?value 0.01))
=>
	(retract ?concave-points-error)
	(assert (finish 1))
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

; Jika worst texture <= 30.15
(defrule worst-texture-low
	?worst-texture <- (worst-texture ?value)
	(test (<= ?value 30.15))
=>
	(retract ?worst-texture)
	(assert (finish 1))
)

; Jika worst-texture > 30.15
(defrule ask-worst-area
	?worst-texture <- (worst-texture ?value)
	(test (> ?value 16.19))
 =>
 	(retract ?worst-texture)
    (printout t "Worst area? ")
 	(assert (worst-area (read) ) )	
)

; Jika worst area <= 641.60
(defrule worst-area-low
	?worst-area <- (worst-area ?value)
	(test (<= ?value 641.60))
=>
	(retract ?worst-area)
	(assert (finish 1))
)

; Jika worst-area > 641.60
(defrule ask-worst-area-1
	?worst-area <- (worst-area ?value)
	(test (> ?value 641.60))
 =>
 	(retract ?worst-area)
    (printout t "Mean radius? ")
 	(assert (mean-radius (read) ) )	
)

; Jika mean radius <= 13.45
(defrule ask-mean-radius-1
	?mean-radius <- (mean-radius ?value)
	(test (<= ?value 13.45))
=>
    (printout t "Mean texture? ")
 	(assert (mean-texture (read) ) )	
)

; Jika mean-radius > 13.45
(defrule mean-radius-high
	?mean-radius <- (mean-radius ?value)
	(test (> ?value 13.45))
 =>
 	(retract ?mean-radius)
	(assert (finish 1))
)

; Jika mean texture > 28.79
(defrule mean-texture-high
	?mean-radius <- (mean-radius ?value-1)
	(test (<= ?value-1 13.45))
	?mean-texture <- (mean-texture ?value-2)
	(test (> ?value-2 28.79))
=>
	(printout t "Mean texture high ")
	(retract ?mean-radius)
	(retract ?mean-texture)
	(assert (finish 1))
)

; Jika mean-texture <= 28.79
(defrule mean-texture-low-1
	?mean-radius <- (mean-radius ?value-1)
	(test (<= ?value-1 13.45))
	?mean-texture <- (mean-texture ?value-2)
	(test (<= ?value-2 28.79))
=>
	(printout t "Mean texture low ")
	(retract ?mean-radius)
	(retract ?mean-texture)
	(assert (finish 0))
)