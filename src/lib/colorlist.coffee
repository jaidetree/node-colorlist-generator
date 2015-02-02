class ColorList
  ###
  Color List Class
  ###

  constructor: (table) ->
    @colors = []
    @makeListFrom(table)

  get: ->
    return @colors

  makeListFrom: (table) ->
    colors = table
    columns = colors.length
    rows = colors[0].length

    for row in [0..rows - 1]
      for column in [0..columns - 1]
        @colors.push colors[column][row]

    return @colors

  push: (color) ->
    @colors.push color

  pushRGB: (red=0, green=0, blue=0) ->
    @colors.push new RGBColor(red, green, blue)

  toArray: ->
    return @colors

  toString: ->
    colors = []

    for color in @colors
      color.push(color.toString())

    return colors
   
module.exports = ColorList 