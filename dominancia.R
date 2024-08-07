# Cargar los datos desde el archivo RCEV.csv
ruta_archivo <- "C:/Users/jazmi/OneDrive/Documents/tesis-daniel/RCEV.csv"
datos <- read.csv(ruta_archivo)

# Definir función para calcular el Índice de Dominancia de Simpson
calcular_dominancia <- function(abundancia) {
  # Suma de cuadrados de los recuentos de especies
  suma_cuadrados <- sum(abundancia^2)
  
  # Total de individuos
  total_individuos <- sum(abundancia)
  
  # Índice de Dominancia de Simpson
  dominancia <- suma_cuadrados / (total_individuos^2)
  
  return(dominancia)
}

# Calcular la dominancia para cada localidad
dominancia_por_localidad <- aggregate(datos$Abundancia, by=list(Localidad=datos$Localidad), FUN=calcular_dominancia)

# Renombrar columnas
colnames(dominancia_por_localidad) <- c("Localidad", "Indice_Dominancia")

# Mostrar el resultado
print(dominancia_por_localidad)

library(ggplot2)

## Graficar la dominancia por localidad
ggplot(dominancia_por_localidad, aes(x=Localidad, y=Indice_Dominancia, fill=Indice_Dominancia)) +
  geom_bar(stat="identity") +
  scale_fill_gradient(low = "lightblue", high = "darkblue") +
  labs(title="Dominancia de especies por localidad",
       x="Localidad", y="Índice de Dominancia") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +
  guides(fill = guide_legend(title = "Índice de Dominancia"))

ruta_archivo <- "C:/Users/jazmi/OneDrive/Documents/tesis-daniel/RCEV.csv"
datos <- read.csv(ruta_archivo)

library(heatmaply)

# Definir una función para calcular la distancia de Jaccard
calcular_distancia_jaccard <- function(matriz_binaria) {
  n <- nrow(matriz_binaria)
  distancia_jaccard <- matrix(NA, n, n)
  
  for (i in 1:(n - 1)) {
    for (j in (i + 1):n) {
      # Calcular el numerador (número de especies compartidas)
      numerador <- sum(matriz_binaria[i, ] & matriz_binaria[j, ])
      
      # Calcular el denominador (número de especies presentes en al menos una de las localidades)
      denominador <- sum(matriz_binaria[i, ] | matriz_binaria[j, ])
      
      # Calcular la distancia de Jaccard
      distancia_jaccard[i, j] <- 1 - (numerador / denominador)
      distancia_jaccard[j, i] <- distancia_jaccard[i, j]
    }
  }
  
  # Llenar la diagonal con ceros
  diag(distancia_jaccard) <- 0
  
  return(distancia_jaccard)
}

# Agregar prefijo único a los nombres duplicados
rownames(datos_binarios) <- make.unique(as.character(datos$Localidad))
colnames(datos_binarios) <- make.unique(as.character(datos$Localidad))

# Calcular la matriz de distancia de Jaccard
matriz_similitud_jaccard <- calcular_distancia_jaccard(datos_binarios)

# Graficar el mapa de calor de la matriz de similitud de Jaccard
heatmaply(matriz_similitud_jaccard, 
          symmetric = TRUE, # Indica si la matriz es simétrica (en este caso, sí)
          labRow = rownames(datos_binarios), # Etiquetas de las filas
          labCol = colnames(datos_binarios), # Etiquetas de las columnas
          main = "Mapa de Calor de Similitud (Distancia de Jaccard)")