#!/bin/sh

#first create HOMES for new installing softwares store their binary executable files

GMP_HOME='/usr/local/gmp-6.0.0'
MPFR_HOME='/usr/local/mpfr-3.2.1'
MPC_HOME='/usr/local/mpc-1.0.3'
GCC_HOME='/usr/local/gcc-4.8.2'

 


#download each source file to the corresponding path 
tempfile=`mktemp download.XXXXX`

echo 'here we create a file '

exec 3>$tempfile

echo 'https://ftp.gnu.org/gnu/gmp/gmp-6.0.0a.tar.xz'>&3

echo 'http://www.mpfr.org/mpfr-current/mpfr-3.1.2.tar.xz'>&3

echo 'ftp://ftp.gnu.org/gnu/mpc/mpc-1.0.3.tar.gz'>&3

echo 'http://gcc.skazkaforyou.com/releases/gcc-4.8.2/gcc-4.8.2.tar.gz'>&3

echo 'here we begin download corresponding files'

wget -i download.*


rm -f download.*


#decompression each source file package 

tar -xzf gcc-4.8.2.tar.gz &&

tar -xzf mpc-1.0.3.tar.gz &&

xz -d mpfr-3.1.2.tar.xz &&

xz -d gmp-6.0.0a.tar.xz  

tar -xvf mpfr-3.1.2.tar &&
tar -xvf gmp-6.0.0a.tar

rm -f *.tar.gz 


#create directory for each binary executable files store
#/usr/local/ is preferred optional main directory branch 

mkdir $GMP_HOME  &&
mkdir $MPFR_HOME &&
mkdir $MPC_HOME  &&
mkdir $GCC_HOME 



#here MPFR depends on GMP library , and MPC depends on 
#both GMP and MPFR , so we install GMP first

    #set gmp binary file installation path name and other compile info
    /Xshell/gmp-6.0.0/configure --prefix=$GMP_HOME
     
    #run make file and make install 
    cd /Xshell/gmp-6.0.0 && make && make install
#-------------------------------------

    #set mpc binary file installation path name and other compile options
    /Xshell/mpfr/configure --prefix=$MPFR_HOME --with-gmp=$GMP_HOME  

    #run make file and make install command 
    cd /Xshell/mpfr-1.0.3 && make && make install
#-------------------------------------

    #set MPFR binary file installation path name and other dependency options
    /Xshell/mpc/configure --prefix=$MPC_HOME --with-gmp=$GMP_HOME --with-mpfr=$MPFR_HOME
  
    #run make file and make install command
    cd /Xshell/mpc-3.1.2 && make && make install
#-------------------------------------

echo 'dependency libraries are installed properly , now let set , compile and install gcc '

# here we begin to install gcc library 

# first and most important is to add new installed three libraries'
# path to the /etc/profile , and update /etc/profile this file 

   echo "export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:$GMP_HOME:$MPFR_HOME:$MPC_HOME" | tee -a /etc/profile

   source /etc/profile 

# change directory to gcc package downloaded path 
	
#-------------------------------------
	#set binary executable file path 

        /Xshell/gcc-4.8.2/configure --prefix=$GCC_HOME -enable-threads=posix \
	-disable-checking -disable-multilib -enable-languages=c,c++ \
    	--with-gmp=$GMP_HOME --with-mpfr=$MPFR_HOME --with-mpc=$MPC_HOME
	

	 echo "now we make and make install gcc , patience wait for almost 1 hour"

	#make and make install 
 	cd /Xshell/gcc-4.8.2 && make && make install 

	#update the soft-link gcc and g++ in directory /usr/bin/
	mv /usr/bin/gcc /usr/bin/gcc47
	mv /usr/bin/g++ /usr/bin/gpp47
	
	ln -s $GCC_HOME/bin/gcc  /usr/bin/gcc
	ln -s $GCC_HOME/bin/g++  /usr/bin/g++


#-------------------------------------

#finally , check whether gcc is updated successfully 
echo 'here we check version of the current gcc '
	g++ -v
