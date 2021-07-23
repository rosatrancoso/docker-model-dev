!ifort test_libs.f90 -L/usr/local/lib -lnetcdff -lnetcdf -lhdf5_hl -lhdf5 -lm -lz -lhdf5_fortran
program test_libs

    use netcdf
    use hdf5
    implicit none
    integer :: a
    character(10) :: aux

    character(*), parameter               :: FileName
    integer(HID_T)                 :: FileID, STAT_CALL        


    a = 100
    print*, 'ola', a
    print*, nf90_inq_libvers()

    CALL h5open_f(a)
    print*, a

    FileName = 'test_libs.hdf5'
    call h5fcreate_f(trim(FileName),                &
                    ACCESS_FLAGS = H5F_ACC_TRUNC_F, &
                    FILE_ID = FileID,               &
                    HDFERR = STAT_CALL)

end program test_libs