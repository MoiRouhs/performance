(ns bs.core
  (:require [quil.core :as q]
            [quil.middleware :as m]))

(defn setup []
  (q/frame-rate 30))

(defn malevich [mtam mspc]
  (doseq [x (range 0 (/ mtam mspc))]
    (q/push-style)
       (q/stroke-weight (/ mspc 1))
       ;;(q/rect-mode :radius)
       (q/with-translation [(/ (q/width) 2) (/ (q/height) 2)]
        ;;(q/with-rotation [(q/radians (q/cos (* (q/frame-count) (* 1e-2 x))))] 
        (q/with-rotation [(q/radians (* (q/cos (* (q/frame-count) (* 7e-3 x))) 0))]  
        ;;(q/with-rotation [(q/radians (* (q/frame-count) (* 1.1 x)))]  
         (q/rect (+ (/ mtam -2) (* (/ mspc 2) x)) (+ (/ mtam -2) (* (/ mspc 2) x)) (- mtam (* mspc x)) (- mtam (* mspc x)))))
    (q/pop-style)))

(defn kazimir [m ktam kspc]
  (doseq [x (range 0 (+ (/ (q/width) ktam) 1))]
    (doseq [y (range 0 (+ (/ (q/height) ktam) 1))]
      (q/with-translation [(* ktam x) (* ktam y)]
        (m ktam kspc)))))

(def tam 650)
(def spc 40)

(defn actualizar [std]
  (let [lim 5 vel 0.10]
  (cond 
    (> spc lim) (def spc (- spc vel))
    (< spc lim) (def spc (+ spc vel)))))

(defn draw [std]
  (q/background 255)
  (malevich tam spc))




(q/defsketch bs
  :title "Cuadro Negro"
  :size [(q/screen-width) (q/screen-height)]
  :setup setup
  :update actualizar
  :draw draw
  :features [:present]
  :middleware [m/fun-mode])
