#makefile

start:
	rm bin/*.*

serial: # with -O2 fails in spike and gem5 the vector version
	${RISCV}/bin/clang++ -march=rv64g -O3 -fno-vectorize -c -o src/blackscholes_serial.o src/blackscholes.cpp
	${RISCV}/bin/clang++ -march=rv64g -O3 -fno-vectorize -o bin/blackscholes_serial.exe src/blackscholes_serial.o -lm
	rm src/*.o
	${RISCV}/bin/llvm-objdump --mattr=+m,+f,+d,+a,+c -ds  bin/blackscholes_serial.exe > bin/blackscholes_serial.dump
auto: # with -O2 fails in spike and gem5 the vector version
	${RISCV}/bin/clang++ -march=rv64gcv -O3 -c -o src/blackscholes_auto.o src/blackscholes.cpp
	${RISCV}/bin/clang++ -march=rv64gcv -O3 -o bin/blackscholes_auto.exe src/blackscholes_auto.o -lm
	rm src/*.o
	${RISCV}/bin/llvm-objdump --mattr=+m,+f,+d,+a,+c -ds  bin/blackscholes_auto.exe > bin/blackscholes_auto.dump
vector: # with -O2 fails in spike and gem5 
	${RISCV}/bin/clang++  -march=rv64gcv -O3 -DUSE_RISCV_VECTOR  -fno-vectorize -c -o src/blackscholes.o src/blackscholes.cpp ; \
	${RISCV}/bin/clang++  -march=rv64gcv -O3 -DUSE_RISCV_VECTOR  -fno-vectorize -o bin/blackscholes_vector.exe src/*.o -lm ; \
	rm src/*.o ; \
	${RISCV}/bin/llvm-objdump --mattr=+m,+f,+d,+a,+c,+v -ds bin/blackscholes_vector.exe > bin/blackscholes_vector.dump ;

clean:
	rm bin/*.dump; \
	rm bin/*.exe;