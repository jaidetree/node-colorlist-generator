browserSync = require 'browser-sync'
coffee = require 'gulp-coffee'
coffeelint = require 'gulp-coffeelint'
gulp = require 'gulp'
gutil = require 'gulp-util'
mocha = require 'gulp-mocha'

paths =
  test: './test/*.coffee'
  src:
    coffee: './src/**/*.coffee'
  build:
    lib: './lib'
    html: './output/*.html'

gulp.task 'coffee', ->
  gulp.src paths.src.coffee
    .pipe coffee().on 'error', gutil.log
    .pipe gulp.dest paths.build.lib

gulp.task 'lint', ->
  gulp.src paths.src.coffee
    .pipe coffeelint()
    .pipe coffeelint.reporter()

gulp.task 'test', ->
  gulp.src paths.test, { read:false }
    .pipe mocha
      bail: true
  

gulp.task 'watch', ->
  try
    browserSync
      files: paths.build.html
      server:
        baseDir: './output'
  catch error
      gutil.log(error)
      


