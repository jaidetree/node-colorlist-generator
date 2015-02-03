# Color List Generator
Generates an array representing a color picker spectrum table.

# Installation
Install via `npm install git://github.com/jayzawrotny/node-colorlist-generator.git#master`

# Run
Just execute `npm run main 'basecolors.cson'` and the app will look for `input/basecolors.cson`

## Building
There are several gulp commands you can use as needed:
  1. `gulp watch` or `npm run watch` - Watches the output directory to refresh the html file. Makes debugging algorithms much easier.
  2. `gulp coffee` or `npm run build` - Builds the coffeescript files into JS
  3. `gulp test` or `npm test` - Runs the unit tests using Mocha
  4. `gulp lint` or `npm run lint` - Runs gulp-coffeelint on all `./src/**/*.coffee` files

## Output
Running this will write files to the project root's `output` directory.

### HTML
Generates an HTML file showing the colors together. Is designed around 8 rows x 10 cols

### JSON
Generates a JSON file with an array containing all the files.

# Examples

## Input
`input/basecolors.cson`

```
[
  [172,   0,    43],
  [255,   0,    0],
  [209,   108,  35],
  [209,   255,  35],
  [0,     255,  0],
  [21,    206,  210],
  [21,    111,  210],
  [0,     0,    255],
  [131,   21,   210],
  [255,   0,    255],
]
```

## Output

In HTML:
```
<!doctype HTML>
<html>
  <head>
    <title>Color Table Results</title>
    <style>
      div.color {
        width: 100px;
        height: 20px;
        border: 1px solid #000;
        font-size: 0;
        float: left;
      }
      div.color:nth-child(10n + 1) {
        clear: left;
      }
    </style>
  </head>
  <body>
    <h1>Generated 80 Colors</h1>
    <div class="colors">
      <div class="color" style="background-color: rgb(0, 0, 0)">rgb(0, 0, 0)</div>
<div class="color" style="background-color: rgb(51, 51, 51)">rgb(51, 51, 51)</div>
<div class="color" style="background-color: rgb(76, 76, 76)">rgb(76, 76, 76)</div>
<div class="color" style="background-color: rgb(102, 102, 102)">rgb(102, 102, 102)</div>
<div class="color" style="background-color: rgb(127, 127, 127)">rgb(127, 127, 127)</div>
<div class="color" style="background-color: rgb(153, 153, 153)">rgb(153, 153, 153)</div>
<div class="color" style="background-color: rgb(178, 178, 178)">rgb(178, 178, 178)</div>
<div class="color" style="background-color: rgb(204, 204, 204)">rgb(204, 204, 204)</div>
<div class="color" style="background-color: rgb(229, 229, 229)">rgb(229, 229, 229)</div>
<div class="color" style="background-color: rgb(255, 255, 255)">rgb(255, 255, 255)</div>
<div class="color" style="background-color: rgb(172, 0, 43)">rgb(172, 0, 43)</div>
<div class="color" style="background-color: rgb(255, 0, 0)">rgb(255, 0, 0)</div>
<div class="color" style="background-color: rgb(209, 108, 35)">rgb(209, 108, 35)</div>
<div class="color" style="background-color: rgb(209, 255, 35)">rgb(209, 255, 35)</div>
<div class="color" style="background-color: rgb(0, 255, 0)">rgb(0, 255, 0)</div>
<div class="color" style="background-color: rgb(21, 206, 210)">rgb(21, 206, 210)</div>
<div class="color" style="background-color: rgb(21, 111, 210)">rgb(21, 111, 210)</div>
<div class="color" style="background-color: rgb(0, 0, 255)">rgb(0, 0, 255)</div>
<div class="color" style="background-color: rgb(131, 21, 210)">rgb(131, 21, 210)</div>
<div class="color" style="background-color: rgb(255, 0, 255)">rgb(255, 0, 255)</div>
<div class="color" style="background-color: rgb(230, 178, 191)">rgb(230, 178, 191)</div>
<div class="color" style="background-color: rgb(255, 178, 178)">rgb(255, 178, 178)</div>
<div class="color" style="background-color: rgb(241, 210, 189)">rgb(241, 210, 189)</div>
<div class="color" style="background-color: rgb(241, 255, 189)">rgb(241, 255, 189)</div>
<div class="color" style="background-color: rgb(178, 255, 178)">rgb(178, 255, 178)</div>
<div class="color" style="background-color: rgb(184, 240, 241)">rgb(184, 240, 241)</div>
<div class="color" style="background-color: rgb(184, 211, 241)">rgb(184, 211, 241)</div>
<div class="color" style="background-color: rgb(178, 178, 255)">rgb(178, 178, 255)</div>
<div class="color" style="background-color: rgb(217, 184, 241)">rgb(217, 184, 241)</div>
<div class="color" style="background-color: rgb(255, 178, 255)">rgb(255, 178, 255)</div>
<div class="color" style="background-color: rgb(213, 127, 149)">rgb(213, 127, 149)</div>
<div class="color" style="background-color: rgb(255, 127, 127)">rgb(255, 127, 127)</div>
<div class="color" style="background-color: rgb(232, 181, 145)">rgb(232, 181, 145)</div>
<div class="color" style="background-color: rgb(232, 255, 145)">rgb(232, 255, 145)</div>
<div class="color" style="background-color: rgb(127, 255, 127)">rgb(127, 255, 127)</div>
<div class="color" style="background-color: rgb(138, 230, 232)">rgb(138, 230, 232)</div>
<div class="color" style="background-color: rgb(138, 183, 232)">rgb(138, 183, 232)</div>
<div class="color" style="background-color: rgb(127, 127, 255)">rgb(127, 127, 255)</div>
<div class="color" style="background-color: rgb(193, 138, 232)">rgb(193, 138, 232)</div>
<div class="color" style="background-color: rgb(255, 127, 255)">rgb(255, 127, 255)</div>
<div class="color" style="background-color: rgb(192, 63, 96)">rgb(192, 63, 96)</div>
<div class="color" style="background-color: rgb(255, 63, 63)">rgb(255, 63, 63)</div>
<div class="color" style="background-color: rgb(220, 144, 90)">rgb(220, 144, 90)</div>
<div class="color" style="background-color: rgb(220, 255, 90)">rgb(220, 255, 90)</div>
<div class="color" style="background-color: rgb(63, 255, 63)">rgb(63, 255, 63)</div>
<div class="color" style="background-color: rgb(79, 218, 221)">rgb(79, 218, 221)</div>
<div class="color" style="background-color: rgb(79, 147, 221)">rgb(79, 147, 221)</div>
<div class="color" style="background-color: rgb(63, 63, 255)">rgb(63, 63, 255)</div>
<div class="color" style="background-color: rgb(162, 79, 221)">rgb(162, 79, 221)</div>
<div class="color" style="background-color: rgb(255, 63, 255)">rgb(255, 63, 255)</div>
<div class="color" style="background-color: rgb(137, 0, 34)">rgb(137, 0, 34)</div>
<div class="color" style="background-color: rgb(204, 0, 0)">rgb(204, 0, 0)</div>
<div class="color" style="background-color: rgb(167, 86, 28)">rgb(167, 86, 28)</div>
<div class="color" style="background-color: rgb(167, 204, 28)">rgb(167, 204, 28)</div>
<div class="color" style="background-color: rgb(0, 204, 0)">rgb(0, 204, 0)</div>
<div class="color" style="background-color: rgb(16, 164, 168)">rgb(16, 164, 168)</div>
<div class="color" style="background-color: rgb(16, 88, 168)">rgb(16, 88, 168)</div>
<div class="color" style="background-color: rgb(0, 0, 204)">rgb(0, 0, 204)</div>
<div class="color" style="background-color: rgb(104, 16, 168)">rgb(104, 16, 168)</div>
<div class="color" style="background-color: rgb(204, 0, 204)">rgb(204, 0, 204)</div>
<div class="color" style="background-color: rgb(103, 0, 25)">rgb(103, 0, 25)</div>
<div class="color" style="background-color: rgb(153, 0, 0)">rgb(153, 0, 0)</div>
<div class="color" style="background-color: rgb(125, 64, 21)">rgb(125, 64, 21)</div>
<div class="color" style="background-color: rgb(125, 153, 21)">rgb(125, 153, 21)</div>
<div class="color" style="background-color: rgb(0, 153, 0)">rgb(0, 153, 0)</div>
<div class="color" style="background-color: rgb(12, 123, 126)">rgb(12, 123, 126)</div>
<div class="color" style="background-color: rgb(12, 66, 126)">rgb(12, 66, 126)</div>
<div class="color" style="background-color: rgb(0, 0, 153)">rgb(0, 0, 153)</div>
<div class="color" style="background-color: rgb(78, 12, 126)">rgb(78, 12, 126)</div>
<div class="color" style="background-color: rgb(153, 0, 153)">rgb(153, 0, 153)</div>
<div class="color" style="background-color: rgb(68, 0, 17)">rgb(68, 0, 17)</div>
<div class="color" style="background-color: rgb(102, 0, 0)">rgb(102, 0, 0)</div>
<div class="color" style="background-color: rgb(83, 43, 14)">rgb(83, 43, 14)</div>
<div class="color" style="background-color: rgb(83, 102, 14)">rgb(83, 102, 14)</div>
<div class="color" style="background-color: rgb(0, 102, 0)">rgb(0, 102, 0)</div>
<div class="color" style="background-color: rgb(8, 82, 84)">rgb(8, 82, 84)</div>
<div class="color" style="background-color: rgb(8, 44, 84)">rgb(8, 44, 84)</div>
<div class="color" style="background-color: rgb(0, 0, 102)">rgb(0, 0, 102)</div>
<div class="color" style="background-color: rgb(52, 8, 84)">rgb(52, 8, 84)</div>
<div class="color" style="background-color: rgb(102, 0, 102)">rgb(102, 0, 102)</div>
    </div>
  </body>
</html>
```

In JSON
```
[[0,0,0],[51,51,51],[76,76,76],[102,102,102],[127,127,127],[153,153,153],[178,178,178],[204,204,204],[229,229,229],[255,255,255],[172,0,43],[255,0,0],[209,108,35],[209,255,35],[0,255,0],[21,206,210],[21,111,210],[0,0,255],[131,21,210],[255,0,255],[230,178,191],[255,178,178],[241,210,189],[241,255,189],[178,255,178],[184,240,241],[184,211,241],[178,178,255],[217,184,241],[255,178,255],[213,127,149],[255,127,127],[232,181,145],[232,255,145],[127,255,127],[138,230,232],[138,183,232],[127,127,255],[193,138,232],[255,127,255],[192,63,96],[255,63,63],[220,144,90],[220,255,90],[63,255,63],[79,218,221],[79,147,221],[63,63,255],[162,79,221],[255,63,255],[137,0,34],[204,0,0],[167,86,28],[167,204,28],[0,204,0],[16,164,168],[16,88,168],[0,0,204],[104,16,168],[204,0,204],[103,0,25],[153,0,0],[125,64,21],[125,153,21],[0,153,0],[12,123,126],[12,66,126],[0,0,153],[78,12,126],[153,0,153],[68,0,17],[102,0,0],[83,43,14],[83,102,14],[0,102,0],[8,82,84],[8,44,84],[0,0,102],[52,8,84],[102,0,102]]
```
