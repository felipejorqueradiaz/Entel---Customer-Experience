library(data.table)
library(dplyr)
library(Hmisc)
library(ggplot2)
setwd("C:/Users/Felipe/Documents/GitHub/2021-1/Entel---Customer-Experience")
setwd("Data plana")

######   CHURN   ################
churn_fijo <- fread("5Churn/Churn Fijo.txt")
View(churn_fijo)
summary(churn_fijo)

#Dropeamos las columnas solo con NAs
churn_fijo <- churn_fijo %>%
  select(-c(OBSERVACION, ESTADO_OXT, TIPO_DE_SERVICIO))

#pairs(churn_fijo[,c('FACTURACION', 'ID_PRODUCTO_DEF')],upper.panel=panel.cor,diag.panel=panel.hist)
describe(churn_fijo)

churn_fijo <- churn_fijo %>%
  select(c(encriptado, Mes, ID_ESTADO_FACTURACION_PMF,DESC_MOVIMIENTO_ACCF,
           DESC_PRODUCTO_DEF, FACTURACION, TIPO_TRABAJO, FECHA_AR, FACT_CHURN_CODPRIN,
           SEGMENTO, SEGMENTO_
           ))

ggplot(churn_fijo, aes(x=factor(DESC_PRODUCTO_DEF), fill=factor(ID_PRODUCTO_DEF)))+
  geom_bar(stat="count")
ggplot(churn_fijo, aes(x=factor(EXISTE_CTA_CTE), fill=factor(FACT_CHURN_CODPRIN)))+
  geom_bar(stat="count")
ggplot(churn_fijo, aes(x=factor(CUENTA_FACT_OTRO_COD), fill=factor(FACT_CHURN_CODPRIN)))+
  geom_bar(stat="count")
ggplot(churn_fijo, aes(x=factor(SEGMENTO), fill=factor(SEGMENTO_)))+
  geom_bar(stat="count")

######   Churn Movil   ################
churn_movil <- fread("5Churn/Churn Movil.txt")
View(churn_movil)
describe(churn_movil)


churn_movil <- churn_movil %>%
  select(-c(CANAL_ATENCION,`AÑO VENTA`, `MES VENTA`))


churn_movil <- churn_movil %>%
  select(c(encriptado, ID_DIA, SEGMENTO, `SUB SEGMENTO`, NEGOCIO,
           MOVIMIENTO, `SUB MOVIMIENTO`, DESC_PLAN, TIPO_PLAN,
           MES, AÑO, CANAL_REASIGNADO))

######   Anulaciones   ################
anulaciones <- fread("8Anulaciones/Anulaciones.txt")
View(anulaciones)
describe(anulaciones)

anulaciones <- anulaciones %>%
  select(c(encriptado, FECHA_NEGOCIO, TIPONEGOCIO, DESC_TIPOCLIENTE,
           DESC_GRUPOCLIENTE, DESC_PLAN, TIPO_PLAN, Cargo_Fijo, GRUPO3,
           GRUPO4, CARGO_FIJO2))