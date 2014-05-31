

#source /home/specg12-1/mc404/simulador/set_path.sh

echo '--------------------------------------------------------'
arm-eabi-as ias_arch.s -g -o ias_arch.o
arm-eabi-as ra146446_p2.s -g -o ra146446_p2.o
arm-eabi-as ra146446_p3.s -g -o ra146446_p3.o
arm-eabi-as main.s -g -o main.o
echo '--------------------------------------------------------'
arm-eabi-ld main.o ias_arch.o ra146446_p2.o ra146446_p3.o  -g -o final -Ttext=0x77802000 -Tdata=0x778036d0
echo '--------------------------------------------------------'
mksd.sh --so /home/specg12-1/mc404/simulador/dummyos.elf --user final

rm *.o
echo '--------------------------------------------------------'
arm-sim --rom=/home/specg12-1/mc404/simulador/dumboot.bin --sd=disk.img

