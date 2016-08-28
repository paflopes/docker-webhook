gulp = require 'gulp'
coffee = require 'gulp-coffee'
sourcemaps = require 'gulp-sourcemaps'
nodemon = require 'gulp-nodemon'
gutil = require 'gulp-util'
del = require 'del'
cache = require("gulp-cache-money")
  cacheFile: __dirname + "/.cache"

gulp.task 'compile-coffee', () ->
  gulp.src('./src/**/*.coffee')
  .pipe(cache())
  .pipe(sourcemaps.init())
  .pipe(coffee({bare: true})).on('error', gutil.log)
  .pipe(sourcemaps.write())
  .pipe(gulp.dest('./build'))

gulp.task 'clean', () ->
  del [
    'build/',
    '.cache'
  ]

gulp.task 'watch-coffee', ['compile-coffee'], () ->
  nodemon
    script: 'build/app.js'
    ext: 'coffee'
    watch: './src'
    tasks: ['compile-coffee']