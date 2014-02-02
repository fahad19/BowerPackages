module.exports = (grunt) ->

  ##
  # Config
  #
  grunt.initConfig

    pkg: grunt.file.readJSON 'package.json'

    banner: '/*! <%= pkg.title || pkg.name %> - v<%= pkg.version %> - ' +
      '<%= grunt.template.today("yyyy-mm-dd") %>\n' +
      '<%= pkg.homepage ? "* " + pkg.homepage + "\\n" : "" %>' +
      '* Copyright (c) <%= grunt.template.today("yyyy") %> <%= pkg.author.name %>;' +
      '*/\n'

    less:
      app:
        options:
          compress: false
          paths: [
            'css'
            'vendors'
          ]
        files:
          'css/app.css': 'css/app.less'

    cssmin:
      app:
        files:
          'css/app.css': ['css/app.css']

    coffee:
      app:
        files:
          'tmp/app.js': 'js/app.coffee'

    concat:
      options:
        banner: '<%= banner %>'
      js:
        src: [
          'vendors/angular/angular.js'
          'vendors/underscore/underscore.js'
          'vendors/moment/moment.js'
          'tmp/app.js'
        ]
        dest: 'js/app.js'

    uglify:
      options:
        mangle: false
      app:
        files:
          'js/app.js': ['js/app.js']

    connect:
      app:
        options:
          port: 9001
          base: '.'
          keepalive: true

    watch:
      app:
        files: [
          'css/app.less'
          'js/app.coffee'
        ]
        tasks: ['build']

    clean:
      tmp:
        files: [{
          dot: true
          src: [
            'tmp'
          ]
        }]


  ##
  # Load plugins
  #
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-connect'

  ##
  # Tasks
  #
  grunt.registerTask 'build', [
    'clean:tmp'
    'less:app'
    'coffee:app'
    'concat:js'
    'cssmin:app'
    'uglify:app'
  ]
  grunt.registerTask 'default', ['build']
  grunt.registerTask 'serve', ['build', 'connect:app']
