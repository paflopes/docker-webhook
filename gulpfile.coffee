gulp = require 'gulp'
coffee = require 'gulp-coffee'
sourcemaps = require 'gulp-sourcemaps'
nodemon = require 'gulp-nodemon'
gutil = require 'gulp-util'

gulp.task 'compile', () ->
  gulp.src('./src/**/*.coffee')
  .pipe(sourcemaps.init())
  .pipe(coffee({bare: true})).on('error', gutil.log)
  .pipe(sourcemaps.write())
  .pipe(gulp.dest('./build'))

gulp.task 'watch', ['compile'], () ->
  nodemon
    script: 'build/app.js'
    watch: 'src'
    tasks: ['compile']