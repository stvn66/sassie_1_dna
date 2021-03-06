C
C Author:  Steven C. Howell
C Purpose: Calculate interaction energy between every pair of atoms
C Created: January 2014
C
C $Id$
C
C         1         2         3         4         5         6         7
C123456789012345678901234567890123456789012345678901234567890123456789012

        subroutine calcwca(coor,natoms,tbead,w,wca)
        integer natoms,tbead,i,j
        double precision coor(natoms,3) 
        double precision wca(natoms,natoms)
        double precision cutoff,w,rij
        double precision x2,y2,z2,dx2,dy2,dz2
        
cf2py intent(in) :: coor,natoms,tbead,w,wca
cf2py intent(in,out):: wca
cf2py intent(hide):: i,j,cutoff,rij
cf2py intent(hide):: x2,y2,z2,dx2,dy2,dz2,rij

C    to call this from python:
C
C    import sys ; sys.path.append('./')
C    import electrostatics
C
C    wca = elecrostatics.calcwca(coor,natoms,tbeads,w,wca)
C
C
C    to setup and incorporate into python:
C
C    f2py -m electrostatics -c ./electrostatics.f


        cutoff = 2.**(1./6.)*w

        do 200,i=tbead,natoms
            x1=coor(i,1)
            y1=coor(i,2)
            z1=coor(i,3)
            do 100,j=1,i-1
               x2=coor(j,1)
               y2=coor(j,2)
               z2=coor(j,3)

               dx2=(x1-x2)*(x1-x2)
               dy2=(y1-y2)*(y1-y2)
               dz2=(z1-z2)*(z1-z2)
               rij=sqrt(dx2+dy2+dz2)
C         1         2         3         4         5         6         7
C123456789012345678901234567890123456789012345678901234567890123456789012

               if(rij . LT . cutoff) then
                  wca(i,j)=(w/rij)**12.-(w/rij)**6.+0.25
               end if
  100   continue
  200   continue

        end


