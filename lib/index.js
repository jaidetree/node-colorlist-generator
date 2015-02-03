(function() {
  var ColorList, ColorListGenerator, ColorTable, RGB;

  RGB = require('./lib/rgbcolor');

  ColorList = require('./lib/colorlist');

  ColorTable = require('./lib/colortable');

  ColorListGenerator = (function() {

    /*
    The star of the show...
     */
    function ColorListGenerator(data) {
      this.data = data;
    }

    ColorListGenerator.prototype.generateList = function() {
      return new ColorList(this.data).build();
    };

    ColorListGenerator.prototype.generateTable = function() {
      this.data = new ColorTable(this.data).build();
      return this.data;
    };

    ColorListGenerator.prototype.parseRGBData = function() {

      /*
      Parses a JSON Array of RGB values and converts them into RGB.Color objects
       */
      var color, colors, _i, _len, _ref;
      colors = [];
      _ref = this.data;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        color = _ref[_i];
        colors.push(new RGB.Color(color[0], color[1], color[2]));
      }
      return this.data = colors;
    };

    return ColorListGenerator;

  })();

  module.exports = ColorListGenerator;

}).call(this);
