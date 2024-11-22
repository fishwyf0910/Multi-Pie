# 计算等位基因频率
vcftools --gzvcf irtysh-other.NC_056617.1.phasing.vcf.gz --freq --out irtysh-other.NC_056617.1

library(scatterpie)
library(ggplot2)

# 读入数据
setwd("E:\\Rworkspace\\allele-fre")
df <- read.table("allele-fre.txt", header = TRUE, sep = "\t")

# 查看数据
df
   x y      A      B region
1     2   2 1.000000 0.000000      1   # x,y表示的是不同群体的位置坐标，A,B表示的是ref，alt的allele-frq。所以做表的时候，把想展示在上面的群体，y设置成最大。同样在定义df3的时候，最上面的群头写在最后。
2     4   2 1.000000 0.000000      2
3     6   2 0.833000 0.167000      3
4     8   2 1.000000 0.000000      4
5    10   2 0.750000 0.250000      5
6    12   2 0.791667 0.208333      6
7    14   2 0.958333 0.041667      7
8     2   4 0.625000 0.375000      8
9     4   4 0.625000 0.375000      9
10    6   4 0.541667 0.458333     10
11    8   4 0.625000 0.375000     11
12   10   4 1.000000 0.000000     12
13   12   4 0.958333 0.041667     13
14   14   4 0.541667 0.458333     14
15    2   6 0.695402 0.304598     15
16    4   6 0.666667 0.333333     16
17    6   6 0.597701 0.402299     17
18    8   6 0.649425 0.350575     18
19   10   6 0.902299 0.097701     19
20   12   6 0.954023 0.045977     20
21   14   6 0.603448 0.396552     21
22    2   8 0.461538 0.538462     22
23    4   8 0.500000 0.500000     23
24    6   8 0.384615 0.615385     24
25    8   8 0.269231 0.730769     25
26   10   8 1.000000 0.000000     26
27   12   8 0.961538 0.038462     27
28   14   8 0.423077 0.576923     28

# 构建ref，alt，pop的图例
df1<-data.frame(
  x=seq(1.9,14,2), y=9.5,
  label=c("T","T","G","G","A","G","G")
)
df2<-data.frame(
  x=seq(2.1,15,2), y=9.5,
  label=c("C","C","A","A","C","A","A")
)

df3<-data.frame(
  x=16, y=c(2,4,6,8),
  label=c("south","Irtysh-south","Irtysh-other","north")
)

# 画图
pdf("allele-fre.pdf",width=10,height=6)

ggplot()+
  geom_scatterpie(data=df,
                  aes(x,y,group=region,r=0.9),
                  cols = c("A","B"))+
  coord_equal()+
  theme_void()+
  theme(legend.position = "none")+
  scale_fill_manual(values = c("#5b9bd5","#e64b35"))+
  geom_label(data=df1,aes(x=x-0.1,y=y,label=label),
             fill="#5b9bd5")+
  geom_label(data=df2,aes(x=x+0.1,y=y,label=label),
             fill="#e64b35")+
  geom_text(data=df3,aes(x=x,y=y,label=label))

dev.off()
