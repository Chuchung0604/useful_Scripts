# -*- coding: utf-8 -*-
"""
Created on Tue Oct 21 14:57:02 2025

@author: ccchen
"""
import pandas as pd
import csv

def readWea( weatype, year, lon,lat, doy):
    if year %4 == 0:
        yearNo = 366
    else:
        yearNo = 365
       
    value = []    
    # path of first year
    filename = "G:/SynologyDrive/weather/網格化觀測日資料_5km/觀測_日資料_臺灣_%s/觀測_日資料_臺灣_%s_%d.csv" %(
        weatype, weatype, year)
    

    # read weather of first year
    with open(filename, newline='') as csvfile:
        df = csv.reader(csvfile, delimiter = ',')
        next(df) # skip header
        for row in df:
            if float(row[0]) == lon and float(row[1]) == lat:  
                value =row[doy+2-1]
    return value


wea = pd.read_csv("TARIweather.csv", skiprows=1, encoding="big5")

for index, row in wea.iterrows():
    year = row['Year']
    DOY = row['DOY']
    
    if pd.isnull(row["Tavg"]):         
        print(year, DOY, "Tavg")
        temp = readWea(weatype="平均溫", year=year, lon=120.7, lat=24.0, doy = DOY)
        wea.loc[index, 'Tavg']  = temp

    if pd.isnull(row["Tmax"]):         
        print(year, DOY, "Tmax")
        temp = readWea(weatype="最高溫", year=year, lon=120.7, lat=24.0, doy= DOY)
        wea.loc[index, 'Tmax']  = temp
    
    if pd.isnull(row["Tmin"]):         
        print(year, DOY)
        temp = readWea(weatype="最低溫", year=year, lon=120.7, lat=24.0, doy=DOY)
        wea.loc[index, 'Tmin']  = temp
   
wea.to_csv("TARIwea_fill.csv", header=True)    
