package main

import (
	"context"
	"os"

	"deep_into_dagger"

	"cuelang.org/go/cue"
	"cuelang.org/go/tools/flow"
)

var r cue.Runtime

func main() {
	if len(os.Args) != 3 {
		panic("Usage: ./main.go *.cue isRoot")
	}

	file := os.Args[1]
	flag := os.Args[2]

	b, err := os.ReadFile(file)
	if err != nil {
		panic(err)
	}
	inst, err := r.Compile(file, b)
	if err != nil {
		panic(err)
	}

	flow := flow.New(
		&flow.Config{},
		inst.Value(),
		func(flowVal cue.Value) (flow.Runner, error) {
			if !flowVal.Lookup(flag).Exists() {
				return nil, nil
			}

			return flow.RunnerFunc(func(t *flow.Task) error {
				return nil
			}), nil
		},
	)

	deep_into_dagger.PrintTasks(flow.Tasks(), 0)

	err = flow.Run(context.TODO())
	if err != nil {
		panic(err)
	}
}
