
import pandas as pd

# 寫給 sumTemp呼叫
def Tsum_beta_fn(t, t_o, t_c):
    t_b = 0
    beta = 1
    if (t <= t_b or t > t_c):
        return 0
    f = (t - t_b) / (t_o - t_b)
    g = (t_c - t) / (t_c - t_o)
    alpha = beta*(t_o - t_b) / (t_c - t_o)
    return pow(f, alpha)*pow(g, beta)*(t_o - t_b)

def selectWea(df, loc, date0str, date1str):
    # loc Erulun Mailiao
    # date0str datestr of first day dd/mm/yyyy
    # date0str datestr of first day dd/mm/yyyy
    df2 = df[df["Town"]==loc]
    hourstr = '10:00'
    date0str = date0str + '\t' + hourstr
    date1str = date1str + '\t' + hourstr
    df3 = df2[(df2['dateTime'] >= date0str) & (df2['dateTime'] <= date1str)]
    return df3

# 利用selectWea所計算的資料
def sumTemp(df, optT, ceilT):       
    tsum = 0
    for row in range(len(df)):
        tempH = wea.loc[row, "Temp"]
        tsum += Tsum_beta_fn(tempH, optT, ceilT)/24
    return tsum    

wea = pd.read_csv("wea/hourlyweather.csv")
wea['dateTime'] = pd.to_datetime(wea['dateTime'], format = '%m/%d/%Y %H:%M')
wea['Date'] = pd.to_datetime(wea['Date'])
# print(wea.dtypes)

wea2 = selectWea(wea,"Erlun","1/5/2017","3/18/2017")
test = sumTemp(wea2, 22,40)


