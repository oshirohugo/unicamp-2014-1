#source /home/specg12-1/mc404/simulador/set_path.sh



simulate: image
	arm-sim --rom=/home/specg12-1/mc404/simulador/dumboot.bin --sd=disk.img
image: link
	mksd.sh --so /home/specg12-1/mc404/simulador/dummyos.elf --user final
link: mount
	arm-eabi-ld ra146446_p2.o ra146446_p1.o main.o -g -o final -Ttext=0x77802000 -Tdata=0x77802360
	#arm-eabi-ld main.o -g -o final -Ttext=0x77802000 -Tdata=0x77802150
mount: start
	arm-eabi-as ra146446_p2.s -g -o ra146446_p2.o
	arm-eabi-as ra146446_p1.s -g -o ra146446_p1.o
	arm-eabi-as main.s -g -o main.o
	#arm-eabi-as *.s -g -o main.o
clean:
	rm *.o
start:
	rm disk.img final
