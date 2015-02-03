_f = require('util').format
class Color
  ###
  RGB
  Represents a single RGBColor
  ###

  constructor: (red, green, blue) ->
    if red instanceof Array
      # If red is an array then the input we got was a color array
      @set(red)
    else
      # Otherwise it is this way
      @set([red, green, blue])

  set: (rgb) ->
    ###
    Sets the properties and cleans them
    ###
    @red = @_clean(rgb[0])
    @green = @_clean(rgb[1])
    @blue = @_clean(rgb[2])


  darken: (percent) ->
    return @mixWith Black, 100 - percent

  lighten: (percent) ->
    ###
    Mixes color with white by percentage
    ###
    return @mixWith White, 100 - percent

  mixWith: (color, percent) ->
    ###
    Mixes 2 colors together by a percent (int)
    ###
    opacity = percent / 100
    red = parseInt((@red * opacity) + (color.red * (1 - opacity)), 10)
    green = parseInt((@green * opacity) + (color.green * (1 - opacity)), 10)
    blue = parseInt((@blue * opacity) + (color.blue * (1 - opacity)), 10)

    return new Color(red, green, blue)

  toArray: ->
    ###
    Return this color back as an array
    ###
    return [@red, @green, @blue]

  toString: ->
    ###
    Use node.util.format to convert it into an rgb string
    ###
    return _f 'rgb(%s, %s, %s)', @red, @green, @blue

  _clean: (input) ->
    ###
    Private method to make sure the value is a number and is less than 255 but
    greater than 0
    ###
    input = Number(input)
    input = Math.max(0, input)
    input = Math.min(255, input)
    return input


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