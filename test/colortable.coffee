_f = require('util').format
assert = require 'assert'
RGB = require '../src/lib/rgbcolor'
ColorTable = require '../src/lib/colortable'

Data =
  Set1: [
    new RGB.Color(255, 255, 255)
    new RGB.Color(150, 150, 150)
    new RGB.Color(100, 100, 100)
    new RGB.Color(50, 50, 50)
    new RGB.Color(0, 0, 0)
  ]

describe 'ColorTable', ->
  describe '#constructor()', ->
    it 'should create a ColorTable object', ->
      table = new ColorTable
      assert.equal table instanceof ColorTable, true, 'new ColorTable was not an instance of Color Table'

  describe '#build()', ->
    it 'should produce an array of columns', ->
      table = new ColorTable Data.Set1
      output = table.build()

      assert.equal output instanceof Array, true, 'build() did not produce an array'
      assert.equal output.length, 5, _f('build() did not produce 5 columns, was "%s"', output.length)
      assert.equal output[0].length, 8, _f('build() did not produce 8 rows, was "%s"', output[0].length)

  describe '#toArray()', ->
    it 'should produce an array of columns', ->
      table = new ColorTable Data.Set1
      output = table.toArray()

      assert.equal output instanceof Array, true, 'toArray() did not produce an array'
      assert.equal output.length, 5, _f('toArray() did not produce 5 columns, was "%s"', output.length)
      assert.equal output[0].length, 8, _f('toArray() did not produce 8 rows, was "%s"', output[0].length)

