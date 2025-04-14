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
        <paletteEntry color="#006400" value="10" alpha="255" label="Cobertura arbórea"/>
        <paletteEntry color="#ffbb22" value="20" alpha="255" label="Arbustos"/>
        <paletteEntry color="#ffff4c" value="30" alpha="255" label="Pradera"/>
        <paletteEntry color="#f096ff" value="40" alpha="255" label="Tierras de cultivo"/>
        <paletteEntry color="#fa0000" value="50" alpha="255" label="Urbanizado"/>
        <paletteEntry color="#b4b4b4" value="60" alpha="255" label="Vegetación escasa o desnuda"/>
        <paletteEntry color="#f0f0f0" value="70" alpha="255" label="Nieve y hielo"/>
        <paletteEntry color="#0064c8" value="80" alpha="255" label="Masas de agua permanentes"/>
        <paletteEntry color="#0096a0" value="90" alpha="255" label="Humedal herbáceo"/>
        <paletteEntry color="#00cf75" value="95" alpha="255" label="Manglares"/>
        <paletteEntry color="#fae6a0" value="100" alpha="255" label="Musgo y líquenes"/>
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

