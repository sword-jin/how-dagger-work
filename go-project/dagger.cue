package main

import (
    "dagger.io/dagger"
    "universe.dagger.io/go"
)

dagger.#Plan & {
	client: {
		filesystem: {
			"../": read: contents: dagger.#FS
			"./build": write: contents: actions.build.output
		}

		env: {
			GOOS: string
			GOARCH: string
		}
	}

	actions: {
		test: go.#Test & {
			source: client.filesystem."../".read.contents
		}

		// [this is docs.]
		build: go.#Build & {
			_dep: test

			source: client.filesystem."../".read.contents

			package: "./go-project"

			arch: client.env.GOARCH

			os: client.env.GOOS
		}
	}
}
