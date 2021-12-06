program Lanternfish
   implicit none
   integer, parameter :: MAX = 10000000
   integer, parameter :: INPUT_SIZE = 300
   integer, dimension(MAX) :: fish
   integer :: i, to_add, total, n_fish, rounds

   do i = 1, MAX
      fish(i) = 0
   end do

   open(1, file = 'input-fortran.txt', status = 'old')
   do i = 1, INPUT_SIZE
      read(1, *) fish(i)
   end do
   close(1)

   n_fish = INPUT_SIZE

   bigloop: do rounds = 1, 80
      do i = 1, n_fish
        fish(i) = fish(i) - 1
      end do
      to_add = 0
      do i = 1, n_fish
        if (fish(i) == 0) then
            to_add = to_add + 1
        end if
      end do
      do i = 1, to_add
        n_fish = n_fish + 1
        fish(n_fish) = 8
      end do
      do i = 1, n_fish
        if (fish(i) == 0) then
            fish(i) = 6
        end if
      end do
   end do bigloop

   print*, n_fish
end program Lanternfish