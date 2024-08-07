
# Cargar los datos desde el archivo RCEV.csv
ruta_archivo <- "C:/Users/jazmi/OneDrive/Documents/tesis-daniel/RCEV.csv"
datos <- read.csv(ruta_archivo)
# Instalar y cargar las librerías necesarias

library(heatmaply)

# Definir una función para calcular la similitud de Jaccard entre tres localidades específicas
calcular_similitud_jaccard_tres_localidades <- function(datos, localidad1, localidad2, localidad3) {
  # Obtener los datos de las tres localidades
  datos_localidades <- datos[datos$Localidad %in% c(localidad1, localidad2, localidad3), ]
  
  # Obtener las especies únicas en las tres localidades
  especies <- unique(datos_localidades$Especies)
  
  # Crear una matriz binaria de presencia/ausencia para las especies en las tres localidades
  datos_binarios <- matrix(0, nrow = 3, ncol = length(especies))
  rownames(datos_binarios) <- c(localidad1, localidad2, localidad3)
  colnames(datos_binarios) <- especies
  
  for (i in 1:nrow(datos_localidades)) {
    localidad <- datos_localidades[i, "Localidad"]
    especie <- datos_localidades[i, "Especies"]
    abundancia <- datos_localidades[i, "Abundancia"]
    datos_binarios[localidad, especie] <- ifelse(abundancia > 0, 1, 0)
  }
  
  # Calcular la similitud de Jaccard entre las tres localidades
  similitud_jaccard <- matrix(NA, nrow = 3, ncol = 3)
  for (i in 1:2) {
    for (j in (i+1):3) {
      numerador <- sum(datos_binarios[i,] & datos_binarios[j,])
      denominador <- sum(datos_binarios[i,] | datos_binarios[j,])
      similitud_jaccard[i,j] <- numerador / denominador
      similitud_jaccard[j,i] <- similitud_jaccard[i,j]
    }
  }
  
  return(similitud_jaccard)
}

# Calcular la similitud de Jaccard entre las tres localidades específicas
similitud_jaccard_tres_localidades <- calcular_similitud_jaccard_tres_localidades(datos, "Casabito", "Manaclar", "Arroyazo")

# Crear el mapa de calor utilizando heatmaply
heatmaply(similitud_jaccard_tres_localidades, 
          symmetric = TRUE, 
          labRow = c("Casabito", "Manaclar", "Arroyazo"),
          labCol = c("Casabito", "Manaclar", "Arroyazo"),
          main = "Mapa de Calor de Similitud de Jaccard entre Localidades",
          col = c("red", "orange", "green"))


######
# Cargar los datos desde el archivo RCEV.csv
ruta_archivo <- "C:/Users/jazmi/OneDrive/Documents/tesis-daniel/RCEV.csv"
datos <- read.csv(ruta_archivo)

# Instalar y cargar las librerías necesarias
if (!requireNamespace("heatmaply", quietly = TRUE)) {
  install.packages("heatmaply")
}
library(heatmaply)

# Definir una función para calcular la similitud de Jaccard entre tres localidades específicas
calcular_similitud_jaccard_tres_localidades <- function(datos, localidad1, localidad2, localidad3) {
  # Obtener los datos de las tres localidades
  datos_localidades <- datos[datos$Localidad %in% c(localidad1, localidad2, localidad3), ]
  
  # Obtener las especies únicas en las tres localidades
  especies <- unique(datos_localidades$Especies)
  
  # Crear una matriz binaria de presencia/ausencia para las especies en las tres localidades
  datos_binarios <- matrix(0, nrow = 3, ncol = length(especies))
  rownames(datos_binarios) <- c(localidad1, localidad2, localidad3)
  colnames(datos_binarios) <- especies
  
  for (i in 1:nrow(datos_localidades)) {
    localidad <- datos_localidades[i, "Localidad"]
    especie <- datos_localidades[i, "Especies"]
    abundancia <- datos_localidades[i, "Abundancia"]
    datos_binarios[localidad, especie] <- ifelse(abundancia > 0, 1, 0)
  }
  
  # Calcular la similitud de Jaccard entre las tres localidades
  similitud_jaccard <- matrix(NA, nrow = 3, ncol = 3)
  for (i in 1:2) {
    for (j in (i+1):3) {
      numerador <- sum(datos_binarios[i,] & datos_binarios[j,])
      denominador <- sum(datos_binarios[i,] | datos_binarios[j,])
      similitud_jaccard[i,j] <- numerador / denominador
      similitud_jaccard[j,i] <- similitud_jaccard[i,j]
    }
  }
  
  return(similitud_jaccard)
}

# Calcular la similitud de Jaccard entre las tres localidades específicas
similitud_jaccard_tres_localidades <- calcular_similitud_jaccard_tres_localidades(datos, "Casabito", "Manaclar", "Arroyazo")

# Crear el mapa de calor utilizando heatmaply con paleta de colores RColorBrewer
heatmaply(similitud_jaccard_tres_localidades, 
          symmetric = TRUE, 
          labRow = c("Casabito", "Manaclar", "Arroyazo"),
          labCol = c("Casabito", "Manaclar", "Arroyazo"),
          main = "Mapa de Calor de Similitud de Jaccard entre Localidades",
          col = colorRampPalette(brewer.pal(n = 7, name = "YlOrRd"))(100),  # Usar paleta YlOrRd de RColorBrewer
          fontsize_row = 12,   # Tamaño de fuente para las etiquetas de fila
          fontsize_col = 12,   # Tamaño de fuente para las etiquetas de columna
          showticklabels = TRUE,  # Mostrar etiquetas en los ejes
          limits = c(0, 1),    # Límites del colorbar
          na.rm = TRUE         # Eliminar valores NA si los hay
)

)
