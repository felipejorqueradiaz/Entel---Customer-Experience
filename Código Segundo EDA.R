library(data.table)
library(dplyr)
library(Hmisc)
library(ggplot2)
setwd("C:/Users/Felipe/Documents/GitHub/2021-1/Entel---Customer-Experience")
setwd("Data plana")
path="C:/Users/Felipe/Documents/GitHub/2021-1/Entel---Customer-Experience/Plots/Felipe"
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

png(width=800, height=360)
ggplot(churn_fijo, aes(x=FACTURACION, fill=SEGMENTO, color=SEGMENTO))+
  geom_histogram()+
  labs(title="Facturaci�n por segmento de cliente",y ="Cantidad", x = "Facturaci�n")+
  theme(text = element_text(size = 16), plot.title = element_text(hjust = 0.5))+
  scale_fill_brewer(palette="RdYlBu")+
  scale_color_brewer(palette="RdYlBu")+
  ggsave(path=path, filename="churn_fijo$FACTURACION.png", dpi=360)

churn_fijo2 <- churn_fijo %>%
  filter(FACTURACION <=100000, FACTURACION >0)

png(width=800, height=360)
ggplot(churn_fijo2, aes(x=FACTURACION, fill=SEGMENTO, color=SEGMENTO))+
  geom_histogram()+
  labs(title="Facturaci�n (mayor a 0 y menor igual a 100000) por segmento de cliente",y ="Cantidad", x = "Facturaci�n")+
  theme(text = element_text(size = 16), plot.title = element_text(hjust = 0.5))+
  scale_fill_brewer(palette="RdYlBu")+
  scale_color_brewer(palette="RdYlBu")+
  ggsave(path=path, filename="churn_fijo2$FACTURACION.png", dpi=360)

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
  select(-c(CANAL_ATENCION,`A�O VENTA`, `MES VENTA`))


churn_movil <- churn_movil %>%
  select(c(encriptado, ID_DIA, SEGMENTO, `SUB SEGMENTO`, NEGOCIO,
           MOVIMIENTO, `SUB MOVIMIENTO`, DESC_PLAN, TIPO_PLAN,
           MES, A�O, CANAL_REASIGNADO))




######   Anulaciones   ################
anulaciones <- fread("8Anulaciones/Anulaciones.txt")
View(anulaciones)
describe(anulaciones)

anulaciones <- anulaciones %>%
  select(c(encriptado, FECHA_NEGOCIO, TIPONEGOCIO, DESC_TIPOCLIENTE,
           DESC_GRUPOCLIENTE, DESC_PLAN, TIPO_PLAN, Cargo_Fijo, GRUPO3,
           GRUPO4, CARGO_FIJO2))

###### Cambios de Plan ################
c1 <- fread("6Cambios de Plan/Cambios de plan 1.txt")
c2 <- fread("6Cambios de Plan/Cambios de plan 2.txt")
c3 <- fread("6Cambios de Plan/Cambios de plan 3.txt")

cambios <- rbind(c1, c2, c3)

View(cambios)
describe(cambios)
cambios <- cambios %>%
  select(c(encriptado, DESC_PLAN_ORIGEN, DESC_SERVICIO, TIPO_CUOTA,
           FECHA_SOLICITUD, ARPU, SEGMENTO, SUBSEGMENTO))


###### Facturaci�n Fijo ################
f1 <- fread("7Facturacion/Fijo/Fact Fijo 2019-1.txt")
f2 <- fread("7Facturacion/Fijo/Fact Fijo 2019-2.txt")
f3 <- fread("7Facturacion/Fijo/Fact Fijo 2019-3.txt")
f4 <- fread("7Facturacion/Fijo/Fact Fijo 2020-1.txt")
f5 <- fread("7Facturacion/Fijo/Fact Fijo 2020-2.txt")

facturacion_fijo <- rbind(f1, f2, f3, f4, f5)

View(facturacion_fijo)
describe(facturacion_fijo)

png(width=800, height=360)
ggplot(facturacion_fijo, aes(x=MONTO_NETO, fill=SUBSEGMENTO_BUN, color=SUBSEGMENTO_BUN))+
  geom_histogram()+
  labs(title="Facturaci�n por segmento de cliente",y ="Cantidad", x = "Facturaci�n")+
  theme(text = element_text(size = 16), plot.title = element_text(hjust = 0.5))+
  scale_fill_brewer(palette="RdYlBu")+
  scale_color_brewer(palette="RdYlBu")+
  ggsave(path=path, filename="facturacion_fijo$FACTURACION.png", dpi=360)

facturacion_fijo2 <- facturacion_fijo %>%
  filter(MONTO_NETO>1000, MONTO_NETO<25000)

png(width=800, height=360)
ggplot(facturacion_fijo2, aes(x=MONTO_NETO, fill=SUBSEGMENTO_BUN, color=SUBSEGMENTO_BUN))+
  geom_histogram()+
  labs(title="Facturaci�n por segmento de cliente",y ="Cantidad", x = "Facturaci�n")+
  theme(text = element_text(size = 16), plot.title = element_text(hjust = 0.5))+
  scale_fill_brewer(palette="RdYlBu")+
  scale_color_brewer(palette="RdYlBu")+
  ggsave(path=path, filename="facturacion_fijo2$FACTURACION.png", dpi=360)

###### Facturaci�n Movil ################
f1 <- fread("7Facturacion/Movil/Fact Movil 2019-1.txt")
f2 <- fread("7Facturacion/Movil/Fact Movil 2019-2.txt")
f3 <- fread("7Facturacion/Movil/Fact Movil 2020-1.txt")
f4 <- fread("7Facturacion/Movil/Fact Movil 2020-2.txt")

facturacion_movil <- rbind(f1, f2, f3, f4)

View(facturacion_movil)
describe(facturacion_movil)
