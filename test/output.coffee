_f = require('util').format
assert = require 'assert'
Output = require '../src/lib/output'
RGB = require '../src/lib/rgbcolor'

Data =
  Colors: [
    new RGB.Color(255, 0, 0)
    new RGB.Color(0, 255, 0)
    new RGB.Color(0, 0, 255)
  ],
  File: 'testfile.html'

describe 'Output Class', ->
  describe 'HTMLOutput < Output', ->
    describe '#constructor()', ->
      it 'should produce an HTMLOutput', ->
        formatter = new Output.HTML('testfile.html', Data.Colors)
        assert.equal formatter instanceof Output.HTML, true, 'new HTMLOutput did not produce an instance of HTMLOutput'

    describe '#render()', ->
      it 'should render HTML', ->
        formatter = new Output.HTML('testfile.html', Data.Colors)
        output = formatter.render()
        assert.equal output.indexOf('class="color"') > -1, true, _f('Could not find any class="color" in the HTML: %s', output)

  describe 'JSONOutput < Output', ->
    describe '#constructor()', ->
      it 'should produce an JSONOutput', ->
        formatter = new Output.JSON('testfile.json', Data.Colors)
        assert.equal formatter instanceof Output.JSON, true, 'new JSONOutput did not produce an instance of JSONOutput'

    describe '#render()', ->
      it 'should render JSON', ->
        formatter = new Output.JSON('testfile.html', Data.Colors)
        output = formatter.render()
        assert.equal typeof output, 'string', _f('JSON output was not a string, was "%s"', output)
        assert.equal output, '[[255,0,0],[0,255,0],[0,0,255]]', _f('JSON String is not right, was "%s"', output)
