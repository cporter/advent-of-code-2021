#lang racket

(define lines 
    (call-with-input-file "input.txt"
        (lambda (fp) (sequence->list (in-lines fp)))))

(define numbs
    (lambda (line sep)
        (map string->number (string-split line sep))))

(define all-moves (numbs (first lines) ","))

(define boards-fn
    (lambda (lst)
        (if (= 0 (length lst)) 
            '()
            (let ([linez (drop (take lst 6) 1)])
                (cons 
                    (filter number? (foldr append '() (map (lambda (x) (numbs x " ")) linez)))
                    (boards-fn (drop lst 6)))))))

(define fix-board (lambda (board)
    (let ([fix-elt (lambda (elt) (cons elt #f))])
        (map fix-elt board))))
(define all-boards (map fix-board (boards-fn (drop lines 1))))

(define mark-board (lambda (board n)
    (let ([mark-cell 
          (lambda (cell)
            (if (= (car cell) n)
                (cons (car cell) #t)
                cell))])
        (map mark-cell board))))

(define range 
    (lambda (begin count step)
        (if (= 0 count) '()
            (cons begin (range (+ begin step) (- count 1) step)))))

(define wins 
    (list 
        (range 0 5 1) (range 5 5 1) (range 10 5 1) (range 15 5 1) (range 20 5 1)
        (range 0 5 5) (range 1 5 5) (range 2 5 5)  (range 3 5 5)  (range 4 5 5)
        ; (range 0 5 6) (range 20 5 -4)
        ))

(define any (lambda (lst)
    (foldl (lambda (a b) (or a b)) #f lst)))
(define all (lambda (lst)
    (foldl (lambda (a b) (and a b)) #t lst)))
(define nth (lambda (i l) (if (= 0 i) (car l) (nth (- i 1) (cdr l)))))    
(define board-wins (lambda (board) 
    (let ([winner (lambda (win)
            (all (map (lambda (idx) (cdr (nth idx board))) win)))])
        (any (map winner wins)))))
(define board-loses (lambda (board) (not (board-wins board))))

(define unmarked (lambda (board)
    (filter (lambda (elt) (not (cdr elt))) board)))

(define score-board (lambda (board)
    (foldl + 0 (map car (unmarked board)))))

(define print-board (lambda (b)
    (for ([i (range 0 25 1)])
        (if (= 4 (remainder i 5)) 
            (println (nth i b)) 
            (print (nth i b))))))

(define find-winner
    (lambda (boards moves)
        (println (list (length boards) (length moves)))
        (let* ([move (car moves)]
               [new-moves (cdr moves)]
               [mark (lambda (board) (mark-board board move))]
               [new-boards (map mark boards)]              
               [winning-boards (filter board-wins new-boards)]
               [non-winning-boards (filter board-loses new-boards)])

               (if (empty? non-winning-boards)
                (let ([winner (car winning-boards)])
                    (println move)
                    (print-board winner)
                    (println (unmarked winner))
                    (* move (score-board winner)))
                (find-winner non-winning-boards new-moves)))))
(define winner (find-winner all-boards all-moves))
(println winner)
