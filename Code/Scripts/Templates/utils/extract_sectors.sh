#!/bin/bash
#usage ./extract_sectors.sh N_P PROC NLOOP FAMILIES COLORLAYERS
#example ./extract_sector.sh 2 Zgqq 1 "PL PLx12 PLx13 PLx23 PLx123 PLx132" "C1F0Z0 C9F0Z0 C0F0Z1"
echo "Running sector separation..."
N_P=$1
PROC=$2
NLOOP=$3
FAMILIES=$4
COLORLAYERS=$5


if [ -d "tmp/sector_list" ]
    then rm -f -r tmp/sector_list
fi
mkdir tmp/sector_list

shift_file=external/$PROC.$NLOOP.shifts.inc


sed -e "s/.*Sector(/(/g" -e "s/) \*.*/)/g"  $shift_file > tmp/tmp1
sort tmp/tmp1 > tmp/tmp2
uniq tmp/tmp2 > tmp/tmp1 

if [ -d "tmp/top_t_s" ]
   then rm -f -r tmp/top_t_s
fi
mkdir tmp/top_t_s


for i in ${FAMILIES[*]} ; do
    toGrep="("$i","
    toFile="tmp/top_t_s/"$i"_t_s"
    grep $toGrep tmp/tmp1 > $toFile
done


rm tmp/tmp1
rm tmp/tmp2


#create do loop for bash
cat tmp/top_t_s/* > tmp/fulltmp1
sed -e "1 s/(/{ /g"  -e "1 s/, .*, /_/g" -e "s/(/ /g" -e "$ s/)/}/g" -e "s/, .*, /_/g" -e "s/)//g" -e "1 s/{/SECTORSLOOP=(/g" -e "$ s/}/)/g" tmp/fulltmp1 > tmp/fulltmp2
tr -d '\n' < tmp/fulltmp2 > tmp/sector_list/script_do_sector
rm tmp/fulltmp1
rm tmp/fulltmp2



declare -a NONEMPTYFAM
j=0

for i in ${FAMILIES[*]} ; do
echo "Family "$i""
  for k in ${COLORLAYERS[*]} ; do    
  echo " - preparing FORM script for layer "$k""         
  mkdir -p "tmp/layers/"$k"/sector_separated/"$i""
  done
  toFile="tmp/sector_list/"$i".$NLOOP.inc"
  fromFile="tmp/top_t_s/"$i"_t_s"
  #special case for number of sector = 1
  NSECTOR=$(wc -l < "$fromFile")
  if [[ $NSECTOR -eq 1 ]];then
    toSed1="1 s/("$i", /#define sector \",/g"
    toSed2="s/,.*, //g"
    toSed3="s/)/\"/g"
    if [ -s "$fromFile" ];then
      NONEMPTYFAM[$j]=$i
      j=$(( $j + 1))
      sed -e "$toSed1" -e "$toSed2" -e "$toSed3" -e "$ s/,/}/g"  $fromFile > $toFile
      printf " \n \n" >> $toFile
      printf "b Sector; \n.sort\n" >> $toFile
      printf "l tmp = ampl[Sector("$i",'sector')];\n.sort\n" >> $toFile
      printf "#if termsin(tmp) != 0\n" >> $toFile
      printf "#write <tmp/layers/'LAYER'/sector_separated/'FAMILY'/"$i"_'sector'.$NLOOP.sect> \"id L'LAYER'"$i"_'sector' = Sector("$i", 'sector')*( %%E ) ;\" tmp;\n" >> $toFile
      printf "\n#endif" >> $toFile  
  fi 
   else
    toSed1="1 s/("$i", .*, /#do sector={/g"
    toSed2="s/("$i", .*, //g"
    toSed3="s/)/,/g"    
    if [ -s "$fromFile" ];then
      NONEMPTYFAM[$j]=$i
      j=$(( $j + 1))
      sed -e "$toSed1" -e "$toSed2" -e "$toSed3" -e "$ s/,/}/g"  $fromFile > tmp/tmp1
      tr -d '\n' <  tmp/tmp1 > $toFile
      printf " \n \n" >> $toFile
      printf "b Sector; \n.sort\n" >> $toFile
      printf "l tmp = ampl[Sector("$i",'sector')];\n.sort\n" >> $toFile
      printf "#message Separated sector 'sector' of family 'FAMILY' in layer 'LAYER'\n" >> $toFile
      printf "#if termsin(tmp) != 0\n" >> $toFile      
      printf "#write <tmp/layers/'LAYER'/sector_separated/'FAMILY'/"$i"_'sector'.$NLOOP.sect> \"id L'LAYER'"$i"_'sector' = Sector("$i", 'sector')*( %%E ) ;\" tmp;\n" >> $toFile
      printf "\n#endif" >> $toFile
      printf "\n#enddo" >> $toFile

      rm tmp/tmp1
      fi 
  fi
done
rm -r tmp/top_t_s





#run the form script to extract the given sector's contribution

N_P=$1;

#general function to wait for the number of jobs to be less than a given number
function pwait() {
     while [ $(jobs -p | wc -l) -ge $1 ]; do
         sleep 1
     done
 }

for i in ${COLORLAYERS[*]} ; do
for f in ${NONEMPTYFAM[*]} ; do
    form \
	-d FAMILY="$f" -d LAYER="$i" \
	-M \
        utils/sector_separation.frm \
	&   pwait $N_P
done
done

#clean up
for i in ${FAMILIES[*]} ; do
for k in ${COLORLAYERS[*]} ; do
directory="tmp/layers/"$k"/sector_separated/"$i""
[ "$(ls -A $directory)" ] || rmdir $directory        
done
done


