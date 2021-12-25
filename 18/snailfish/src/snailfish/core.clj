(ns snailfish.core
  (:require [clojure.core.match :refer [match]])
  (:require [instaparse.core :as insta]))

(def parser
  (insta/parser (clojure.java.io/resource "parser.bnf")))

(defn to-s [expr]
  (match expr
         [:num n] n
         [:expr "[" a "," b "]"] (list (to-s a) (to-s b))))

(defn parse [line] (to-s (parser line)))

(defn split [x]
  (cond (< x 10) x
        :else (list (int (Math/floor (/ x 2)))
                    (int (Math/ceil (/ x 2))))))

(defn -main [& args]
  (let [lines (map parse (line-seq (java.io.BufferedReader. *in*)))]
    (println lines)))
;  (doseq [ln (line-seq (java.io.BufferedReader. *in*))]
;    (println (parse ln))))
