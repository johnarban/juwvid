cc Copyright (C) 2004-2009: Leslie Greengard and June-Yub Lee 
cc Contact: greengard@cims.nyu.edu
cc 
cc This software is being released under a FreeBSD license
cc (see license.txt in this directory). 
c
      program testfft
      implicit none
c
c --- local variables
c
      integer i,ier,iflag,j,k1,mx,ms,nj
      parameter (mx=10 000)
      real*8 xj(mx), sk(mx)
      real*8 err,eps,pi
      parameter (pi=3.141592653589793238462643383279502884197d0)
      complex*16 cj(mx),cj0(mx),cj1(mx)
      complex*16 fk0(mx),fk1(mx)
c
c     --------------------------------------------------
c     create some test data
c     --------------------------------------------------

      ms=8
      nj=8 
      i=1
      do i = 1,nj
         xj(i) = 2*pi*real(i)/ms 
      enddo

      do j = 1,ms/2          
         fk0(j)= dcmplx(real(j+ms/2),0.0)
      enddo
      do j = ms/2+1,ms          
         fk0(j)= dcmplx(real(j-ms/2),0.0)
      enddo

c
c     --------------------------------------------------
c     start tests
c     --------------------------------------------------
c
      iflag = -1
      print*,' Start 1D testing: ', ' nj =',nj, ' ms =',ms
      do i = 1,4
         if (i.eq.1) eps=1d-4
         if (i.eq.2) eps=1d-8
         if (i.eq.3) eps=1d-12
         if (i.eq.4) eps=1d-16
c extended/quad precision tests
         if (i.eq.5) eps=1d-20
         if (i.eq.6) eps=1d-24
         if (i.eq.7) eps=1d-28
         if (i.eq.8) eps=1d-32
	 print*,' '
  	 print*,' Requested precision eps =',eps
	 print*,' '
c
c     -----------------------
c     call 1D Type1 method
c     -----------------------
c
c         call dirft1d1(nj,xj,cj,iflag, ms,fk0)
c         call nufft1d1f90(nj,xj,cj,iflag,eps, ms,fk1,ier)
c         call errcomp(fk0,fk1,ms,err)
c         print *,' ier = ',ier
c         print *,' type 1 error = ',err
c
c     -----------------------
c     call 1D Type2 method
c     -----------------------
c
         call dirft1d2(nj,xj,cj0,iflag, ms,fk0,ier)
         call nufft1d2f90(nj,xj,cj1,iflag, eps, ms,fk0,ier)
         call errcomp(cj0,cj1,nj,err)
         print *,' ier = ',ier
         print *,' type 2 error = ',err
c
c     -----------------------
c     call 1D Type3 method
c     -----------------------
c         do k1 = 1, ms
c            sk(k1) = 48*dcos(k1*pi/ms)
c         enddo
c         call dirft1d3(nj,xj,cj,iflag, ms,sk,fk0)
c         call nufft1d3f90(nj,xj,cj,iflag,eps, ms,sk,fk1,ier)
c         call errcomp(cj0,cj1,nj,err)
c         print *,' ier = ',ier
c         print *,' type 3 error = ',err
      enddo
      stop
      end
c
c
c
c
c
      subroutine errcomp(fk0,fk1,n,err)
      implicit none
      integer k,n
      complex*16 fk0(n), fk1(n)
      real *8 salg,ealg,err
c
      ealg = 0d0
      salg = 0d0
      do k = 1, n
         ealg = ealg + cdabs(fk1(k)-fk0(k))**2
         salg = salg + cdabs(fk0(k))**2
      enddo
      err =sqrt(ealg/salg)
      return
      end
