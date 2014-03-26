module.exports = (grunt) ->
	grunt.initConfig
		pkg: grunt.file.readJSON('package.json')

		coffee:
			dev:
				options:
					join: true
				files: 
					'js/app.js': 'coffee/app.coffee'

		sass:
			dev:
				files:
					'css/style.css': 'sass/style.sass'

		jade:
			dev:
				options:
					pretty: true
				files: 'index.html': 'index.jade'
				# files: [
				# 	expand: true
				# 	cwd: 'app/'
				# 	src: ['*.jade', '**/*.jade']
				# 	dest: ''
				# 	ext: '.html'
				# ]
		watch:
			coffee:
				files: '**/*.coffee'
				tasks: 'coffee:dev'
			sass:
				files: 'sass/*.sass'
				tasks: 'sass:dev'

			jade:
				files: '*.jade'
				tasks: 'jade:dev'

			livereload:
			  options:
			    livereload: true
			  files: [
			    'style.css'
			    'app.js'
			  ]


	grunt.loadNpmTasks 'grunt-contrib-coffee'
	grunt.loadNpmTasks 'grunt-contrib-jade'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	# grunt.loadNpmTasks 'grunt-contrib-concat'
	grunt.loadNpmTasks 'grunt-contrib-sass'


	grunt.registerTask 'default', ['sass:dev', 'jade:dev', 'coffee:dev', 'watch']
	grunt.registerTask 'dev', ['sass:dev', 'jade:dev', 'coffee:dev']
	grunt.registerTask 'dist', ['sass:dist', 'jade:dist', 'coffee:dist']
	# grunt.registerTask 'cof', ['coffee']
