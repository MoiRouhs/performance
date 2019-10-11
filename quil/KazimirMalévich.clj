(ns bs.core
  (:require [quil.core :as q]
            [quil.middleware :as m]))

(defn malevich [mtam mspc gros]
  (doseq [x (range 0 (/ mtam mspc))]
    (q/push-style)
      ;;(if (even? x)(q/fill 0)(q/fill 255))
       (q/stroke-weight (/ mspc 1.2))
        ;;(q/rect-mode :radius)
        ;;(q/with-rotation [(q/radians (q/cos (* (q/frame-count) (* 1e-2 x))))] 
        (q/with-rotation [(q/radians (* (q/cos (* (q/frame-count) (* 7e-3 x))) gros))]  
        ;;(q/with-rotation [(q/radians (* (q/frame-count) (* 1.1 x)))]  
         (q/rect (+ (/ mtam -2) (* (/ mspc 2) x)) (+ (/ mtam -2) (* (/ mspc 2) x)) (- mtam (* mspc x)) (- mtam (* mspc x))))
    (q/pop-style)))

(defn kazimir [m ktam kspc gros]
  (doseq [x (range 0 (+ (/ (q/width) ktam) 1))]
    (doseq [y (range 0 (+ (/ (q/height) ktam) 1))]
      (q/with-translation [(* ktam x) (* ktam y)]
        (m ktam kspc gros)))))

(defn setup []
  (q/frame-rate 30))

(def tam 650)
(def spc 40)
(def gros 2)
(def velg 0.08)

(defn actualizar [std]
  (let [lim 5 vel 0.10]
  (cond 
    (> spc lim) (def spc (- spc vel))
    (< spc lim) (def spc (+ spc vel))))

  (let [limt 700 velt 3]
  (cond 
    (> tam limt) (def tam (- tam velt))
    (< tam limt) (def tam (+ tam velt)))) 
  
  (let [limiteI 0 limiteS 0]
    (if (or (>= gros limiteS)(<= gros limiteI))
      (def velg (* velg -1)))
    (def gros (+ gros velg))))

(defn draw [std]
  (q/background 255)

  (q/with-translation [(/ (q/width) 2) (/ (q/height) 2)]
    (malevich tam spc)))




(q/defsketch bs
  :title "Cuadro Negro"
  :size [(q/screen-width) (q/screen-height)]
  :setup setup
  :update actualizar
  :draw draw
  :features [:present]
  :middleware [m/fun-mode])
