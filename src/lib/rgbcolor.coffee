_f = require('util').format
class Color
  ###
  RGB
  Represents a single RGBColor
  ###

  constructor: (red, green, blue) ->
    @red = Number(red)
    @green = Number(green)
    @blue = Number(blue)

  darken: (percent) ->
    return @mixWith Black, percent

  lighten: (percent) ->
    return @mixWith White, percent

  mixWith: (color, percent) ->
    opacity = percent / 100
    red = parseInt((@red * opacity) + (color.red * (1 - opacity)), 10)
    green = parseInt((@green * opacity) + (color.green * (1 - opacity)), 10)
    blue = parseInt((@blue * opacity) + (color.blue * (1 - opacity)), 10)

    return new Color(red, green, blue)

  toArray: ->
    return [@red, @green, @blue]

  toString: ->
    return _f 'rgb(%s, %s, %s)', @red, @green, @blue

###
Create those Basic colors
###
White = new Color(255, 255, 255)
Black = new Color(0, 0, 0)
Grey = new Color(128, 128, 128)

module.exports =
  Color: Color
  White: White
  Black: Black
  Grey: Grey 