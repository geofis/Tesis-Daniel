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
        <paletteEntry color="#141414" value="11" alpha="255" label="Pico o cresta (cálido)"/>
        <paletteEntry color="#383838" value="12" alpha="255" label="Pico o cresta"/>
        <paletteEntry color="#808080" value="13" alpha="255" label="Pico o cresta (frío)"/>
        <paletteEntry color="#ebeb8f" value="14" alpha="255" label="Montaña o divisoria"/>
        <paletteEntry color="#f7d311" value="15" alpha="255" label="Acantilado"/>
        <paletteEntry color="#aa0000" value="21" alpha="255" label="Pendiente superior (caliente)"/>
        <paletteEntry color="#d89382" value="22" alpha="255" label="Pendiente superior"/>
        <paletteEntry color="#ddc9c9" value="23" alpha="255" label="Pendiente superior (suave)"/>
        <paletteEntry color="#dccdce" value="24" alpha="255" label="Pendiente superior (plana)"/>
        <paletteEntry color="#1c6330" value="31" alpha="255" label="Pendiente inferior (cálida)"/>
        <paletteEntry color="#68aa63" value="32" alpha="255" label="Pendiente inferior"/>
        <paletteEntry color="#b5c98e" value="33" alpha="255" label="Pendiente inferior (suave)"/>
        <paletteEntry color="#e1f0e5" value="34" alpha="255" label="Pendiente inferior (plana)"/>
        <paletteEntry color="#a975ba" value="41" alpha="255" label="Un valle"/>
        <paletteEntry color="#6f198c" value="42" alpha="255" label="Valle (angosto)"/>
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

