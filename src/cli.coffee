_f = require('util').format
fs = require 'fs'
CSON = require 'cson'
minimist = require 'minimist'
path = require 'path'

ColorListGenerator = require './'
Output = require './lib/output'

class ColorListCLI
  constructor: (args) ->
    @args = args

  parseArgs: () ->
    input = null
    output = null
    args = minimist(@args)

    if not args._[0] or not typeof args._[0] == 'string'
      throw new Error('No --file <path> parameter specified!')

    input = path.join process.cwd(), args._[0]

    # Check for output file
    if args._[1]
      output = path.join process.cwd(), args._[1] || 'output/'

    return {} =
      inFile: input
      outDir: output

  run: ->
    @init()
    args = @parseArgs()
    input = @readInput(args.inFile)
    list = @generateColorList(input)

    if args.outDir
      @save(args.outDir, 'colorlist.html', @output('HTML', list))
      @save(args.outDir, 'colorlist.json', @output('JSON', list))
    else
      console.log "\n"
      console.log 'OUTPUT................................'
      process.stdout.write @output('JSON', list)
      console.log "\n"

    console.log '.................................Done.'

  init: ->
    console.log 'Starting color list generator.........'

  readInput: (file) ->
    console.log _f 'Reading CSON Input file: "%s" ', path.basename(file)
    return CSON.parseFileSync(file)

  generateColorList: (input) ->
    colors = new ColorListGenerator(input)
    colors.parseRGBData()
    console.log 'Generating color table................'
    colors.generateTable()
    console.log 'Converting table to an array..........'
    return colors.generateList()

  output: (className, list) ->
    return new Output[className](list).render()

  save: (dir, filename, output) ->
    try
      file = path.join(dir, filename)
      console.log _f('Saving %s', file)
      fs.writeFileSync file, output
    catch e
      console.log _f('Could not save to file "%s".', file)
      process.exit()

try
  new ColorListCLI(process.argv.slice(2)).run()
catch e
  console.log e