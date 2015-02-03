_f = require('util').format
path = require 'path'

###
Output Classes
Responsible for formatting the color lists in various formats.
###

class Output
  ###
  Base Output Class
  ###
  constructor: (colors) ->
    @colors = colors

class HTMLOutput extends Output
  ###
  HTML Output Subclass
  ###

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

  constructor: (file, colors, html) ->
    super file, colors
    if html
      @html = html

  render: ->
    return _f @html, @colors.length, @renderColors()

  renderColors: ->
    html = ''
    template = '<div class="color" style="background-color: %s">%s</div>'

    for color in @colors
      html += _f template, color, color
      html += "\n"

    return html


class JSONOutput extends Output
  ###
  Array Output Subclass
  ###

  render: ->
    colors = []

    for color in @colors
      colors.push color.toArray()

    return JSON.stringify(colors)

module.exports =
  HTML: HTMLOutput
  JSON: JSONOutput

