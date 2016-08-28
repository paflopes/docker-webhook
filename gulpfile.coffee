gulp = require 'gulp'
coffee = require 'gulp-coffee'
sourcemaps = require 'gulp-sourcemaps'
nodemon = require 'gulp-nodemon'
gutil = require 'gulp-util'
del = require 'del'
cache = require("gulp-cache-money")
  cacheFile: "#{__dirname}/.cache"

process.on 'SIGINT', ->
  setTimeout ->
    gutil.log gutil.colors.red('Successfully closed ' + process.pid)
    process.exit 1
  , 500


gulp.task 'coffee:compile', () ->
  gulp.src('./src/**/*.coffee')
  .pipe(cache())
  .pipe(sourcemaps.init())
  .pipe(coffee({bare: true}))
  .pipe(sourcemaps.write())
  .pipe(gulp.dest('./build'))

gulp.task 'coffee:watch', ['coffee:compile'], () ->
  gulp.watch('./src/**/*.coffee', ['coffee:compile'])

gulp.task 'clean', () ->
  del [
    'build/',
    '.cache'
  ]

gulp.task 'run:dev', ['coffee:compile'], () ->
  nodemon
    script: 'build/app.js'
    ext: 'coffee'
    watch: './src'
    tasks: ['coffee:compile']
