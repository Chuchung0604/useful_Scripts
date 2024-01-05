# 日期格式設定
Sys.setlocale("LC_TIME","English")

# Julian days to Date
CH4$Date

# 坐標軸
y=bquote(Nitrous~oxide~emmision~"(g"~N~ha^-1~d^-1~")"))


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
