# History:
#   2016-01-16 - Merged from Tom Durrant and Alex Port scripts
#   2016-02-19 - To be called from dockerfile as root (sudo needs tty session)

###########
## mpich ##
###########

echo "Installing mpich..."
wget http://www.mpich.org/static/downloads/3.2/mpich-3.2.tar.gz
tar zxvf mpich-3.2.tar.gz
cd mpich-3.2
./configure 2>&1 | tee configure.log
make 2>&1 | tee make.log
make check 2>&1 | tee make_check.log
make install 2>&1 | tee make_install.log
cd ../

