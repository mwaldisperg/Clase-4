library(tidyverse)

#gráfico de puntos con tema clásico muy parecido a los que se usan en papers
data("mtcars")
ggplot(mtcars, aes(x=wt, y=mpg))+geom_point()+theme_classic()

#Colorear segun una columna la gráfica de puntos
data("ChickWeight")
View(ChickWeight)
ggplot(ChickWeight, aes(x=Time, y=weight))+geom_point(aes(color=Diet))+theme_classic()
ggplot(ChickWeight, aes(x=Time, y=weight))+geom_point(color="red")+theme_classic()

#transparencia para ver puntos que se superponen (0 es transparente, 1 es sólido), pero se puede poner que la transparencia dependa de una variable poniendo su nombre en vez de 0.1
ggplot(ChickWeight, aes(x=Time, y=weight))+geom_point(aes(color=Diet), alpha=0.1)+theme_classic()

#el tamaño del punto se va a grandando con el peso del pollo
ggplot(ChickWeight, aes(x=Time, y=weight))+geom_point(aes(color=Diet, size=weight))+theme_classic()

#cambiar la forma de los puntos para la variable dieta
ggplot(ChickWeight, aes(x=Time, y=weight))+geom_point(aes(color=Diet, shape=Diet))+theme_classic()

#hacer boxplot y cambiar el color de la linea del borde y el color del relleno
data("iris")
ggplot(iris,aes(x=Species,y=Petal.Length))+geom_boxplot(aes(color=Species,fill=Species))

#muestra el numero de muestras por especie
ggplot(iris,aes(x=Species,y=Petal.Length))+geom_jitter(aes(color=Species))

#nos indica un grafico tipo espejo que nos muestra la distribucion de los datos (si es normal o no) y coord_flip cambia el eje
ggplot(iris,aes(x=Species,y=Petal.Length))+geom_violin()+coord_flip()

#se pueden juntar mas de un formato de grafico, pero es importante el orden en que se ingresan!!
ggplot(iris,aes(x=Species,y=Sepal.Width))+geom_violin()+geom_jitter()
ggplot(iris,aes(x=Species,y=Sepal.Width))+geom_jitter()+geom_violin(alpha=0)

#grafico donde los puntos son hexagonos
data(diamonds)
ggplot(diamonds, aes(x=carat,y=price))+geom_hex() ####

#grafico con linea de tendencia e intervalo de confianza del 95% segun la variable dieta, con el metodo lineal
ggplot(ChickWeight, aes(x=Time, y=weight))+geom_point(aes(color=Diet))+geom_smooth(aes(color=Diet,fill=Diet), method = "lm")

#Hay que ver cual es tu directorio, despues setearlo a donde está tu archivo y llamarlo directamente por su nombre
getwd()
setwd("C:/Users/Usuario MSI/Desktop/segundo semestre 2018/Curso R 1/Clase 4")
TempHum<-read_rds("TempHum.rds")
PA<-TempHum %>% filter(Ciudad_localidad=="Punta Arenas")
View(PA)
ggplot(PA,aes(x=Mes,y=TempMedia))+geom_point()
ggplot(PA,aes(x=Mes,y=TempMedia))+geom_point()+geom_smooth(method="lm")

#fórmulas para la linea de tendencia
ggplot(PA,aes(x=Mes,y=TempMedia))+geom_point()+stat_smooth(method="lm",formula=y~x)
#I te permite hacer operaciones dentro de un codigo
ggplot(PA,aes(x=Mes,y=TempMedia))+geom_point()+stat_smooth(method="lm",formula=y~I(x^2))

#CTRL+ALT+más = ~
#CTRL+ALT+tilde = ^

PA2<- PA %>% gather(key=Unidad,value=Medida, HumMedia,TempMedia)
View(PA2)
ggplot(PA2, aes(x=Mes,y=Medida))+geom_point(aes(color=Unidad))+stat_smooth(method="lm",formula=y~I(x^2)+x,aes(fill=Unidad))
ggplot(PA2, aes(x=Mes,y=Medida))+geom_point(aes(color=Unidad))+stat_smooth(method="lm",formula=y~I(x^2)+x,aes(fill=Unidad))+ scale_x_continuous(2,4,8), labels=c("Ene","Abr","Ago") ##

#generar una grilla de graficas por localidad
ggplot(PA2, aes(x=Mes,y=Medida))+geom_point(aes(color=Unidad))+stat_smooth(method="lm",formula=y~I(x^2)+x,aes(fill=Unidad))+facet_wrap(~ Ciudad_localidad, ncol = 2)
