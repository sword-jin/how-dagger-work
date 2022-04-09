#_markTask: {
	isTask: bool | *true
	sleep: >= 0 | *0
	...
}

Dag: {
	prepare: {
		git: clone: #_markTask & {
			sleep: 2

			repo: "git@github.com:rrylee/how-dagger-work.git"

			output: "./src"
		}

		config: #_markTask & {
			sleep: 1

			output: "./config.local.js"
		}
	}

	yarn: #_markTask & {
		sleep: 3

		input: prepare.git.output

		script: #"""
			yarn install
		"""#

		output: "./node_modules"
	}

	build: #_markTask & {
		sleep: 1

		deps: [
			yarn.output,
			prepare.config.output
		]

		script: #"""
			yarn build
		"""#

		output: "./dist"
	}

	deploy: {
		createEC2: #_markTask & {
		}

		rsync: #_markTask & {
			sleep: 2

			src: build.output
			dist: "/etc/nginx/www"
		}
	}
}