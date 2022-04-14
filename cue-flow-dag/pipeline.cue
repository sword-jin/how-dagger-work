// Focus on the dag of he flow how to generated

Pipeline: {
	client: {
		"./": read: {
			contents: "FS"
		}
		"./_build": write: contents: jobs.build.contents.output
	}

	jobs: {
		lint: {
			isTask: true
			output: "lint success"
		}

		build: {
			isTask: true
			input: test.output
			contents: {
				input: "./",
				output: "./_build"
			}
		}

		test: {
			isTask: true
			input: lint.output
			output: "Mocha"
		}
	}
}