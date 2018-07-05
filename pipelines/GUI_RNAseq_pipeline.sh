
description=$(zenity --forms --title="RNA-Seq project" --text="Assign experiment code (no spaces!)" --add-entry="PROJECT NAME" --add-entry="POOL NAME" --add-entry="SAMPLE NAMES (sep by ',')
[cntrl7,cntrl8,actd10,actd11]" --add-entry="SAMPLE TYPE 
(cntrl for control, sep by ',')
[cntrl,cntrl,actd,actd]")
pname=$(echo $description | cut -d'|' -f1)
poolname=$(echo $description | cut -d'|' -f2)
snames=$(echo $description | cut -d'|' -f3)
stype=$(echo $description | cut -d'|' -f4)

zenity --info --title="READ-1" --text="Select all read-1 files (multiple selection)" --ok-label="OK" 
READ1=$(zenity --file-selection --multiple --separator=, --title="***READ-1***"  --text="Select read-1 files")

zenity --info --title="READ-2" --text="Select all read-2 files (multiple selection)" --ok-label="OK" 
READ2=$(zenity --file-selection --multiple --separator="," --title="***READ-2***"  --text="Select read-2 files")

zenity --info --title="Reference genome Bowtie" --text="Select reference genome for Bowtie" --ok-label="OK" 
REF_BOWTIE=$(zenity --file-selection --filename /opt/genome/human/hg19/index/bowtie2/hg19.fa --title="***Reference genome Bowtie***"  --text="Select reference genome for Bowtie")
REF_BOWTIE=$(echo $REF_BOWTIE | sed s/.fa//g)

zenity --info --title="Reference genome Hisat2" --text="Select reference genome for Hisat2" --ok-label="OK" 
REF_HISAT=$(zenity --file-selection --filename /opt/genome/human/hg19/index/hisat2/hg19.fa --title="***Reference genome Hisat2***"  --text="Select reference genome for Hisat2")
REF_HISAT=$(echo $REF_HISAT | sed s/.fa//g)

zenity --info --title="BED file" --text="Select BED file" --ok-label="OK" 
BED=$(zenity --file-selection --filename /opt/genome/human/hg19/annotation/hg19.refseq.bed12 --title="***BED file***"  --text="Select BED file")

zenity --info --title="Phix genome" --text="Select Phix genome" --ok-label="OK" 
PHIX=$(zenity --file-selection --filename /opt/genome/control/phix174/bwa/phiX174.fa --title="***Phix genome***"  --text="Select Phix genome")

zenity --info --title="Ribosomal genome 1" --text="Select Ribosomal genome 1" --ok-label="OK" 
RIB1=$(zenity --file-selection --filename /opt/genome/human/hg19/contam/bwa/hum5SrDNA.fa --title="***Ribosomal genome 1***"  --text="Select Ribosomal genome 1")

zenity --info --title="Ribosomal genome 2" --text="Select Ribosomal genome 2" --ok-label="OK" 
RIB2=$(zenity --file-selection --filename /opt/genome/human/hg19/contam/bwa/humRibosomal.fa --title="***Ribosomal genome 2***"  --text="Select Ribosomal genome 2")

zenity --info --title="GTF file" --text="Select GTF file" --ok-label="OK" 
GTF=$(zenity --file-selection --filename /opt/genome/human/hg19/annotation/hg19.refgene.sorted.gtf --title="***GTF file***"  --text="Select GTF file")

zenity --info --title="Reference genome" --text="Select reference genome" --ok-label="OK" 
REF=$(zenity --file-selection --filename /opt/genome/human/hg19/index/hg19.fa --title="***Reference genome***"  --text="Select reference genome")

zenity --info --title="Script path" --text="Select script directory" --ok-label="OK" 
R=$(zenity --file-selection --directory --title="***Scripts path***"  --text="Select script directory")

zenity --info --title="Output directory" --text="Select output directory" --ok-label="OK" 
OUT=$(zenity --file-selection --directory --title="***Output directory***"  --text="Select output directory")

library=$(zenity --list --text="Choose library-type" --radiolist --column "" --column "Library type" --hide-header --title="Library-type" TRUE "fr-firststrand" FALSE "fr-secondstrand")

alignment=$(zenity --list --text="Choose alignment method" --radiolist --column "" --column "Alignment method" --hide-header --title="Alignment method" TRUE "hisat" FALSE "tophat")

quant=$(zenity --list --text="Choose quantification method" --radiolist --column "" --column "Quantification method" --hide-header --title="Quantification method" TRUE "featureCounts" FALSE "Cufflinks")

dea=$(zenity --list --text="Choose differential expression analysis method" --radiolist --column "" --column "DEA method" --hide-header --title="DEA method" TRUE "edgeR" FALSE "DESeq2" FALSE "cummeRbund")

threads=$(zenity --forms --title="THREADS" --text="Number of threads" --add-entry="THREADS")


cd ${OUT}

python $R/RNAseq_Illumina.pipeline.py -n $pname -pn $poolname -sn $snames -r1 $READ1 -r2 $READ2 -type $stype -rb $REF_BOWTIE -rh $REF_HISAT -bed $BED -ph $PHIX -rib1 $RIB1 -rib2 $RIB2 -t $threads -g $GTF -a $alignment -l $library -q $quant -r $REF -dea $dea -r_path $R -o $OUT


# echo 'cd '${OUT} >> /Users/shadow/Desktop/prova.txt

# echo 'python '$R'/RNAseq_Illumina.pipeline.py 
# -n '$pname' 
# -pn '$poolname'
# -sn '$snames'
# -r1 '$READ1'
# -r2 '$READ2'
# -type '$stype' 
# -rb '$REF_BOWTIE' 
# -rh '$REF_HISAT'
# -bed '$BED'
# -ph '$PHIX' 
# -rib1 '$RIB1'
# -rib2 '$RIB2' 
# -t '$threads' 
# -g '$GTF'
# -a '$alignment'
# -l '$library'
# -q '$quant'
# -r '$REF'
# -dea '$dea'
# -r_path '$R'
# -o '$OUT'' >> /Users/shadow/Desktop/prova.txt

