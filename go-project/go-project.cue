package main

import (
    "dagger.io/dagger"
    "universe.dagger.io/go"
)

dagger.#Plan & {
	client: {
		filesystem: {
			"../": read: {
				contents: dagger.#FS
				exclude: [
					".vscode",
					"cue-flow-dag",
					"cue-flow-execute",
					".gitignore",
					"readme.md",
				]
			},
			"./build": write: contents: actions.build.output
		}
	}

	actions: {
		_goimage: go.#Image & {
			version: "1.18"
		}

		test: go.#Test & {
			source: client.filesystem."../".read.contents
		}

		build: go.#Build & {
			_dep: test

			source: client.filesystem."../".read.contents

			package: "./go-project"

			arch: "arm64"

			os: "darwin"

			container: go.#Container & {
				_image: _goimage
			}
		}
	}
}
