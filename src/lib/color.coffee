class D.Color
  # Generate a random color rgb triple
  # @return Array RGB color triple
  @randomRGB = () ->
    r = D.Util.randomInt(0, 255)
    g = D.Util.randomInt(0, 255)
    b = D.Util.randomInt(0, 255)
    [r, g, b]

  # Random RGBA Color Triple
  # @return array RGBA color triple
  @randomRGBA = () ->
    rgba = @randomRGB()
    # Add a random alpha channel float
    rgba.push(Math.random().toFixed(2))
    rgba

  # Convenience method for random hex colors
  # @return String Resulting hex color string
  @randomHexString = () ->
    Color.rgbToHex(Color.randomRGB())

  # Convert rgb to hex
  # @param rgb RGB Color triple
  # @return String Resulting hex color
  @rgbToHex = (rgb) ->
    hex = '#'
    hex += Math.floor(rgb[0]).toString(16)
    hex += Math.floor(rgb[1]).toString(16)
    hex += Math.floor(rgb[2]).toString(16)
    hex

  # Get a CSS-style rgb string from an rgb triple
  # @param Array rgb RGB color striple
  # @return String RGB String
  @rgbToString = (rgb) ->
    "rgb(#{rgb[0]}, #{rgb[1]}, #{rgba[2]})"

  # Get a CSS-style rgba string from an rgba triple
  # @param Array rgba RGBA color quad
  # @return String RGBA string
  @rgbaToString = (rgba) ->
    "rgba(#{rgba[0]}, #{rgba[1]}, #{rgba[2]}, #{rgba[3]})"