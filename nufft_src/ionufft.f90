module ionufft
  implicit none
contains

  subroutine ionufft1d2(nj,ms,iflag,eps,xj,fk,cj)
    implicit none
    integer, intent(in) :: ms,nj,iflag
    complex*16,intent(in) :: fk(ms)
    real*8,intent(in) :: xj(nj)
    real*8,intent(in) :: eps
    complex*16,intent(out) :: cj(nj)
    integer :: ier
    
    call nufft1d2f90(nj,xj,cj,iflag,eps,ms,fk,ier)
    
  end subroutine ionufft1d2


end module ionufft
