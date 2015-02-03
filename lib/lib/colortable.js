(function() {
  var ColorTable, RGB;

  RGB = require('./rgbcolor');

  ColorTable = (function() {

    /*
    Color Table Generator
     */
    function ColorTable(baseColors) {
      this.baseColors = baseColors;
    }

    ColorTable.prototype.build = function() {
      var base, column, columns, i, _i, _len, _ref;
      columns = [];
      _ref = this.baseColors;
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        base = _ref[i];
        column = this.generateColumn(base);
        if (i === 0) {
          i = -1;
        }
        column.unshift(RGB.White.darken((i + 1) * 10));
        columns.push(column);
      }
      return columns;
    };

    ColorTable.prototype.generateColumn = function(base) {
      var column;
      column = [];
      column.push(base);
      column = column.concat(this.generateTints(base));
      column = column.concat(this.generateShades(base));
      return column;
    };

    ColorTable.prototype.generateShades = function(base) {
      var shades;
      shades = [];
      shades.push(base.darken(30));
      shades.push(base.darken(50));
      shades.push(base.darken(70));
      return shades;
    };

    ColorTable.prototype.generateTints = function(base) {
      var tints;
      tints = [];
      tints.push(base.lighten(70));
      tints.push(base.lighten(50));
      tints.push(base.lighten(30));
      return tints;
    };

    ColorTable.prototype.toArray = function() {
      return this.build();
    };

    return ColorTable;

  })();

  module.exports = ColorTable;

}).call(this);
