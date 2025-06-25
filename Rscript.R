# 日期格式設定
Sys.setlocale("LC_TIME","English")

# Julian days to Date
CH4$Date

# 坐標軸
y=bquote(Nitrous~oxide~emmision~"(g"~N~ha^-1~d^-1~")"))
 labs(y=bquote(Shoot~dry~weight~"(g"~plant^-1~")"))


# 排序
dfbind$exp <- factor(dfbind$exp,   levels = c("TARI20S", "TARI20F", "TARI21S", "TARI21F"))

# 使用 dplyr 計算平均與標準差
library(dplyr)
lettuceDW <- all %>% group_by(TrtID, TrtName,Town,Date0, Date, DAT, loc,transPlantMonth) %>% 
  summarise(LAI_mean = mean(LAI), LAI_sd = sd(LAI),
            shoot_mean = mean(shootDW), shoot_sd = sd(shootDW),
            headDW_mean = mean(headDW), headDW_sd = sd(headDW),
            leafDW_mean = mean(leafDW), leafDW_sd = sd(leafDW),
            stemDW_mean = mean(stemDW), stemDW_sd = sd(stemDW),
            outLeafDW_mean=mean(outLeafDW), outLeafDW_sd = sd(outLeafDW),
            headLeafDW_mean = mean(headLeafDW), headLeafDW_sd = sd(headLeafDW),
            shootFW_mean = mean(leafFW+stemFW), shootFW_sd = sd(leafFW+stemFW),
            headFW_mean = mean(headFW), headFW_sd = sd(headFW),
            GDD0 = mean(GDD0), EDD0 = mean(EDD0), GDD026=mean(GDD026),
            .groups = 'drop')  %>%
  as.data.frame()
# 如果有NA 則使用 na.rm=TRUE
rice2 <- rice %>% group_by(loc,year,Year) %>% 
  summarise(yield1 = mean(grainHa1,na.rm = TRUE), yield1_sd = sd(grainHa1,na.rm=TRUE),
            yield2 = mean(grainHa2,na.rm = TRUE), yield2_sd = sd(grainHa2,na.rm=TRUE),
            .groups = 'drop')  %>%
  as.data.frame()

## ggplot2 畫圖 溫室氣體氣象
ggplot()+
  geom_point(data=peanutGHG, aes(x=date, y=N2O_mean,shape=Trt,color=Trt))+
  geom_line(data=peanutGHG,aes(x=date,y=N2O_mean, linetype=Trt,color=Trt))+
  geom_errorbar(data=peanutGHG,aes(x=date,ymax=N2O_mean+N2O_sd, ymin=N2O_mean-N2O_sd))+
  geom_text(aes(x=fertPeanut[1],y=-50,label="F"),color="red")+
  geom_text(aes(x=fertPeanut[2],y=-50,label="F"),color="red")+
  geom_text(aes(x=irrigationEvent[1],y=-50,label="W"),color="blue")+
  geom_text(aes(x=irrigationEvent[2],y=-50,label="W"),color="blue")+
 labs(y=bquote(N2O~flux~"("~mu~g~m^-2~h^-1~")"))+
  theme_bw()+
  geom_linerange(data=wea,aes(x=date,ymin = 500-Rain, ymax=500),fill="blue")+
  scale_y_continuous( sec.axis = sec_axis(trans=~ (500- .)*1, name ="Rain (mm)"))

## ggplot2 無底線
ggplot(df)+
  geom_point(aes(x=headDW_mean,y=headDW*1e6*1e-4/6.6,shape=CropNo), size=3)+
  geom_errorbarh(aes(xmin=headDW_mean-headDW_sd, xmax=headDW_mean+headDW_sd, y=headDW*1e6*1e-4/6.6),height=1)+
  geom_abline(slope=1)+xlim(0,30)+ylim(0,30)+
  labs(x=bquote(Measured~head~dry~weight~"(g"~plant^-1*")"),
       y=bquote(Simulated~head~dry~weight~"(g"~plant^-1*")"))+  theme_bw()+
  theme(axis.line = element_line(color='black'),
    plot.background = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank())

## 設定點和線的樣式
LINES <- c("1" = "solid", "2" = "dotted", "3" = "longdash")

ggplot()+geom_point(data=data, aes(x=DAT,y=shoot_mean,shape=season))+
  scale_shape_manual(values=c(16, 17, 0))+
  geom_line(data=sim, aes(x=days,y=shootDW,linetype=season))+
  scale_linetype_manual(values = LINES)+
  labs(x="Days after transplanting",       
       y=bquote(Shoot~dry~weight~"("*g~plant^-1*")")) +
  theme_bw()+
  theme(axis.line = element_line(color='black'),
    plot.background = element_blank(),
    panel.grid.minor = element_blank(),
    panel.grid.major = element_blank())



# anova
library(agricolae)
anova <- aov(headFW_row~treat, data=data2)
summary(anova)
lsd <- LSD.test(anova, "treat")
plot(lsd)
print(lsd$groups)
