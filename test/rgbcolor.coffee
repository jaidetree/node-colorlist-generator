_f = require('util').format
assert = require 'assert'
RGB = require '../src/lib/rgbcolor'

describe 'RGBColor', ->
  describe '#constructor()', ->
    it 'should create an RGB.Color object', ->
      color = new RGB.Color(255, 255, 255)
      assert.equal color instanceof RGB.Color, true, 'Color was not an RGB.Color object'

    it 'should have red, green, and blue properties', ->
      color = new RGB.Color(50, 100, 200)
      assert.equal color.red, 50, _f('Color.red was not 50, was "%s"')
      assert.equal color.green, 100, _f('Color.green was not 100, was "%s"')
      assert.equal color.blue, 200, _f('Color.green was not 200, was "%s"')

  describe '#toArray()', ->
    it 'should produce an array', ->
      color = new RGB.Color(200, 100, 50)
      output = color.toArray()
      assert.equal output instanceof Array, true, 'Color.toArray did not produce an array'
      assert.equal output.length, 3, 'Color.toArray did not produce an array of 3 items'
      assert.deepEqual output, [200, 100, 50], 'Color.toArray did not match [200, 100, 50]'

  describe '#toString()', ->
    it 'should return a string', ->
      color = new RGB.Color(200, 100, 50)
      output = color.toString()

      assert.equal output, 'rgb(200, 100, 50)'

  describe '#darken()', ->
    it 'should generate a new color', ->
      color = new RGB.Color(255, 255, 255)
      output = color.darken(10)

      assert.equal output instanceof RGB.Color, true, 'Output of darken() was not a color'
      assert.notDeepEqual output, color, 'Darken 10% should not produce the same color as the original'

    it 'should generate a darker color', ->
      color = new RGB.Color(255, 255, 255)
      actual = color.darken(10)
      expected = color.toArray()

      assert.notDeepEqual actual.toArray(), expected, _f('Result of darken 10% to white should not be white, was "%s"', actual)
      assert.equal actual.red, 229, _f('10% darker red should be 229 not "%s"', actual.red)
      assert.equal actual.green, 229, _f('10% darker green should be 229 not "%s"', actual.green)
      assert.equal actual.blue, 229, _f('10% darker blue should be 229 not "%s"', actual.blue)

  describe '#lighten()', ->
    it 'should generate a new color', ->
      color = new RGB.Color(0, 0, 0)
      output = color.lighten(10)

      assert.equal output instanceof RGB.Color, true, 'Output of lighten() was not a color'
      assert.notDeepEqual output, color, 'lighten 10% should not produce the same color as the original'

    it 'should generate a lighter color', ->
      color = new RGB.Color(0, 0, 0)
      actual = color.lighten(10)
      expected = color.toArray()

      assert.notDeepEqual actual.toArray(), expected, 'Result of lighten 10% to black should not be black'
      assert.equal actual.red, 25, _f('10% lighter red should be 25 not "%s"', actual.red)
      assert.equal actual.green, 25, _f('10% lighter green should be 25 not "%s"', actual.green)
      assert.equal actual.blue, 25, _f('10% lighter blue should be 25 not "%s"', actual.blue)
      
