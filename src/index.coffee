RGB = require './lib/rgbcolor'
ColorList = require './lib/colorlist'
ColorTable = require './lib/colortable'

class ColorListGenerator
  ###
  The star of the show...
  ###
  constructor: (data) ->
    @data = data

  generateList: ->
    return new ColorList(@data).build()

  generateTable:  ->
    @data = new ColorTable(@data).build()
    return @data
    
  parseRGBData: ->
    ###
    Parses a JSON Array of RGB values and converts them into RGB.Color objects
    ###
    colors = []

    for color in @data
      colors.push new RGB.Color(color[0], color[1], color[2])

    @data = colors

module.exports = ColorListGenerator
