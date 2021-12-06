program Lanternfish
    implicit none
    integer, parameter :: MAX = 8
    integer, parameter :: INPUT_SIZE = 300
    integer(kind = 8), dimension(0:MAX) :: fish
    integer(kind = 8) :: i, tmp, to_add, total, n_fish, rounds

    do i = 0, MAX
        fish(i) = 0
    end do

    open(1, file = 'input-fortran.txt', status = 'old')
    do i = 1, INPUT_SIZE
        read(1, *) tmp
        fish(tmp) = 1 + fish(tmp)
    end do
    close(1)

    bigloop: do rounds = 1, 256
        to_add = fish(0)
        do i = 1, MAX
            fish(i-1) = fish(i)
        end do
        fish(8) = to_add
        fish(6) = to_add + fish(6)
    end do bigloop

    total = 0

    do i = 0, MAX
        total = fish(i) + total
    end do

    print*, total
end program Lanternfish