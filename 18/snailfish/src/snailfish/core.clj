(ns snailfish.core
  (:require [clojure.core.match :refer [match]])
  (:require [instaparse.core :as insta]))

(def parser
  (insta/parser (clojure.java.io/resource "parser.bnf")))

(defn to-s [expr]
  (match expr
         [:num n] { :type :leaf :value (Integer. n) }
         [:expr "[" a "," b "]"]
         { :type :branch :left (to-s a) :right (to-s b) }))

(defn parse [line] (to-s (parser line)))

(defn leaf? [n] (= :leaf (:type n)))
(defn branch? [n] (= :branch (:type n)))
(defn nodeval [n] (:value n))
(defn create-leaf [x] {:type :leaf :value x })
(defn create-branch [a b] {:type :branch :left a :right b})
(defn l [n] (:left n))
(defn r [n] (:right n))

(defn magnitude [n]
  (if (leaf? n) (nodeval n)
      (+ (* 3 (magnitude (l n))) (* 2 (magnitude (r n))))))

(defn split [node done]
  (if done
    [node true]
    (if (leaf? node)
      (if (< 9 (nodeval node))
        (let [v (nodeval node)]
          [(create-branch (create-leaf (int (Math/floor (/ v 2))))
                          (create-leaf (int (Math/ceil (/ v 2))))) true])
        [node done])
      (let [[s-left res-l] (split (l node) done)
            [s-right res-r] (split (r node) res-l)]
        [(create-branch s-left s-right) res-r]))))


(defn explode? [node height]
  (and (branch? node) (leaf? (l node)) (leaf? (r node)) (> height 4)))

(defn carry-value [node value dir]
  (if (leaf? node)
    (create-leaf (+ (nodeval node) value))
    (create-branch
      (if (= dir :left) (carry-value (l node) value dir) (l node))
      (if (= dir :right) (carry-value (r node) value dir) (r node)))))

(defn explode-tree [node height]
  (if (leaf? node)
    [node nil]
    (if (explode? node height)
      [(create-leaf 0) {:l (nodeval (l node))
                        :r (nodeval (r node))
                        :used-l false
                        :used-r false}]
                                        ; else try exploding branch from left
      (let [[l-res l-state] (explode-tree (l node) (inc height))]
        (if (nil? l-state)
                                        ; no explosion on left side, try right side
          (let [[r-res r-state] (explode-tree (r node) (inc height))]
            (if (nil? r-state)
                                        ; no explosion on right side, go back
              [(create-branch l-res r-res) nil]
                                        ; explosion on right side
              (let [{lv :l rv :r ul :used-l ur :used-r} r-state]
                (if (not ul)
                                        ; left value to be carried down
                  [(create-branch (carry-value (l node) lv :right) r-res) (assoc r-state :used-l true)]
                                        ; left value already passed down, go back
                  [(create-branch l-res r-res) r-state]
                  ))))
                                        ; explosion on left side, try carrying right-value
          (let [{lv :l rv :r ul :used-l ur :used-r} l-state]
            (if (not ur)
                                        ; left value to be carried down
              [(create-branch l-res (carry-value (r node) rv :left)) (assoc l-state :used-r true)]
                                        ; left value already passed down, go back
              [(create-branch l-res (r node)) l-state]
              )))))))

(defn join-trees [left right]
  (create-branch left right))

(defn add-trees [t1 t2]
  (let [t (join-trees t1 t2)]
    (loop [current t]
      (let [[res state] (explode-tree current 1)]
        (if (nil? state)
          (let [[res state] (split current false)]
            (if state
              (recur res)
              current))
          (recur res))))))

(defn magnitude [node]
  (if
    (leaf? node)
    (nodeval node)
    (+ (* 3 (magnitude (l node))) (* 2 (magnitude (r node))))))

(defn pairs-of [x seq]
  (if (empty? seq)
    '()
    (cons [x (first seq)]
          (pairs-of x (rest seq)))))

(defn all-pairs
  ([seq] (all-pairs seq '()))
  ([seq accum]
   (if (empty? seq) accum
       (all-pairs (rest seq)
                  (concat accum (pairs-of (first seq) (rest seq)))))))

(defn biggest-mag [[a b]]
  (max (magnitude (add-trees a b))
       (magnitude (add-trees b a))))

(defn -main [& args]
  (let [numbers (map parse (line-seq (java.io.BufferedReader. *in*)))
        result (reduce add-trees numbers)
        mag (magnitude result)
        biggest (reduce max (map biggest-mag (all-pairs numbers)))]
    (printf "part 1: %d\n" mag)
    (printf "part 2: %d\n" biggest)))
