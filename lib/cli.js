(function() {
  var CSON, ColorListCLI, ColorListGenerator, Output, e, fs, minimist, path, _f;

  _f = require('util').format;

  fs = require('fs');

  CSON = require('cson');

  minimist = require('minimist');

  path = require('path');

  ColorListGenerator = require('./');

  Output = require('./lib/output');

  ColorListCLI = (function() {
    function ColorListCLI(args) {
      this.args = args;
    }

    ColorListCLI.prototype.parseArgs = function() {
      var args, input, output;
      input = null;
      output = null;
      args = minimist(this.args);
      if (!args._[0] || !typeof args._[0] === 'string') {
        throw new Error('No --file <path> parameter specified!');
      }
      input = path.join(process.cwd(), args._[0]);
      if (args._[1]) {
        output = path.join(process.cwd(), args._[1] || 'output/');
      }
      return {
        inFile: input,
        outDir: output
      };
    };

    ColorListCLI.prototype.run = function() {
      var args, input, list;
      this.init();
      args = this.parseArgs();
      input = this.readInput(args.inFile);
      list = this.generateColorList(input);
      if (args.outDir) {
        this.save(args.outDir, 'colorlist.html', this.output('HTML', list));
        this.save(args.outDir, 'colorlist.json', this.output('JSON', list));
      } else {
        console.log("\n");
        console.log('OUTPUT................................');
        process.stdout.write(this.output('JSON', list));
        console.log("\n");
      }
      return console.log('.................................Done.');
    };

    ColorListCLI.prototype.init = function() {
      return console.log('Starting color list generator.........');
    };

    ColorListCLI.prototype.readInput = function(file) {
      console.log(_f('Reading CSON Input file: "%s" ', path.basename(file)));
      return CSON.parseFileSync(file);
    };

    ColorListCLI.prototype.generateColorList = function(input) {
      var colors;
      colors = new ColorListGenerator(input);
      colors.parseRGBData();
      console.log('Generating color table................');
      colors.generateTable();
      console.log('Converting table to an array..........');
      return colors.generateList();
    };

    ColorListCLI.prototype.output = function(className, list) {
      return new Output[className](list).render();
    };

    ColorListCLI.prototype.save = function(dir, filename, output) {
      var e, file;
      try {
        file = path.join(dir, filename);
        console.log(_f('Saving %s', file));
        return fs.writeFileSync(file, output);
      } catch (_error) {
        e = _error;
        console.log(_f('Could not save to file "%s".', file));
        return process.exit();
      }
    };

    return ColorListCLI;

  })();

  try {
    new ColorListCLI(process.argv.slice(2)).run();
  } catch (_error) {
    e = _error;
    console.log(e);
  }

}).call(this);
