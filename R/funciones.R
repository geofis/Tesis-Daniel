evaluar_arbol <- function(arbol, num_optimo_por_anchsil) {
  # Verificar si hay grupos con 2 elementos o menos al cortar en el número óptimo
  grupos <- cutree(arbol, num_optimo_por_anchsil)
  tabla_grupos <- table(grupos)
  
  if (all(tabla_grupos > 2)) {
    return(paste(
      "Árbol útil para análisis posteriores, siempre que se corte en", num_optimo_por_anchsil, "grupos"))
  } else if (num_optimo_por_anchsil >= 3) {
    for (k in seq(num_optimo_por_anchsil, 2, by = -1)) {
      grupos <- cutree(arbol, k)
      tabla_grupos <- table(grupos)
      if (all(tabla_grupos > 2)) {
        return(paste("Árbol útil para análisis posteriores, siempre que se corte en", k, "grupos"))
      }
    }
    return("Árbol no recomendado para usarse por producir grupos compuestos por dos elementos o menos")
  } else {
    return("Árbol no recomendado para usarse por producir grupos compuestos por dos elementos o menos")
  }
}

seleccionar_y_cortar_arbol <- function(arbol_upgma, arbol_ward,
                                       resultado_evaluacion_upgma, resultado_evaluacion_ward) {
  # Redefinir función cutree
  cutree2 <- function(arbol, k) {factor(cutree(arbol, k), labels = LETTERS[1:k])}
  # Extraer el número de grupos sugerido de las cadenas de texto
  num_grupos_upgma <- suppressWarnings(as.numeric(sub(".*corte en (\\d+) grupos.*", "\\1", resultado_evaluacion_upgma)))
  num_grupos_ward <- suppressWarnings(as.numeric(sub(".*corte en (\\d+) grupos.*", "\\1", resultado_evaluacion_ward)))
  
  # Aplicar las reglas especificadas para determinar qué árbol cortar y en cuántos grupos
  if (resultado_evaluacion_upgma == "Árbol no recomendado para usarse por producir grupos compuestos por dos elementos o menos" && 
      resultado_evaluacion_ward == "Árbol no recomendado para usarse por producir grupos compuestos por dos elementos o menos") {
    return(list(
      decision = "Los árboles generados por los métodos UPGMA y Ward producen grupos compuestos por dos elementos o menos. Empleamos el agrupamiento Ward cortado en 3 grupos como último recurso",
      resultado = cutree2(arbol_ward, 3),
      metodo = 'Ward',
      arbol = arbol_ward,
      k = 3))
  } else if (resultado_evaluacion_upgma == "Árbol no recomendado para usarse por producir grupos compuestos por dos elementos o menos") {
    return(list(
      decision = paste("El árbol generado por el método UPGMA produce grupos compuestos por dos elementos o menos. Usamos el árbol generado por el método Ward cortado en", num_grupos_ward, "grupos\n"),
      resultado = cutree2(arbol_ward, num_grupos_ward),
      metodo = 'Ward',
      arbol = arbol_ward,
      k = num_grupos_ward))
  } else if (resultado_evaluacion_ward == "Árbol no recomendado para usarse por producir grupos compuestos por dos elementos o menos") {
    return(list(
      decision = paste("El árbol generado por el método Ward produce grupos compuestos por dos elementos o menos. Usamos el árbol generado por el método UPGMA cortado en", num_grupos_upgma, "grupos\n"),
      resultado = cutree2(arbol_upgma, num_grupos_upgma),
      metodo = 'UPGMA',
      arbol = arbol_upgma,
      k = num_grupos_upgma))
  } else if (!is.na(num_grupos_upgma) && !is.na(num_grupos_ward) && num_grupos_upgma == num_grupos_ward) {
    return(list(
      decision = paste("Los árboles generados por los métodos UPGMA y Ward no producen grupos compuestos por dos elementos o menos, y ambos podrían cortarse en el mismo número de grupos. Usamos el árbol generado por el método Ward cortado en", num_grupos_ward, "grupos\n"),
      resultado = cutree2(arbol_ward, num_grupos_ward),
      metodo = 'Ward',
      arbol = arbol_ward,
      k = num_grupos_ward))
  } else if (!is.na(num_grupos_upgma) && !is.na(num_grupos_ward)) {
    if (num_grupos_upgma < num_grupos_ward) {
      return(list(
        decision = paste("El árbol generado por el método UPGMA produce un número menor de grupos que el generado por el método Ward. Usamos el árbol generado por el método UPGMA cortado en", num_grupos_upgma, "grupos\n"),
        resultado = cutree2(arbol_upgma, num_grupos_upgma),
        metodo = 'UPGMA',
        arbol = arbol_upgma,
        k = num_grupos_upgma))
    } else {
      return(list(
        decision = paste("El árbol generado por el método Ward produce un número menor de grupos que el generado por el método Ward. Usamos el árbol generado por el método Ward cortado en", num_grupos_ward, "grupos\n"),
        resultado = cutree2(arbol_ward, num_grupos_ward),
        metodo = 'Ward',
        arbol = arbol_ward,
        k = num_grupos_ward))
    }
  }
}

estilo_kable <- function(df, titulo = '', cubre_anchura = F, nombres_filas = F, alinear = NULL) {
  df %>% kable(
    # format = 'latex',
    escape = F, booktabs = T, align = alinear,
    digits = 2, caption = titulo, row.names = nombres_filas) %>%
    kable_styling(bootstrap_options = c("hover", "condensed"),
                  latex_options = "HOLD_position",
                  full_width = cubre_anchura, position = "center") %>% 
    gsub(' NA ', '', .) %>% 
    gsub('_', '\\\\_', .)
}

estilo_kable_corto <- function(df, titulo = '', cubre_anchura = F, nombres_filas = F) {
  df %>%
    kable(format = 'html', escape = F, booktabs = T,
          digits = 2, caption = titulo, row.names = nombres_filas) %>%
    kable_styling(bootstrap_options = c("hover", "condensed"),
                  full_width = cubre_anchura) %>% 
    gsub(' NA ', '', .)
}


cleanplot.pca <- function(res.pca, ax1=1, ax2=2, scaling=2, plot.sites=TRUE, 
                          plot.spe=TRUE, label.sites=TRUE, label.spe=TRUE, cex.char1=0.7,
                          pos.sites=2, pos.spe=4, mult.spe=1, select.spe=NULL, 
                          mar.percent=0.1, optimum=TRUE, move.origin=c(0,0), silent=TRUE)
  # FUENTE: https://raw.githubusercontent.com/zdealveindy/anadat-r/master/scripts/NumEcolR2/cleanplot.pca.R
  # A function to draw a triplot (scaling 1 or scaling 2) from an object 
  # of class "rda" containing RDA result from vegan's rda() function.
  #
  # ARGUMENTS
  #
  # ##### General parameters
  # res.pca          An rda{vegan} object.
  # ax1, ax2         Canonical axes to be drawn as abscissa and ordinate. Defaults: 1 and 2.
  # site.sc          Can be set to "lc" (linear constraints or model scores, default) 
  #                  or "wa" (weighted averages, default in vegan).
  # scaling          Scaling type: only 1 or 2 are supported. Default: 2.
  #
  # ##### Items to be plotted
  # plot.sites       If TRUE, the sites will be plotted as small circles.
  # plot.spe         If TRUE, the species (or other response variables) will be plotted.
  # label.sites      If TRUE, labels are added to the site symbols.
  # label.spe        If TRUE, labels are added to the species arrows.
  # label.env        If TRUE, labels are added to the environmental variable arrows.
  # label.centr      If TRUE, labels are added to the centroids of factor levels.
  # cex.char1        Character size (for sites and response variables).
  #
  # ##### Label positions
  # ## Positions: 1=below the point, 2=left, 3=above, 4=right. Default: 4.
  # ## Note - Argument pos=NULL centres the label on the position of the object (site point,  
  # ## species or environmental variable arrow, centroid) when the object is not drawn.
  # pos.sites        Position of site labels. 1 to 4, as above. Default: 2.
  # pos.spe          Position of species labels. 1 to 4, as above. Default: 4.
  #
  # ##### Multipliers, selection of species to be plotted
  # mult.spe         Multiplier for length of the species arrows. Default: 1.
  # select.spe       Vector containing a selection of the species numbers to be drawn in 
  #                  the biplot, e.g. c(1,2,5,8,12). Draw all species if select.spe=NULL 
  #                  (default value). The species that are well represented in the RDA plot 
  #                  can be identified using goodness(RDA.output.object,display="species")
  #
  # ##### Position of the plot in frame, margins
  # mar.percent      Factor to expand plot size to accomodate all items and labels. Positive 
  #                  values increase the margins around the plot, negative values reduce 
  #                  them.
  # optimum          If TRUE, the longest species and environmental arrows are stretched to 
  #                  a length equal to the distance to the origin of the site farthest from 
  #                  the origin in the plot of (ax1,ax2). This is an optimal combined 
  #                  representation of the three elements. The lengths of the species and 
  #                  environmental arrows can be further modified using the arguments 
  #                  mult.spe and mult.arrow.
  # move.origin      Move plot origin right-left and up-down. Default: move.origin=c(0,0).
  #                  Ex. move.origin=c(-1,0.5) moves origin by 1 unit left and 0.5 unit up.
  #
  # ##### Varia
  # silent           If FALSE, intermediate computation steps are printed. Default: TRUE.
  #
  # # Example 1 - Table 11.3 of Legendre & Legendre (2012, p. 644), first 6 species only
  #
  # Y.mat = matrix(c(1,0,0,11,11,9,9,7,7,5,0,0,1,4,5,6,7,8,9,10,0,0,0,0,17,0,13,0,10,0,0, 
  # 0,0,0,7,0,10,0,13,0,0,0,0,8,0,6,0,4,0,2,0,0,0,1,0,2,0,3,0,4),10,6)
  # Depth = 1:10
  # Sub. = as.factor(c(rep(1,3),4,2,4,2,4,2,4))
  # env = cbind(data.frame(Depth),data.frame(Sub.))
  # 
  # rda.out = rda(Y.mat~ .,env)
  # 
  # # Scaling=1
  # par(mfrow=c(1,2))
  # triplot.rda(rda.out, scaling=1, mar.percent=0)
  # triplot.rda(rda.out, scaling=1, move.origin=c(5,-5), mar.percent=-0.1)
  #
  # # Scaling=2
  # par(mfrow=c(1,2))
  # triplot.rda(rda.out, scaling=2, mar.percent=0.15, silent=FALSE)
  # triplot.rda(rda.out, scaling=2, move.origin=c(0.4,-0.25), mar.percent=0.05,silent=FALSE)
  #
  # # Example 2 - Dune data
  # 
  # library(vegan)
  # data(dune)
  # data(dune.env)
  # 
  # rda.dune = rda(dune ~ .,dune.env)
  # 
  # tmp = goodness(rda.dune)
  # ( sp.sel = which(tmp[,2] >= 0.4) )
  #
  # Scaling=2
  # par(mfrow=c(1,2))
  # triplot.rda(rda.dune, mar.percent=0)
  # triplot.rda(rda.dune, select.spe=sp.sel, move.origin=c(-0.3,0), mar.percent=0.1)
  #
  # #####
#
# License: GPL-2 
# Authors: Francois Gillet, Daniel Borcard & Pierre Legendre, 2016
{
  ### Internal functions
  #
  'stretch' <- 
    function(sites, mat, ax1, ax2, n, silent=silent) {
      # Compute stretching factor for the species arrows
      # First, compute the longest distance to centroid for the sites
      tmp1 <- rbind(c(0,0), sites[,c(ax1,ax2)])
      D <- dist(tmp1)
      target <- max(D[1:n])
      # Then, compute the longest distance to centroid for the species arrows
      if(any(class(mat) %in% "matrix")) {
        p <- nrow(mat)   # Number of species to be drawn
        tmp2 <- rbind(c(0,0), mat[,c(ax1,ax2)])
        D <- dist(tmp2)
        longest <- max(D[1:p])
      } else { tmp2 <- rbind(c(0,0), mat[c(ax1,ax2)]) 
      longest <- dist(tmp2)
      # print(tmp2)
      }  # If a single row left in 'mat'
      #
      if(!silent) cat("target =",target," longest =",longest," fact =",target/longest,"\n")
      fact <- target/longest
    }
  #
  'larger.plot' <- 
    function(sit.sc, spe.sc, percent, move.origin, ax1, ax2) {
      # Internal function to expand plot limits (adapted from code by Pierre Legendre)
      mat <- rbind(sit.sc, spe.sc)
      range.mat <- apply(mat, 2, range)
      rownames(range.mat) <- c("Min","Max")
      z <- apply(range.mat, 2, function(x) x[2]-x[1])
      range.mat[1,] <- range.mat[1,]-z*percent
      range.mat[2,] <- range.mat[2,]+z*percent
      if(move.origin[1] != 0) range.mat[,ax1] <- range.mat[,ax1] - move.origin[1]
      if(move.origin[2] != 0) range.mat[,ax2] <- range.mat[,ax2] - move.origin[2]
      range.mat
    }
  ### End internal functions
  
  if(!class(res.pca)[1]=="rda") stop("The input file is not a vegan output object of class 'rda'", call.=FALSE)
  if(scaling!=1 & scaling!=2) stop("Function only available for scaling = 1 or 2", call.=FALSE)
  
  k <- length(res.pca$CA$eig)         # n. of PCA eigenvalues
  n.sp <- length(res.pca$colsum)      # n. of species
  ahead <- 0.05   # Length of arrow heads
  aangle <- 30    # Angle of arrow heads
  # 'vec' will contain the selection of species to be drawn
  if(is.null(select.spe)){ vec <- 1:n.sp } else { vec <- select.spe }
  
  # Scaling 1: the species scores have norms of 1
  # Scaling 1: the site scores are scaled to variances = can.eigenvalues
  # Scaling 2: the species scores have norms of sqrt(can.eigenvalues)
  # Scaling 2: the site scores are scaled to variances of 1
  # --------------------------------------------------------------------
  
  ### This version reconstructs and uses the original RDA output of L&L 2012, Section 11.1.3
  
  Tot.var = res.pca$tot.chi        # Total variance in response data Y
  eig.val = res.pca$CA$eig         # Eigenvalues of Y-hat
  Lambda = diag(eig.val)           # Diagonal matrix of eigenvalues
  eig.val.rel = eig.val/Tot.var    # Relative eigenvalues of Y-hat
  Diag = diag(sqrt(eig.val.rel))   # Diagonal matrix of sqrt(relative eigenvalues)
  U.sc1 = res.pca$CA$v             # Species scores, scaling=1
  U.sc2 = U.sc1 %*% Lambda^(0.5)   # Species scores, scaling=2
  n = nrow(res.pca$CA$u)           # Number of observations
  Z.sc2 = res.pca$CA$u*sqrt(n-1)   # Site scores, scaling=2
  Z.sc1 = Z.sc2 %*% Lambda^(0.5)   # Site scores, scaling=1
  #
  if(is.null(select.spe)){ vec <- 1:n.sp } else { vec <- select.spe }
  #
  if(scaling==1) {
    sit.sc <- Z.sc1
    spe.sc <- U.sc1[vec,]
  } else {          # For scaling=2
    sit.sc <- Z.sc2
    spe.sc <- U.sc2[vec,]
  }
  if(is.null(rownames(sit.sc))) rownames(sit.sc) <- paste("Site",1:n,sep="")
  if(is.null(rownames(spe.sc))) rownames(spe.sc) <- paste("Sp",1:n.sp,sep="")
  #
  fact.spe <- 1
  if(optimum) {
    fact.spe <- stretch(sit.sc[,1:k], spe.sc[,1:k], ax1, ax2, n, silent=silent)
  }
  if(!silent) cat("fac.spe =",fact.spe,"\n\n")
  spe.sc <- spe.sc*fact.spe*mult.spe
  #
  lim <- larger.plot(sit.sc[,1:k], spe.sc[,1:k], percent=mar.percent, move.origin=move.origin, ax1=ax1, ax2=ax2)
  if(!silent) print(lim)
  
  ### Drawing the biplot begins ###
  ###
  # Draw the main plot
  mat <- rbind(sit.sc[,1:k], spe.sc[,1:k])
  plot(mat[,c(ax1,ax2)], type="n", main=paste("Biplot PCA, escalamiento", scaling), xlim=c(lim[1,ax1], lim[2,ax1]), ylim=c(lim[1,ax2], lim[2,ax2]), 
       xlab=paste("PCA ",ax1), ylab=paste("PCA ",ax2), asp=1)
  abline(h=0, v=0, col="grey60")
  
  # Draw the site scores
  if(plot.sites) {
    points(sit.sc[,ax1], sit.sc[,ax2], pch=20)
    if(label.sites)
      text(sit.sc[,ax1], sit.sc[,ax2], labels = rownames(sit.sc), col="black", pos=pos.sites, cex=cex.char1)
  } else {
    if(label.sites)
      text(sit.sc[,ax1], sit.sc[,ax2], labels = rownames(sit.sc), col="black", pos=NULL, cex=cex.char1)
  }
  
  # Draw the species scores
  if(plot.spe) {
    arrows(0, 0, spe.sc[,ax1], spe.sc[,ax2], length=ahead, angle=aangle, col="red")
    if(label.spe)
      text(spe.sc[,ax1], spe.sc[,ax2], labels = rownames(spe.sc), col="red", pos=pos.spe, cex=cex.char1)
  } else {
    if(label.spe)
      text(spe.sc[,ax1], spe.sc[,ax2], labels = rownames(spe.sc), col="red", pos=NULL, cex=cex.char1)
  }
  
  # If scaling=1 draw circle of equilibrium contribution
  #  if(scaling==1 | (scaling==2 & circle2)){
  if(scaling==1){
    pcacircle(res.pca, mult.spe=mult.spe, fact.spe=fact.spe, silent=silent)
  }
}

vector_a_lista <- function(vec) {
  n <- length(vec)
  if (n == 0) {
    return("")
  } else if (n == 1) {
    return(as.character(vec))
  } else if (n == 2) {
    return(paste(vec, collapse = " y "))
  } else {
    last <- paste("y", vec[n])
    rest <- paste(vec[1:(n-1)], collapse = ", ")
    return(paste(rest, last))
  }
}

crear_grafico_mosaico_de_mc <- function(mc, tam_rotulo = 12){
  library(dplyr)
  library(tidyr)
  library(ggplot2)
  para_gg <- mc %>%
    rownames_to_column('transecto') %>%
    mutate(transecto = factor(transecto)) %>%
    mutate(transecto = fct_relevel(transecto, gtools::mixedsort(levels(transecto)))) %>%
    gather(familia, abundancia, -transecto) %>%
    mutate(familia = factor(familia)) %>% 
    mutate(transectonum = as.numeric(factor(transecto)))
  p <- ggplot(
    para_gg,
    aes(x = familia, y = transectonum, fill = abundancia, label = abundancia)) +
    geom_tile(col='black') +
    scale_fill_gradient(
      trans = 'log1p',
      low = "white",
      high = "red") +
    geom_text(size = tam_rotulo/4) +
    scale_y_continuous(#For duplicate axis
      breaks = unique(para_gg$transectonum),
      labels = levels(para_gg$transecto),
      sec.axis = dup_axis()) +
    ylab('Transecto') + xlab('Especie') +
    theme_bw() +
    theme(
      legend.position="none",
      text = element_text(size = tam_rotulo),
      panel.background = element_rect(fill = 'white', colour = 'black'),
      panel.grid.major = element_line(colour = "grey", linetype = "dashed", size = 0.25),
      axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1),
      axis.text = element_text(colour="black")) + 
    coord_equal()
  return(p)
}
