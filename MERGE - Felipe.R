library(data.table)
library(dplyr)
library(Hmisc)
library(ggplot2)
library(tidyr)
library(lubridate)
setwd("C:/Users/Felipe/Documents/GitHub/2021-1/Entel---Customer-Experience")
setwd("Data plana")

f1 <- fread("7Facturacion/Fijo/Fact Fijo 2019-1.txt")
f2 <- fread("7Facturacion/Fijo/Fact Fijo 2019-2.txt")
f3 <- fread("7Facturacion/Fijo/Fact Fijo 2019-3.txt")
f4 <- fread("7Facturacion/Fijo/Fact Fijo 2020-1.txt")
f5 <- fread("7Facturacion/Fijo/Fact Fijo 2020-2.txt")

churn_fijo <- fread("5Churn/Churn Fijo.txt")
facturacion_fijo <- rbind(f1, f2, f3, f4, f5)


churn_fijo <- churn_fijo %>%
  select(c(encriptado, Mes, ID_ESTADO_FACTURACION_PMF,DESC_MOVIMIENTO_ACCF,
           DESC_PRODUCTO_DEF, FACTURACION, TIPO_TRABAJO, FECHA_AR, FACT_CHURN_CODPRIN,
           SEGMENTO, SEGMENTO_
  ))

churn_fijo <- churn_fijo %>%
  rename(
    MES = Mes,
    PRODUCTO = DESC_PRODUCTO_DEF
  ) %>%
  group_by(encriptado, MES, PRODUCTO) %>%
  summarise(MONTO = sum(FACTURACION)) %>%
  mutate(CHURN_FIJO = 1, FECHA=(MES*100)+1)

churn_fijo$FECHA<-as.Date(as.character(churn_fijo$FECHA),format="%Y%m%d")

facturacion_fijo <- facturacion_fijo %>%
  group_by(encriptado, MES, PRODUCTO) %>%
  summarise(MONTO_F = sum(MONTO_NETO)) %>%
  mutate(FECHA=(MES*100)+1)

facturacion_fijo$FECHA<-as.Date(as.character(facturacion_fijo$FECHA),format="%Y%m%d")


cruce <- merge(x = facturacion_fijo, y = churn_fijo,
               by = c("encriptado", "MES", 'PRODUCTO'), all.x = TRUE)
View(cruce)
cruce <- cruce %>%
  replace_na(list(CHURN_FIJO = 0))
