(ns snailfish.core-test
  (:require [clojure.test :refer :all]
            [snailfish.core :refer :all]))

(deftest split-test
  (is (= 9 (snailfish.core/split 9)))
  (is (= 0 (snailfish.core/split 0)))
  (is (= '(5 6) (snailfish.core/split 11)))
  (is (= '(6 6) (snailfish.core/split 12)))
  (is (= '(5 5) (snailfish.core/split 10))))
