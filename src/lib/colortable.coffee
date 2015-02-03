RGB = require './rgbcolor'
class ColorTable
  ###
  Color Table Generator
  ###

  constructor: (baseColors) ->
    @baseColors = baseColors

  build: ->
    columns = []

    for base, i in @baseColors
      # Create a column
      column = @generateColumn base
      # Put a monochromatic color at the top of the column
      if i == 0
        i = -1
      column.unshift RGB.White.darken((i + 1) * 10)
      columns.push column

    return columns

  generateColumn: (base) ->
    column = []
    column.push base
    column = column.concat @generateTints(base)
    column = column.concat @generateShades(base)
    return column

  generateShades: (base) ->
    shades = []
    shades.push base.darken(30)
    shades.push base.darken(50)
    shades.push base.darken(70)
    return shades

  generateTints: (base) ->
    tints = []
    tints.push base.lighten(70)
    tints.push base.lighten(50)
    tints.push base.lighten(30)
    return tints

  toArray: ->
    return @build()

module.exports = ColorTable