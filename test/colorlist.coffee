_f = require('util').format
assert = require 'assert'
ColorList = require '../src/lib/colorlist'
RGB = require '../src/lib/rgbcolor'

Data =
  Set1: [[
    new RGB.Color 255, 255, 255
    new RGB.Color 200, 200, 200
    new RGB.Color 100, 100, 100
    new RGB.Color 0, 0, 0
  ]]

describe 'ColorList', ->
  describe '#constructor', ->
    it 'should produce a colorlist', ->
      list = new ColorList Data.Set1
      assert.equal list instanceof ColorList, true, 'new ColorList did not produce a ColorList...somehow'

  describe '#toArray()', ->
    it 'should convert a table into an array', ->
      list = new ColorList Data.Set1
      output = list.toArray()
      assert.equal output.length, 4, _f('Color list did not return a list of 4 colors: %s', output.toString())
      assert.deepEqual output, Data.Set1[0], _f('Color list did not return a list of RGB Colors', output.toString())

  describe '#toString()', ->
    it 'should produce a string of strings', ->
      list = new ColorList Data.Set1
      output = list.toString()
      assert.equal typeof output, 'string', _f('toString() did not produce a string value, was "%s"', output)
