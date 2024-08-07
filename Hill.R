
# Cargar los datos desde el archivo RCEV.csv
ruta_archivo <- "C:/Users/jazmi/OneDrive/Documents/tesis-daniel/RCEV.csv"
datos <- read.csv(ruta_archivo)
library(dplyr)
library(vegan)
library(tidyr)
library(ggplot2)
Suponiendo que tus datos están en un data frame llamado 'datos'
# Aquí hay un ejemplo de cómo pueden verse tus datos
# datos <- data.frame(
#   Localidad = c("Loc1", "Loc1", "Loc2", "Loc2"),
#   Transecto = c("Tran1", "Tran1", "Tran2", "Tran2"),
#   Especies = c("Especie1", "Especie2", "Especie1", "Especie2"),
#   Abundancia = c(10, 15, 5, 20)
# )

# Calcular los Números de Hill
calcular_hill <- function(data) {
  # Crear una matriz de abundancias por especies
  matriz_abundancias <- data %>%
    group_by(Localidad, Especies) %>%
    summarize(Abundancia = sum(Abundancia), .groups = 'drop') %>%
    spread(Especies, Abundancia, fill = 0)
  
  # Eliminar la columna de Localidad para la matriz de abundancia
  localidades <- matriz_abundancias$Localidad
  matriz_abundancias <- matriz_abundancias %>% select(-Localidad)
  
  # Calcular los índices de diversidad
  H0 <- rowSums(matriz_abundancias > 0) # Riqueza de especies
  H1 <- exp(diversity(matriz_abundancias, index = "shannon")) # Exponencial del índice de Shannon
  H2 <- 1 / diversity(matriz_abundancias, index = "simpson") # Inverso del índice de Simpson
  
  return(data.frame(Localidad = localidades, H0 = H0, H1 = H1, H2 = H2))
}

# Calcular los números de Hill para tus datos
hill_results <- calcular_hill(datos)

# Imprimir resultados
print(hill_results)

# Transformar los resultados para graficar
hill_df_long <- gather(hill_results, key = "Indice", value = "Valor", -Localidad)

# Graficar los resultados
ggplot(hill_df_long, aes(x = Localidad, y = Valor, fill = Indice)) +
  geom_bar(stat = "identity", position = "dodge") +
  theme_minimal() +
  labs(title = "Números de Hill", x = "Localidad", y = "Valor del Índice") +
  scale_fill_manual(values = c("H0" = "blue", "H1" = "red", "H2" = "green")) +
  theme(plot.title = element_text(hjust = 0.5))