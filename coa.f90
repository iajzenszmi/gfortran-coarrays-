! Created by Tobias Burnus 2010.
! Edited by Ian Martin Ajzenszmidt, Melbourne Australa 2023

program Hello_World
  implicit none
  integer :: i  ! Local variable
  character(len=80) :: greeting[*] ! scalar coarray
  ! Note: "greeting" is the local variable while "greeting[<index>]"
  ! accesses the variable on a remote image
 
  ! Interact with the user on Image 1
  if (this_image() == 1) then
    write(*,'(a)',advance='no') 'Enter your greeting: '
    read(*,'(a)') greeting
 
    ! Distribute information to other images
    do i = 2, num_images()
      greeting[i] = greeting 
   end do
  end if
 
  sync all ! Barrier to make sure the data has arrived
 
  ! I/O from all nodes
  write(*,'(3a,i0)') 'Greetings ',trim(greeting),' from image ', this_image()
end program Hello_world
