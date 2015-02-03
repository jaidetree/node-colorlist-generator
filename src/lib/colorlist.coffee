class ColorList
  ###
  Color List Class
  ###

  constructor: (table) ->
    @table = table
    @colors = []

  build: ->
    return @makeListFrom(@table)

  makeListFrom: (table) ->
    colors = table
    columns = colors.length
    rows = colors[0].length

    for row in [0..rows - 1]
      for column in [0..columns - 1]
        @colors.push colors[column][row]

    return @colors

  toArray: ->
    return @build()

  toString: ->
    colors = []

    for color in @colors
      colors.push(color.toString())

    return colors.join("\n")
   
module.exports = ColorList