BASE_DIR := $(shell pwd)

APPLICATION_DIRS := _axpy _blackscholes _canneal _jacobi-2d _lavaMD _matmul _spmv _swaptions _streamcluster _somier _particlefilter _pathfinder 

all: axpy blackscholes canneal jacobi-2d lavaMD matmul spmv swaptions streamcluster somier particlefilter pathfinder

axpy:
	cd _axpy; 			\
	make start;			\
	make vector; 		\
	make serial;		\
	make auto;

blackscholes:
	cd _blackscholes; 	\
	make start;			\
	make vector; 		\
	make serial;		\
	make auto;


canneal:
	cd _canneal; 		\
	make start;			\
	make vector; 		\
	make serial;		\
	make auto;


jacobi-2d:
	cd _jacobi-2d;		\
	make start;			\
	make vector; 		\
	make serial;		\
	make auto;


lavaMD:
	cd _lavaMD;		    \
	make start;			\
	make vector; 		\
	make serial;		\
	make auto;


matmul:
	cd _matmul;		    \
	make start;			\
	make vector; 		\
	make serial;		\
	make auto;


particlefilter:
	cd _particlefilter;	\
	make start;			\
	make vector; 		\
	make serial;		\
	make auto;


pathfinder:
	cd _pathfinder;		\
	make start;			\
	make vector; 		\
	make serial;		\
	make auto;

spmv:
	cd _spmv; 			\
	make start;			\
	make vector; 		\
	make serial;		\
	make auto;


swaptions:
	cd _swaptions; 		\
	make start;			\
	make vector; 		\
	make serial;		\
	make auto;


somier:
	cd _somier; 		\
	make start;			\
	make vector; 		\
	make serial;		


streamcluster:
	cd _streamcluster; 	\
	make start;			\
	make vector; 		\
	make serial;		\
	make auto;


clean:
	for dir in $(APPLICATION_DIRS) ; do cd $$dir ; make clean ; cd .. ; done
