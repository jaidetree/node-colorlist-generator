(function() {
  var Black, Color, Grey, White, _f;

  _f = require('util').format;

  Color = (function() {

    /*
    RGB
    Represents a single RGBColor
     */
    function Color(red, green, blue) {
      if (red instanceof Array) {
        this.set(red);
      } else {
        this.set([red, green, blue]);
      }
    }

    Color.prototype.set = function(rgb) {

      /*
      Sets the properties and cleans them
       */
      this.red = this._clean(rgb[0]);
      this.green = this._clean(rgb[1]);
      return this.blue = this._clean(rgb[2]);
    };

    Color.prototype.darken = function(percent) {
      return this.mixWith(Black, 100 - percent);
    };

    Color.prototype.lighten = function(percent) {

      /*
      Mixes color with white by percentage
       */
      return this.mixWith(White, 100 - percent);
    };

    Color.prototype.mixWith = function(color, percent) {

      /*
      Mixes 2 colors together by a percent (int)
       */
      var blue, green, opacity, red;
      opacity = percent / 100;
      red = parseInt((this.red * opacity) + (color.red * (1 - opacity)), 10);
      green = parseInt((this.green * opacity) + (color.green * (1 - opacity)), 10);
      blue = parseInt((this.blue * opacity) + (color.blue * (1 - opacity)), 10);
      return new Color(red, green, blue);
    };

    Color.prototype.toArray = function() {

      /*
      Return this color back as an array
       */
      return [this.red, this.green, this.blue];
    };

    Color.prototype.toString = function() {

      /*
      Use node.util.format to convert it into an rgb string
       */
      return _f('rgb(%s, %s, %s)', this.red, this.green, this.blue);
    };

    Color.prototype._clean = function(input) {

      /*
      Private method to make sure the value is a number and is less than 255 but
      greater than 0
       */
      input = Number(input);
      input = Math.max(0, input);
      input = Math.min(255, input);
      return input;
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
