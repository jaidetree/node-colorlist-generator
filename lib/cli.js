(function() {
  var CSON, ColorListGenerator, path, run, _f;

  _f = require('util').format;

  CSON = require('cson');

  path = require('path');

  ColorListGenerator = require('./');

  run = function() {
    var args, colorListGenerator, e, file;
    try {
      args = require('minimist')(process.argv.slice(2));
      if (!args._[0] || !typeof args._[0] === 'string') {
        throw new Error('No --file <path> parameter specified!');
      }
      file = args._[0];
      console.log(_f('Reading CSON Input file: "%s" ', file));
      file = path.join(path.dirname(__dirname), 'input', file);
      colorListGenerator = new ColorListGenerator(CSON.parseFileSync(file));
      return colorListGenerator.generate();
    } catch (_error) {
      e = _error;
      return console.log(e);
    }
  };

  run();

}).call(this);
