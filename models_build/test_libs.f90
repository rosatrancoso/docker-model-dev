!ifort test_libs.f90 -L/usr/local/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lm -lz -lhdf5_fortran
program test_libs

    use netcdf
    use hdf5
    implicit none
    integer :: a
    character(10) :: aux

    a = 100
    print*, 'ola', a
    print*, nf90_inq_libvers()

    CALL h5open_f(a)
    print*, a

end program test_libs