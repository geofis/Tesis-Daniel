<!DOCTYPE qgis PUBLIC 'http://mrcc.com/qgis.dtd' 'SYSTEM'>
<qgis version="3.26.3-Buenos Aires" styleCategories="AllStyleCategories">
  <pipe>
    <rasterrenderer band="1" type="paletted" opacity="1" alphaBand="-1" nodataColor="">
      <rasterTransparency/>
      <minMaxOrigin>
        <limits>None</limits>
        <extent>WholeRaster</extent>
        <statAccuracy>Estimated</statAccuracy>
        <cumulativeCutLower>0.02</cumulativeCutLower>
        <cumulativeCutUpper>0.98</cumulativeCutUpper>
        <stdDevFactor>2</stdDevFactor>
      </minMaxOrigin>
      <colorPalette>
        <paletteEntry color="#282828" value="0" alpha="255" label="Desconocido. No hay datos"/>
        <paletteEntry color="#ffbb22" value="20" alpha="255" label="Arbustos"/>
        <paletteEntry color="#ffff4c" value="30" alpha="255" label="Vegetación herbácea"/>
        <paletteEntry color="#f096ff" value="40" alpha="255" label="Vegetación cultivada / agricultura"/>
        <paletteEntry color="#fa0000" value="50" alpha="255" label="Urbano o construido"/>
        <paletteEntry color="#b4b4b4" value="60" alpha="255" label="Vegetación escasa o desnuda"/>
        <paletteEntry color="#f0f0f0" value="70" alpha="255" label="Nieve y hielo"/>
        <paletteEntry color="#0032c8" value="80" alpha="255" label="Masas de agua permanentes"/>
        <paletteEntry color="#0096a0" value="90" alpha="255" label="Humedal herbáceo"/>
        <paletteEntry color="#00cf75" value="95" alpha="255" label="Manglares"/>
        <paletteEntry color="#fae6a0" value="100" alpha="255" label="Musgo y líquenes"/>
        <paletteEntry color="#58481f" value="111" alpha="255" label="Bosque cerrado, hoja acícula perenne"/>
        <paletteEntry color="#009900" value="112" alpha="255" label="Bosque cerrado, hoja ancha perenne"/>
        <paletteEntry color="#70663e" value="113" alpha="255" label="Bosque cerrado, hoja acícula decidua"/>
        <paletteEntry color="#00cc00" value="114" alpha="255" label="Bosque cerrado, follaje caduco ancho"/>
        <paletteEntry color="#4e751f" value="115" alpha="255" label="Bosque cerrado, mixto"/>
        <paletteEntry color="#007800" value="116" alpha="255" label="Bosque cerrado (otro)"/>
        <paletteEntry color="#666000" value="121" alpha="255" label="Bosque abierto, hoja acícula perenne"/>
        <paletteEntry color="#8db400" value="122" alpha="255" label="Bosque abierto, hoja ancha perenne"/>
        <paletteEntry color="#8d7400" value="123" alpha="255" label="Bosque abierto, hoja acícula decidua"/>
        <paletteEntry color="#a0dc00" value="124" alpha="255" label="Bosque abierto, follaje caduco ancho"/>
        <paletteEntry color="#929900" value="125" alpha="255" label="Bosque abierto, mixto"/>
        <paletteEntry color="#648c00" value="126" alpha="255" label="Bosque abierto (otro)"/>
        <paletteEntry color="#000080" value="200" alpha="255" label="Océanos y mares"/>
      </colorPalette>
      <colorramp type="randomcolors" name="[source]">
        <Option/>
      </colorramp>
    </rasterrenderer>
    <brightnesscontrast brightness="0" contrast="0" gamma="1"/>
    <huesaturation colorizeBlue="128" colorizeGreen="128" colorizeOn="0" colorizeRed="255"
                   colorizeStrength="100" grayscaleMode="0" invertColors="0" saturation="0"/>
    <rasterresampler maxOversampling="2"/>
    <resamplingStage>resamplingFilter</resamplingStage>
  </pipe>
  <blendMode>0</blendMode>
</qgis>

