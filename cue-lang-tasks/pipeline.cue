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
			isRoot: true
			output: "lint success"
		}

		test: {
			isRoot: true
			input: lint.output
			output: "Mocha"
		}

		build: {
			isRoot: true
			input: test.output
			contents: {
				input: "./",
				output: "./_build"
			}
		}
	}
}