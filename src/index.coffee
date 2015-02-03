RGB = require './lib/rgbcolor'
ColorList = require './lib/colorlist'
ColorTable = require './lib/colortable'
Output = require './lib/output'


class ColorListGenerator
  ###
  The star of the show...
  ###
  constructor: (data) ->
    @loadData data

  generate: ->
    # Initialize
    console.log 'Generating color table................'

    # Create our color table
    table = new ColorTable(@data)

    console.log 'Converting table to an array..........'
    colors = new ColorList(table.build())

    console.log('Saving HTML...........................')
    new Output.HTML('colorlist.html', colors.toArray()).save()

    console.log('Saving JSON...........................')
    new Output.JSON('colors.json', colors.toArray()).save()

    console.log 'Done!'
    
  parseRGBData: (data) ->
    ###
    Parses a JSON Array of RGB values and converts them into RGB.Color objects
    ###
    colors = []

    for color in data
      colors.push new RGB.Color(color[0], color[1], color[2])

    return colors

  loadData: (data) ->
    @data = @parseRGBData data

module.exports = ColorListGenerator
