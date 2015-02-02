_f = require('util').format
args = require('minimist')(process.argv.slice(2))
cheerio = require 'cheerio'
fs = require 'fs'
path = require 'path'

print = console.log
###
# Color Table Generator
# Generates an array of colors
###

class ColorList
  constructor: (options) ->
    @colors = new RGBColorList()

  generateShades: ->
    return

  generateRow: (min, max, steps, callback) ->
    for x in [min..max] by max / steps
      x = parseInt(x, 10)

      @colors.push callback(x)
  
  build: ->
    # Generate a row from black to white
    @generateRow 0, 256, 7, (x) ->
       return new RGBColor(x, x, x)

    # Generate base red colors
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(x, 0, 0)

    # Generate base red colors
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(0, x, 0)

    # Generate base green colors
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(0, 0, x)

    # Generate red + green
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(x, x, 0)

    # Generate red + blue
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(x, 0, x)

    # Generate green + blue
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(0, x, x)

    # Generate Red Tints
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(255, x, x)

    # Generate Green Tints
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(x, 255,  x)

    # Generate Blue Tints
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(x, x, 255)
    
    return @colors.get()

class ColorParser
  constructor: ->
    @colors = new RGBColorList()

  parse: (markup) ->
    $ = cheerio.load markup
    $('.jfk-palette-colorswatch').each (index, el) =>
      @parseColor el

  parseColor: (el) ->
    $ = cheerio.load(el)
    style = el.attribs.style
    color = style.match /([\d]+)/g
    @colors.push new RGBColor(color[0], color[1], color[2])

  build: ->
    return @colors.get()


class RGBColorList
  constructor: () ->
    @colors = []

  push: (color) ->
    @colors.push color

  pushRGB: (red=0, green=0, blue=0) ->
    @colors.push new RGBColor(red, green, blue)

  get: ->
    return @colors

  toString: ->
    colors = []

    for color in @colors
      color.push(color.toString())

    return colors
    

class RGBColor
  constructor: (red, green, blue) ->
    @red = Number(red)
    @green = Number(green)
    @blue = Number(blue)

  toArray: ->
    return [@red, @green, @blue]

  toString: ->
    return _f 'rgb(%s, %s, %s)', @red, @green, @blue

class Output
  constructor: (file, colors) ->
    @file = file
    @colors = colors

  save: (result) ->
    filename = path.join(path.dirname(__dirname), 'output/' + @file)
    fs.writeFileSync filename, result


class HTMLOutput extends Output
  html: '''
    <!doctype HTML>
    <html>
      <head>
        <title>Color Table Results</title>
        <style>
          div.color {
            width: 100px;
            height: 20px;
            border: 1px solid #000;
            font-size: 0;
            float: left;
          }
          div.color:nth-child(10n + 1) {
            clear: left;
          }
        </style>
      </head>
      <body>
        <h1>Generated %s Colors</h1>
        <div class="colors">
          %s
        </div>
      </body>
    </html>
    '''

  constructor: (file, colors) ->
    @file = file
    @colors = colors

  render: ->
    result = _f @html, @colors.length, @renderColors()
    @save result

  renderColors: ->
    html = ''
    template = '<div class="color" style="background-color: %s">%s</div>'

    for color in @colors
      html += _f template, color, color
      html += "\n"

    return html


class ArrayOutput extends Output
  render: ->
    colors = []

    for color in @colors
      colors.push color.toArray()

    @save JSON.stringify(colors)

print 'Generating color table.....'

print 'Reading ', args._[0], '.....'

filename = path.join path.dirname(__dirname), 'input', args._[0]

markup = fs.readFileSync filename,
  encoding: 'utf8'


# list = new ColorList()
list = new ColorParser();
list.parse(markup);

colors = list.build()

# print colors

# Try really hard
try
  print 'saving..........'
  new HTMLOutput('colorlist.html', colors).render()
  new ArrayOutput('colors.json', colors).render()
  print 'Done!'
catch e
  print e
  
