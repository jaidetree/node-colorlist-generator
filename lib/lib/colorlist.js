(function() {
  var ColorList;

  ColorList = (function() {

    /*
    Color List Class
     */
    function ColorList(table) {
      this.colors = [];
      this.makeListFrom(table);
    }

    ColorList.prototype.get = function() {
      return this.colors;
    };

    ColorList.prototype.makeListFrom = function(table) {
      var colors, column, columns, row, rows, _i, _j, _ref, _ref1;
      colors = table;
      columns = colors.length;
      rows = colors[0].length;
      for (row = _i = 0, _ref = rows - 1; 0 <= _ref ? _i <= _ref : _i >= _ref; row = 0 <= _ref ? ++_i : --_i) {
        for (column = _j = 0, _ref1 = columns - 1; 0 <= _ref1 ? _j <= _ref1 : _j >= _ref1; column = 0 <= _ref1 ? ++_j : --_j) {
          this.colors.push(colors[column][row]);
        }
      }
      return this.colors;
    };

    ColorList.prototype.push = function(color) {
      return this.colors.push(color);
    };

    ColorList.prototype.pushRGB = function(red, green, blue) {
      if (red == null) {
        red = 0;
      }
      if (green == null) {
        green = 0;
      }
      if (blue == null) {
        blue = 0;
      }
      return this.colors.push(new RGBColor(red, green, blue));
    };

    ColorList.prototype.toArray = function() {
      return this.colors;
    };

    ColorList.prototype.toString = function() {
      var color, colors, _i, _len, _ref;
      colors = [];
      _ref = this.colors;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        color = _ref[_i];
        color.push(color.toString());
      }
      return colors;
    };

    return ColorList;

  })();

  module.exports = ColorList;

}).call(this);
