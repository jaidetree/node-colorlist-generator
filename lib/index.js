(function() {
  var ColorList, ColorListGenerator, ColorTable, Output, RGB;

  RGB = require('./lib/rgbcolor');

  ColorList = require('./lib/colorlist');

  ColorTable = require('./lib/colortable');

  Output = require('./lib/output');

  ColorListGenerator = (function() {

    /*
    The star of the show...
     */
    function ColorListGenerator(data) {
      this.loadData(data);
    }

    ColorListGenerator.prototype.generate = function() {
      var colors, table;
      console.log('Generating color table................');
      table = new ColorTable(this.data);
      console.log('Converting table to an array..........');
      colors = new ColorList(table.build());
      console.log('Saving HTML...........................');
      new Output.HTML('colorlist.html', colors.toArray()).save();
      console.log('Saving JSON...........................');
      new Output.JSON('colors.json', colors.toArray()).save();
      return console.log('Done!');
    };

    ColorListGenerator.prototype.parseRGBData = function(data) {

      /*
      Parses a JSON Array of RGB values and converts them into RGB.Color objects
       */
      var color, colors, _i, _len;
      colors = [];
      for (_i = 0, _len = data.length; _i < _len; _i++) {
        color = data[_i];
        colors.push(new RGB.Color(color[0], color[1], color[2]));
      }
      return colors;
    };

    ColorListGenerator.prototype.loadData = function(data) {
      return this.data = this.parseRGBData(data);
    };

    return ColorListGenerator;

  })();

  module.exports = ColorListGenerator;

}).call(this);
