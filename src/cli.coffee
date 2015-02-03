_f = require('util').format
CSON = require 'cson'
path = require 'path'

ColorListGenerator = require './'

run = ->
  try
    args = require('minimist')(process.argv.slice(2))

    if not args._[0] or not typeof args._[0] == 'string'
      throw new Error('No --file <path> parameter specified!')

    file = args._[0]
    console.log _f('Reading CSON Input file: "%s" ', file)
    file = path.join path.dirname(__dirname), 'input', file

    colorListGenerator = new ColorListGenerator CSON.parseFileSync(file)
    colorListGenerator.generate()

  catch e
    console.log e

run()