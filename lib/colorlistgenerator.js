(function() {
  var CSON, ColorList, ColorTable, Output, RGB, args, colors, data, e, file, parseRGBData, path, table, _f;

  _f = require('util').format;

  CSON = require('cson');

  path = require('path');

  RGB = require('./lib/rgbcolor');

  ColorList = require('./lib/colorlist');

  ColorTable = require('./lib/colortable');

  Output = require('./lib/output');

  parseRGBData = function(data) {
    var color, colors, _i, _len;
    colors = [];
    for (_i = 0, _len = data.length; _i < _len; _i++) {
      color = data[_i];
      colors.push(new RGB.Color(color[0], color[1], color[2]));
    }
    return colors;
  };

  try {
    args = require('minimist')(process.argv.slice(2));
    if (!args._[0] || !typeof args._[0] === 'string') {
      throw new Error('No --file <path> parameter specified!');
    }
    file = args._[0];
    console.log(_f('Reading CSON Input file: "%s" ', file));
    file = path.join(path.dirname(__dirname), 'input', file);
    data = parseRGBData(CSON.parseFileSync(file));
    console.log('Generating color table................');
    table = new ColorTable(data);
    console.log('Converting table to an array..........');
    colors = new ColorList(table.build());
    console.log('Saving HTML...........................');
    new Output.HTML('colorlist.html', colors.toArray());
    console.log('Saving JSON...........................');
    new Output.JSON('colors.json', colors.toArray());
    console.log('Done!');
  } catch (_error) {
    e = _error;
    console.log(e);
  }

}).call(this);
