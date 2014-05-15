clean:
	rf *.o *.s
output: bin1.o bin2.o
	ld -dynamic-link /lib64/ld-linux-x86-64.so.2 /usr/lib64/crt1.o /usr/lib64/crti.o bin1.o bin2.o -lc /usr/lib64/crtn.o -o output
bin2.o: assembly2.s
	as -o bin2.o assembly2.s
assembly2.s: source2.c
	gcc -S source2.c -o assembly2.s
bin1.o: assembly1.s
        as -o bin1.o assembly1.s
assembly1.s: source1.c
        gcc -S source1.c -o assembly1.s

	
