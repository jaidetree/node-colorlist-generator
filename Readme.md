# Color List Generator
I'm going to be straight with you. This plugin sucks. Originally it was supposed to calculate an array of RGB values that could converted into a table for color pickers and stuff. But well... I couldn't figure out that logic. Sooo I just used cheerio and queried some markup of an existing site's HTML color picker. It generates an example html file and a json file containing the array of colors... so yeah it worked out really well but it feels like defeat. Perhaps I will come back to it and figure out.

## Hypothesis
Thinking about it, I think the generator would work with 2 layers of loops.

  1. The first loop is just iterating through an arbitrary base colors like red, blue, purple, yellow, green, orange, light blue, etc...
  2. The second loop uses the base color, appends it a list. Then it generates like 3 tints and 3 shades that it also appends to a list creating the columns

Then you would have an array of columns you could put into an HTML table or an array or whatever.

## Sidebar
So if perhaps you didn't know (you probably do) a tint is a color + white so if red is rgb(255, 0, 0); a tint of that could be rgb(255, 100, 100); A shade is a color + black. So following our previous example a shade of red would be rgb(180, 0, 0);

## Problems
  1. RGB Data is really awkward to consistently manipulate. Like the red tint thing it's adding equal value to green & blue where as a shade is subtracting from that number.
  2. Those base colors can make or break the rest of it. Now sure in that previous red example you can say a tint is green & blue = 100 or something but say the base color is some kind of purple like rgb(82, 35, 159). How do you shade & tint those? You would have to scale the green & blue with respect to their numerical relationship. Probably some kind of ratio by dividing them can help with that.

### Solutions

I think a solution to those problems is to work with the colors in another kind of format. Some kind of single value that can be brightened or darkened.

## Process
  1. Research Ruby's Compass library which offers functions to `adjust-lightness($color, -5|5);`
  2. Research libraries/articles about shading & tinting HTML colors. Most likely something to turn it into a single value already exists and if not I'm sure there's at least a library to tint or shade a more complicated format like hex or rgb.

