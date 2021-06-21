# hse21_H3K27me3_ZDNA_human

## Проект по биоинформатике / индивидуальная часть

Анализ взаимосвязи между присутствием гистоновой метки H3K27me3 и Z-спиралей.

В проекте используется геном человека сборки hg19, тип клетки H7. Взяты два ChIP-seq эксперимента с идентификаторами
1. [ENCFF017UQU] (https://www.encodeproject.org/files/ENCFF017UQU/)
2. [ENCFF662NTZ] (https://www.encodeproject.org/files/ENCFF662NTZ/) 

## Визуализации данных

### Гистограммы длин ENCFF017UQU

<img src="https://sun9-19.userapi.com/impg/YF3WiRAizKNSUz4OoLNGIS1Fv2_Fqpv-G8B_2w/2dAI7tbEWtw.jpg?size=1214x774&quality=96&sign=b0479fe82d23e6957b4117ea6306c2ab&type=album" width="500"/>

#### После фильтрации с порогом в 4000

<img src="https://sun9-37.userapi.com/impg/WSe8SLZrZ90Tlx1YmI5EjHj7-oEUFII3vwcOjw/olk_ENre1AA.jpg?size=1214x774&quality=96&sign=130caab535e74cad3c13ffffa33c1b80&type=album" width="500"/>

### Гистограммы длин ENCFF662NTZ

<img src="https://sun1-17.userapi.com/impg/Lc9oR281e34aWh9q_f9t2L0SlK1tzhXjDz_pEA/DrjrYXKLo_o.jpg?size=970x972&quality=96&sign=5e5280afb8d8c87fae1bb2ae6c711f24&type=album" width="500"/>

#### После фильтрации с порогом в 4000

<img src="https://sun9-58.userapi.com/impg/QEtxc7jPCT8wuIR6fNLbMcRfMqsV2jlsZGuqOw/RJjKHN7uHHQ.jpg?size=970x972&quality=96&sign=6cdf6b72577f63b7dcfee83aeda8feb2&type=album" width="500"/>

### Гистограммы длин DeepZ
<img src="https://sun9-25.userapi.com/impg/DJLEbiOiOPVdWwRn-bJuZKphweQl4VZGPpvDGw/22GtgcmMlso.jpg?size=1214x687&quality=96&sign=c181365e6c64db0af3c95a1bf11fe125&type=album" width="500"/>


#### После фильтрации с порогом в 1000

<img src="https://sun9-71.userapi.com/impg/y-S-EfJuJpawEfnnKBCWgjNVjE3oYN53cw1beA/iBVwBLOihUk.jpg?size=1214x687&quality=96&sign=fdeedb333cd58a45644d97a82e44185f&type=album" width="500"/>


### Расположение относительно генов 

#### ENCFF017UQU

<img src="https://raw.githubusercontent.com/grach0v/minor_bioinf/master/Results/chip_seeker.ENCFF017UQU.hg19.filtered.plotAnnoPie.png" width="500"/>

#### ENCFF662NTZ

<img src="https://raw.githubusercontent.com/grach0v/minor_bioinf/master/Results/chip_seeker.ENCFF662NTZ.hg19.filtered.plotAnnoPie.png" width="500"/>

#### DeepZ
<img src="https://raw.githubusercontent.com/grach0v/minor_bioinf/master/Results/chip_seeker.DeepZ.plotAnnoPie.png" width="500"/>


### Пересечение со вторичной структурой DeepZ

#### Гистограмма длин пересечений

<img src="https://sun9-64.userapi.com/impg/o3YqVy0-XqbnsCrGNuONHzOwbnddab2uRfOCjA/3lA8RU4lW68.jpg?size=1214x687&quality=96&sign=d7b3667ffc83b121967cb7bf68ea2a3c&type=album" width="500"/>

#### Расположение относительно аннотированных генов для пересечений

<img src="https://sun9-39.userapi.com/impg/p5wtvV5cne0-N6PXgwvSFF_IX9yv47VK43PBvg/Bw_C9syu9cs.jpg?size=480x480&quality=96&sign=aa948d7b38c12acfa7f7451fa79e4a66&type=album" width="500"/>

## Геномный браузер

<img src="https://github.com/grach0v/minor_bioinf/blob/master/Results/ENCFF017UQU_filtered.png" width="1000"/>


<img src="https://github.com/grach0v/minor_bioinf/blob/master/Results/ENCFF662NTZ_filtered.png" width="1000"/>

 ## Команды:
 
Чтобы разархивировать используем zcat, чтобы выбрать 1-5 столбец воспользуемся cut -f1-5 
 
zcat *.bed.gz  |  cut -f1-5 > *.hg38.bed

Чтобы перевести с версии генома hg38 на hg19 используем liftOver

liftOver *.hg38.bed hg38ToHg19.over.chain.gz *.hg19.bed *.unmapped.bed

Чтобы отфильтровать участки по длине используем awk

cat *.hg19.bed | awk '$3-$2<порог>' > *.hg19.filtered.bed

затем отфильтрованные файлы заливаем в один

cat *.filtered.bed | sort -k1,1 -k2,2n | bedtools merge > merged.hg19.bed 
 
Сортируем файлы и получаем файл с пересечениями

sort -k1,1 -k2,2n merged.hg19.bed > merged.hg19.sorted.bed
bedtools intersect -a Hmerged.hg19.sorted.bed -b zhunt.bed > zhunt.intersect.bed

 
 
