library(Benchmarking)
library(readxl)
library(tibble)
library(writexl)


#LIMPIEZA Y CARGA DE DATOS
data <- read_excel("data2.xlsx", sheet = 1)



colnames(data)[1] <- "INSTITUCIONES"
colnames(data)[2] <- "Profesorado"
colnames(data)[3] <- "Matricula"
colnames(data)[4] <- "Egreso"
colnames(data)[5] <- "Titulacion"
colnames(data)[6] <- "Programas"
colnames(data)[7] <- "SNI"



rownames(data)[1:45] <- 1:45

data [data == "-"] <- 0




#View(data)
data<- transform(data, Profesorado=as.numeric(Profesorado), Matricula=as.numeric(Matricula), Egreso=as.numeric(Egreso), Titulacion=as.numeric(Titulacion)
                 , Programas=as.numeric(Programas), SNI=as.numeric(SNI))
data[is.na(data)] <- 0


data
#Eficiencia 
v_Inputs <- with(data, cbind(Profesorado, Matricula)) #entradas
u_Outputs <- with(data, cbind(Egreso, Titulacion, SNI, Programas))  #salidas
universidades <- dea(v_Inputs, u_Outputs, SLACK = TRUE, DUAL = TRUE, RTS = "crs", ORIENTATION = "in")
RES <- data.frame(data$INSTITUCIONES, data$Profesorado, universidades$eff)

x <- universidades$eff
names(x) <- data$INSTITUCIONES
x <- sort(x)
barplot(x)



write_xlsx(RES,"C:\\Users\\super\\OneDrive\\Escritorio\\PRMC\\RESULTADOSDER.xlsx")
