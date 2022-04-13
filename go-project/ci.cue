package main

import (
    "dagger.io/dagger"
    "universe.dagger.io/go"
	"github.com/dagger/dagger/ci/golangci"
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
		_source: client.filesystem["../"].read.contents

		lint: {
			go: golangci.#Lint & {
				source:  _source
				version: "1.45"
			}
		}

		test: go.#Test & {
			source: _source
		}

		// [this is docs.]
		build: go.#Build & {
			source: _source

			package: "./go-project"

			arch: client.env.GOARCH

			os: client.env.GOOS
		}
	}
}
