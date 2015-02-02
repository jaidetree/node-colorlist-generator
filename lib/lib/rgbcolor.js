(function() {
  var Black, Color, Grey, White, _f;

  _f = require('util').format;

  Color = (function() {

    /*
    RGB
    Represents a single RGBColor
     */
    function Color(red, green, blue) {
      this.red = Number(red);
      this.green = Number(green);
      this.blue = Number(blue);
    }

    Color.prototype.darken = function(percent) {
      return this.mixWith(Black, percent);
    };

    Color.prototype.lighten = function(percent) {
      return this.mixWith(White, percent);
    };

    Color.prototype.mixWith = function(color, percent) {
      var blue, green, opacity, red;
      opacity = percent / 100;
      red = parseInt((this.red * opacity) + (color.red * (1 - opacity)), 10);
      green = parseInt((this.green * opacity) + (color.green * (1 - opacity)), 10);
      blue = parseInt((this.blue * opacity) + (color.blue * (1 - opacity)), 10);
      return new Color(red, green, blue);
    };

    Color.prototype.toArray = function() {
      return [this.red, this.green, this.blue];
    };

    Color.prototype.toString = function() {
      return _f('rgb(%s, %s, %s)', this.red, this.green, this.blue);
    };

    return Color;

  })();


  /*
  Create those Basic colors
   */

  White = new Color(255, 255, 255);

  Black = new Color(0, 0, 0);

  Grey = new Color(128, 128, 128);

  module.exports = {
    Color: Color,
    White: White,
    Black: Black,
    Grey: Grey
  };

}).call(this);
