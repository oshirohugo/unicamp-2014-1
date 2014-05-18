simulate: image
	arm-sim --rom=/home/specg12-1/mc404/simulador/dumboot.bin --sd=disk.img
image: link
	mksd.sh --so /home/specg12-1/mc404/simulador/dummyos.elf --user final
link: mount
	arm-eabi-ld ra146446_p1.o test1.o -g -o final -Ttext=0x77802000 -Tdata=0x77802050
mount:
	arm-eabi-as ra146446_p1.s -g -o ra146446_p1.o
	arm-eabi-gcc test1.c -g -o test1.o
clean:
	rm *.o
