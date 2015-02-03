(function() {
  var HTMLOutput, JSONOutput, Output, fs, path, _f,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __hasProp = {}.hasOwnProperty;

  _f = require('util').format;

  path = require('path');

  fs = require('fs');


  /*
  Output Classes
  Responsible for formatting the color lists in various formats.
   */

  Output = (function() {

    /*
    Base Output Class
     */
    function Output(file, colors) {
      this.file = file;
      this.colors = colors;
    }

    Output.prototype.save = function() {
      var filename, result;
      result = this.render();
      filename = './output/' + this.file;
      return fs.writeFileSync(filename, result);
    };

    return Output;

  })();

  HTMLOutput = (function(_super) {
    __extends(HTMLOutput, _super);


    /*
    HTML Output Subclass
     */

    HTMLOutput.prototype.html = '<!doctype HTML>\n<html>\n  <head>\n    <title>Color Table Results</title>\n    <style>\n      div.color {\n        width: 100px;\n        height: 20px;\n        border: 1px solid #000;\n        font-size: 0;\n        float: left;\n      }\n      div.color:nth-child(10n + 1) {\n        clear: left;\n      }\n    </style>\n  </head>\n  <body>\n    <h1>Generated %s Colors</h1>\n    <div class="colors">\n      %s\n    </div>\n  </body>\n</html>';

    function HTMLOutput(file, colors, html) {
      HTMLOutput.__super__.constructor.call(this, file, colors);
      if (html) {
        this.html = html;
      }
    }

    HTMLOutput.prototype.render = function() {
      return _f(this.html, this.colors.length, this.renderColors());
    };

    HTMLOutput.prototype.renderColors = function() {
      var color, html, template, _i, _len, _ref;
      html = '';
      template = '<div class="color" style="background-color: %s">%s</div>';
      _ref = this.colors;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        color = _ref[_i];
        html += _f(template, color, color);
        html += "\n";
      }
      return html;
    };

    return HTMLOutput;

  })(Output);

  JSONOutput = (function(_super) {
    __extends(JSONOutput, _super);

    function JSONOutput() {
      return JSONOutput.__super__.constructor.apply(this, arguments);
    }


    /*
    Array Output Subclass
     */

    JSONOutput.prototype.render = function() {
      var color, colors, _i, _len, _ref;
      colors = [];
      _ref = this.colors;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        color = _ref[_i];
        colors.push(color.toArray());
      }
      return JSON.stringify(colors);
    };

    return JSONOutput;

  })(Output);

  module.exports = {
    HTML: HTMLOutput,
    JSON: JSONOutput
  };

}).call(this);
