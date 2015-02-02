_f = require('util').format
args = require('minimist')(process.argv.slice(2))
cheerio = require 'cheerio'
fs = require 'fs'
path = require 'path'

print = console.log

markup = """
<div class="goog-menu menu goog-menu-noaccel docs-colormenuitems" style="-webkit-user-select: none; visibility: visible; left: 605.362487792969px; top: 90.5999984741211px; display: block !important;" role="menu" aria-haspopup="true"><div class="goog-menuitem" role="button" id=":3k" style="-webkit-user-select: none;"><div class="goog-menuitem-content"><div class="docs-icon goog-inline-block goog-menuitem-icon"><div class="docs-icon-img-container docs-icon-img docs-icon-no-color" aria-hidden="true">&nbsp;</div></div>Reset</div></div><div class="jfk-palette" role="grid" id=":3l" style="-webkit-user-select: none;"><table class="jfk-palette-table" cellspacing="0" cellpadding="0"><tbody class="jfk-palette-body"><tr class="jfk-palette-row" role="row"><td class="jfk-palette-cell" id="jfk-palette-cell-180" role="gridcell" aria-selected="false" aria-label="black"><div class="jfk-palette-colorswatch" title="black" style="background-color: rgb(0, 0, 0);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-181" role="gridcell" aria-selected="false" aria-label="dark gray 4"><div class="jfk-palette-colorswatch" title="dark gray 4" style="background-color: rgb(67, 67, 67);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-182" role="gridcell" aria-selected="false" aria-label="dark gray 3"><div class="jfk-palette-colorswatch" title="dark gray 3" style="background-color: rgb(102, 102, 102);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-183" role="gridcell" aria-selected="false" aria-label="dark gray 2"><div class="jfk-palette-colorswatch" title="dark gray 2" style="background-color: rgb(153, 153, 153);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-184" role="gridcell" aria-selected="false" aria-label="dark gray 1"><div class="jfk-palette-colorswatch" title="dark gray 1" style="background-color: rgb(183, 183, 183);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-185" role="gridcell" aria-selected="false" aria-label="gray "><div class="jfk-palette-colorswatch" title="gray " style="background-color: rgb(204, 204, 204);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-186" role="gridcell" aria-selected="false" aria-label="light gray 1"><div class="jfk-palette-colorswatch" title="light gray 1" style="background-color: rgb(217, 217, 217);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-187" role="gridcell" aria-selected="false" aria-label="light gray 2"><div class="jfk-palette-colorswatch" title="light gray 2" style="background-color: rgb(239, 239, 239);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-188" role="gridcell" aria-selected="false" aria-label="light gray 3"><div class="jfk-palette-colorswatch" title="light gray 3" style="background-color: rgb(243, 243, 243);"></div></td><td class="jfk-palette-cell jfk-palette-cell-selected" id="jfk-palette-cell-189" role="gridcell" aria-selected="true" aria-label="white"><div class="jfk-palette-colorswatch" title="white" style="background-color: rgb(255, 255, 255);"></div></td></tr></tbody></table></div><div class="jfk-palette" role="grid" id=":3m" style="-webkit-user-select: none;"><table class="jfk-palette-table" cellspacing="0" cellpadding="0"><tbody class="jfk-palette-body"><tr class="jfk-palette-row" role="row"><td class="jfk-palette-cell" id="jfk-palette-cell-190" role="gridcell" aria-selected="false" aria-label="red berry "><div class="jfk-palette-colorswatch" title="red berry " style="background-color: rgb(152, 0, 0);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-191" role="gridcell" aria-selected="false" aria-label="red "><div class="jfk-palette-colorswatch" title="red " style="background-color: rgb(255, 0, 0);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-192" role="gridcell" aria-selected="false" aria-label="orange "><div class="jfk-palette-colorswatch" title="orange " style="background-color: rgb(255, 153, 0);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-193" role="gridcell" aria-selected="false" aria-label="yellow "><div class="jfk-palette-colorswatch" title="yellow " style="background-color: rgb(255, 255, 0);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-194" role="gridcell" aria-selected="false" aria-label="green "><div class="jfk-palette-colorswatch" title="green " style="background-color: rgb(0, 255, 0);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-195" role="gridcell" aria-selected="false" aria-label="cyan "><div class="jfk-palette-colorswatch" title="cyan " style="background-color: rgb(0, 255, 255);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-196" role="gridcell" aria-selected="false" aria-label="cornflower blue "><div class="jfk-palette-colorswatch" title="cornflower blue " style="background-color: rgb(74, 134, 232);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-197" role="gridcell" aria-selected="false" aria-label="blue "><div class="jfk-palette-colorswatch" title="blue " style="background-color: rgb(0, 0, 255);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-198" role="gridcell" aria-selected="false" aria-label="purple "><div class="jfk-palette-colorswatch" title="purple " style="background-color: rgb(153, 0, 255);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-199" role="gridcell" aria-selected="false" aria-label="magenta "><div class="jfk-palette-colorswatch" title="magenta " style="background-color: rgb(255, 0, 255);"></div></td></tr></tbody></table></div><div class="jfk-palette" role="grid" id=":3n" style="-webkit-user-select: none;"><table class="jfk-palette-table" cellspacing="0" cellpadding="0"><tbody class="jfk-palette-body"><tr class="jfk-palette-row" role="row"><td class="jfk-palette-cell" id="jfk-palette-cell-200" role="gridcell" aria-selected="false" aria-label="light red berry 3"><div class="jfk-palette-colorswatch" title="light red berry 3" style="background-color: rgb(230, 184, 175);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-201" role="gridcell" aria-selected="false" aria-label="light red 3"><div class="jfk-palette-colorswatch" title="light red 3" style="background-color: rgb(244, 204, 204);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-202" role="gridcell" aria-selected="false" aria-label="light orange 3"><div class="jfk-palette-colorswatch" title="light orange 3" style="background-color: rgb(252, 229, 205);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-203" role="gridcell" aria-selected="false" aria-label="light yellow 3"><div class="jfk-palette-colorswatch" title="light yellow 3" style="background-color: rgb(255, 242, 204);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-204" role="gridcell" aria-selected="false" aria-label="light green 3"><div class="jfk-palette-colorswatch" title="light green 3" style="background-color: rgb(217, 234, 211);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-205" role="gridcell" aria-selected="false" aria-label="light cyan 3"><div class="jfk-palette-colorswatch" title="light cyan 3" style="background-color: rgb(208, 224, 227);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-206" role="gridcell" aria-selected="false" aria-label="light cornflower blue 3"><div class="jfk-palette-colorswatch" title="light cornflower blue 3" style="background-color: rgb(201, 218, 248);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-207" role="gridcell" aria-selected="false" aria-label="light blue 3"><div class="jfk-palette-colorswatch" title="light blue 3" style="background-color: rgb(207, 226, 243);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-208" role="gridcell" aria-selected="false" aria-label="light purple 3"><div class="jfk-palette-colorswatch" title="light purple 3" style="background-color: rgb(217, 210, 233);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-209" role="gridcell" aria-selected="false" aria-label="light magenta 3"><div class="jfk-palette-colorswatch" title="light magenta 3" style="background-color: rgb(234, 209, 220);"></div></td></tr><tr class="jfk-palette-row" role="row"><td class="jfk-palette-cell" id="jfk-palette-cell-210" role="gridcell" aria-selected="false" aria-label="light red berry 2"><div class="jfk-palette-colorswatch" title="light red berry 2" style="background-color: rgb(221, 126, 107);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-211" role="gridcell" aria-selected="false" aria-label="light red 2"><div class="jfk-palette-colorswatch" title="light red 2" style="background-color: rgb(234, 153, 153);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-212" role="gridcell" aria-selected="false" aria-label="light orange 2"><div class="jfk-palette-colorswatch" title="light orange 2" style="background-color: rgb(249, 203, 156);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-213" role="gridcell" aria-selected="false" aria-label="light yellow 1"><div class="jfk-palette-colorswatch" title="light yellow 1" style="background-color: rgb(255, 229, 153);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-214" role="gridcell" aria-selected="false" aria-label="light green 2"><div class="jfk-palette-colorswatch" title="light green 2" style="background-color: rgb(182, 215, 168);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-215" role="gridcell" aria-selected="false" aria-label="light cyan 2"><div class="jfk-palette-colorswatch" title="light cyan 2" style="background-color: rgb(162, 196, 201);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-216" role="gridcell" aria-selected="false" aria-label="light cornflower blue 2"><div class="jfk-palette-colorswatch" title="light cornflower blue 2" style="background-color: rgb(164, 194, 244);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-217" role="gridcell" aria-selected="false" aria-label="light blue 2"><div class="jfk-palette-colorswatch" title="light blue 2" style="background-color: rgb(159, 197, 232);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-218" role="gridcell" aria-selected="false" aria-label="light purple 2"><div class="jfk-palette-colorswatch" title="light purple 2" style="background-color: rgb(180, 167, 214);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-219" role="gridcell" aria-selected="false" aria-label="light magenta 2"><div class="jfk-palette-colorswatch" title="light magenta 2" style="background-color: rgb(213, 166, 189);"></div></td></tr><tr class="jfk-palette-row" role="row"><td class="jfk-palette-cell" id="jfk-palette-cell-220" role="gridcell" aria-selected="false" aria-label="light red berry 1"><div class="jfk-palette-colorswatch" title="light red berry 1" style="background-color: rgb(204, 65, 37);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-221" role="gridcell" aria-selected="false" aria-label="light red 1"><div class="jfk-palette-colorswatch" title="light red 1" style="background-color: rgb(224, 102, 102);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-222" role="gridcell" aria-selected="false" aria-label="light orange 1"><div class="jfk-palette-colorswatch" title="light orange 1" style="background-color: rgb(246, 178, 107);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-223" role="gridcell" aria-selected="false" aria-label="light yellow 2"><div class="jfk-palette-colorswatch" title="light yellow 2" style="background-color: rgb(255, 217, 102);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-224" role="gridcell" aria-selected="false" aria-label="light green 1"><div class="jfk-palette-colorswatch" title="light green 1" style="background-color: rgb(147, 196, 125);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-225" role="gridcell" aria-selected="false" aria-label="light cyan 1"><div class="jfk-palette-colorswatch" title="light cyan 1" style="background-color: rgb(118, 165, 175);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-226" role="gridcell" aria-selected="false" aria-label="light cornflower blue 1"><div class="jfk-palette-colorswatch" title="light cornflower blue 1" style="background-color: rgb(109, 158, 235);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-227" role="gridcell" aria-selected="false" aria-label="light blue 1"><div class="jfk-palette-colorswatch" title="light blue 1" style="background-color: rgb(111, 168, 220);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-228" role="gridcell" aria-selected="false" aria-label="light purple 1"><div class="jfk-palette-colorswatch" title="light purple 1" style="background-color: rgb(142, 124, 195);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-229" role="gridcell" aria-selected="false" aria-label="light magenta 1"><div class="jfk-palette-colorswatch" title="light magenta 1" style="background-color: rgb(194, 123, 160);"></div></td></tr><tr class="jfk-palette-row" role="row"><td class="jfk-palette-cell" id="jfk-palette-cell-230" role="gridcell" aria-selected="false" aria-label="dark red berry 1"><div class="jfk-palette-colorswatch" title="dark red berry 1" style="background-color: rgb(166, 28, 0);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-231" role="gridcell" aria-selected="false" aria-label="dark red 1"><div class="jfk-palette-colorswatch" title="dark red 1" style="background-color: rgb(204, 0, 0);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-232" role="gridcell" aria-selected="false" aria-label="dark orange 1"><div class="jfk-palette-colorswatch" title="dark orange 1" style="background-color: rgb(230, 145, 56);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-233" role="gridcell" aria-selected="false" aria-label="dark yellow 1"><div class="jfk-palette-colorswatch" title="dark yellow 1" style="background-color: rgb(241, 194, 50);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-234" role="gridcell" aria-selected="false" aria-label="dark green 1"><div class="jfk-palette-colorswatch" title="dark green 1" style="background-color: rgb(106, 168, 79);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-235" role="gridcell" aria-selected="false" aria-label="dark cyan 1"><div class="jfk-palette-colorswatch" title="dark cyan 1" style="background-color: rgb(69, 129, 142);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-236" role="gridcell" aria-selected="false" aria-label="dark cornflower blue 1"><div class="jfk-palette-colorswatch" title="dark cornflower blue 1" style="background-color: rgb(60, 120, 216);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-237" role="gridcell" aria-selected="false" aria-label="dark blue 1"><div class="jfk-palette-colorswatch" title="dark blue 1" style="background-color: rgb(61, 133, 198);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-238" role="gridcell" aria-selected="false" aria-label="dark purple 1"><div class="jfk-palette-colorswatch" title="dark purple 1" style="background-color: rgb(103, 78, 167);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-239" role="gridcell" aria-selected="false" aria-label="dark magenta 1"><div class="jfk-palette-colorswatch" title="dark magenta 1" style="background-color: rgb(166, 77, 121);"></div></td></tr><tr class="jfk-palette-row" role="row"><td class="jfk-palette-cell" id="jfk-palette-cell-240" role="gridcell" aria-selected="false" aria-label="dark red berry 2"><div class="jfk-palette-colorswatch" title="dark red berry 2" style="background-color: rgb(133, 32, 12);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-241" role="gridcell" aria-selected="false" aria-label="dark red 2"><div class="jfk-palette-colorswatch" title="dark red 2" style="background-color: rgb(153, 0, 0);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-242" role="gridcell" aria-selected="false" aria-label="dark orange 2"><div class="jfk-palette-colorswatch" title="dark orange 2" style="background-color: rgb(180, 95, 6);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-243" role="gridcell" aria-selected="false" aria-label="dark yellow 2"><div class="jfk-palette-colorswatch" title="dark yellow 2" style="background-color: rgb(191, 144, 0);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-244" role="gridcell" aria-selected="false" aria-label="dark green 2"><div class="jfk-palette-colorswatch" title="dark green 2" style="background-color: rgb(56, 118, 29);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-245" role="gridcell" aria-selected="false" aria-label="dark cyan 2"><div class="jfk-palette-colorswatch" title="dark cyan 2" style="background-color: rgb(19, 79, 92);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-246" role="gridcell" aria-selected="false" aria-label="dark cornflower blue 2"><div class="jfk-palette-colorswatch" title="dark cornflower blue 2" style="background-color: rgb(17, 85, 204);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-247" role="gridcell" aria-selected="false" aria-label="dark blue 2"><div class="jfk-palette-colorswatch" title="dark blue 2" style="background-color: rgb(11, 83, 148);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-248" role="gridcell" aria-selected="false" aria-label="dark purple 2"><div class="jfk-palette-colorswatch" title="dark purple 2" style="background-color: rgb(53, 28, 117);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-249" role="gridcell" aria-selected="false" aria-label="dark magenta 2"><div class="jfk-palette-colorswatch" title="dark magenta 2" style="background-color: rgb(116, 27, 71);"></div></td></tr><tr class="jfk-palette-row" role="row"><td class="jfk-palette-cell" id="jfk-palette-cell-250" role="gridcell" aria-selected="false" aria-label="dark red berry 3"><div class="jfk-palette-colorswatch" title="dark red berry 3" style="background-color: rgb(91, 15, 0);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-251" role="gridcell" aria-selected="false" aria-label="dark red 3"><div class="jfk-palette-colorswatch" title="dark red 3" style="background-color: rgb(102, 0, 0);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-252" role="gridcell" aria-selected="false" aria-label="dark orange 3"><div class="jfk-palette-colorswatch" title="dark orange 3" style="background-color: rgb(120, 63, 4);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-253" role="gridcell" aria-selected="false" aria-label="dark yellow 3"><div class="jfk-palette-colorswatch" title="dark yellow 3" style="background-color: rgb(127, 96, 0);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-254" role="gridcell" aria-selected="false" aria-label="dark green 3"><div class="jfk-palette-colorswatch" title="dark green 3" style="background-color: rgb(39, 78, 19);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-255" role="gridcell" aria-selected="false" aria-label="dark cyan 3"><div class="jfk-palette-colorswatch" title="dark cyan 3" style="background-color: rgb(12, 52, 61);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-256" role="gridcell" aria-selected="false" aria-label="dark cornflower blue 3"><div class="jfk-palette-colorswatch" title="dark cornflower blue 3" style="background-color: rgb(28, 69, 135);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-257" role="gridcell" aria-selected="false" aria-label="dark blue 3"><div class="jfk-palette-colorswatch" title="dark blue 3" style="background-color: rgb(7, 55, 99);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-258" role="gridcell" aria-selected="false" aria-label="dark purple 3"><div class="jfk-palette-colorswatch" title="dark purple 3" style="background-color: rgb(32, 18, 77);"></div></td><td class="jfk-palette-cell" id="jfk-palette-cell-259" role="gridcell" aria-selected="false" aria-label="dark magenta 3"><div class="jfk-palette-colorswatch" title="dark magenta 3" style="background-color: rgb(76, 17, 48);"></div></td></tr></tbody></table></div><div class="goog-menuitem" role="button" id=":3o" style="-webkit-user-select: none;"><div class="goog-menuitem-content"><div class="docs-colormenuitems-custom-header">Custom...</div></div></div><div class="jfk-palette docs-colormenuitems-custom-palette" role="grid" id=":3q" style="-webkit-user-select: none;"><table class="jfk-palette-table" cellspacing="0" cellpadding="0" style="-webkit-user-select: none;"><tbody class="jfk-palette-body" style="-webkit-user-select: none;"><tr class="jfk-palette-row" role="row" style="-webkit-user-select: none;"><td class="jfk-palette-cell" id="jfk-palette-cell-260" role="gridcell" aria-selected="false" style="-webkit-user-select: none;"></td><td class="jfk-palette-cell" id="jfk-palette-cell-261" role="gridcell" aria-selected="false" style="-webkit-user-select: none;"></td><td class="jfk-palette-cell" id="jfk-palette-cell-262" role="gridcell" aria-selected="false" style="-webkit-user-select: none;"></td><td class="jfk-palette-cell" id="jfk-palette-cell-263" role="gridcell" aria-selected="false" style="-webkit-user-select: none;"></td><td class="jfk-palette-cell" id="jfk-palette-cell-264" role="gridcell" aria-selected="false" style="-webkit-user-select: none;"></td><td class="jfk-palette-cell" id="jfk-palette-cell-265" role="gridcell" aria-selected="false" style="-webkit-user-select: none;"></td><td class="jfk-palette-cell" id="jfk-palette-cell-266" role="gridcell" aria-selected="false" style="-webkit-user-select: none;"></td><td class="jfk-palette-cell" id="jfk-palette-cell-267" role="gridcell" aria-selected="false" style="-webkit-user-select: none;"></td><td class="jfk-palette-cell" id="jfk-palette-cell-268" role="gridcell" aria-selected="false" style="-webkit-user-select: none;"></td><td class="jfk-palette-cell" id="jfk-palette-cell-269" role="gridcell" aria-selected="false" style="-webkit-user-select: none;"></td></tr></tbody></table></div><div class="goog-menuseparator" aria-disabled="true" role="separator" id=":29" style="-webkit-user-select: none;"></div><div id="t-cell-color-cond-fmt" class="goog-menuitem goog-option" role="menuitemcheckbox" aria-checked="false" style="-webkit-user-select: none;"><div class="goog-menuitem-content" style="-webkit-user-select: none;"><div class="goog-menuitem-checkbox" style="-webkit-user-select: none;"></div>Conditional formatting...</div></div></div>
  """

###
# Color Table Generator
# Generates an array of colors
###

class ColorList
  constructor: (options) ->
    @colors = new RGBColorList()

  generateShades: ->
    return

  generateRow: (min, max, steps, callback) ->
    for x in [min..max] by max / steps
      x = parseInt(x, 10)

      @colors.push callback(x)
  
  build: ->
    # Generate a row from black to white
    @generateRow 0, 256, 7, (x) ->
       return new RGBColor(x, x, x)

    # Generate base red colors
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(x, 0, 0)

    # Generate base red colors
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(0, x, 0)

    # Generate base green colors
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(0, 0, x)

    # Generate red + green
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(x, x, 0)

    # Generate red + blue
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(x, 0, x)

    # Generate green + blue
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(0, x, x)

    # Generate Red Tints
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(255, x, x)

    # Generate Green Tints
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(x, 255,  x)

    # Generate Blue Tints
    @generateRow 0, 256, 7, (x) ->
      return new RGBColor(x, x, 255)
    
    return @colors.get()

class ColorParser
  constructor: ->
    @colors = new RGBColorList()

  parse: (markup) ->
    $ = cheerio.load markup
    $('.jfk-palette-colorswatch').each (index, el) =>
      @parseColor el

  parseColor: (el) ->
    $ = cheerio.load(el)
    style = el.attribs.style
    color = style.match /([\d]+)/g
    @colors.push new RGBColor(color[0], color[1], color[2])

  build: ->
    return @colors.get()


class RGBColorList
  constructor: () ->
    @colors = []

  push: (color) ->
    @colors.push color

  pushRGB: (red=0, green=0, blue=0) ->
    @colors.push new RGBColor(red, green, blue)

  get: ->
    return @colors

  toString: ->
    colors = []

    for color in @colors
      color.push(color.toString())

    return colors
    

class RGBColor
  constructor: (red, green, blue) ->
    @red = Number(red)
    @green = Number(green)
    @blue = Number(blue)

  toArray: ->
    return [@red, @green, @blue]

  toString: ->
    return _f 'rgb(%s, %s, %s)', @red, @green, @blue

class Output
  constructor: (file, colors) ->
    @file = file
    @colors = colors

  save: (result) ->
    filename = path.join(path.dirname(__dirname), 'output/' + @file)
    fs.writeFileSync filename, result


class HTMLOutput extends Output
  html: '''
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
        <h1>Generated %s Colors</h1>
        <div class="colors">
          %s
        </div>
      </body>
    </html>
    '''

  constructor: (file, colors) ->
    @file = file
    @colors = colors

  render: ->
    result = _f @html, @colors.length, @renderColors()
    @save result

  renderColors: ->
    html = ''
    template = '<div class="color" style="background-color: %s">%s</div>'

    for color in @colors
      html += _f template, color, color
      html += "\n"

    return html


class ArrayOutput extends Output
  render: ->
    colors = []

    for color in @colors
      colors.push color.toArray()

    @save JSON.stringify(colors)

print 'Generating color table.....'

# list = new ColorList()
list = new ColorParser();
list.parse(markup);

colors = list.build()

print colors

# Try really hard
try
  new HTMLOutput('colorlist.html', colors).render()
  new ArrayOutput('colors.json', colors).render()
catch e
  print e
  
