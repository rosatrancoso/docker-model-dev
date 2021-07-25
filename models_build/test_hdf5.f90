! h5fc test_hdf5.f90
program test_hdf5

    use hdf5
    implicit none
    integer :: a
    character(10)   :: aux

    character(60)   :: FileName
    integer(HID_T)  :: FileID
    integer         :: STAT_CALL

    CALL h5open_f(a)
    print*, a

    FileName = 'test_libs.hdf5'
    call h5fcreate_f(trim(FileName),                &
                    ACCESS_FLAGS = H5F_ACC_TRUNC_F, &
                    FILE_ID = FileID,               &
                    HDFERR = STAT_CALL)

end program test_hdf5