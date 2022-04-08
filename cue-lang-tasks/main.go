package main

import (
	"context"
	"fmt"
	"os"
	"strings"

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

	printTasks(flow.Tasks(), 0)

	err = flow.Run(context.TODO())
	if err != nil {
		panic(err)
	}
}

func printTasks(tasks []*flow.Task, depth int) {
	prefix := strings.Repeat("    ", depth)
	for _, task := range tasks {
		fmt.Printf("%s#%d %s\n", prefix, depth, task.Path().String())
		if len(task.Dependencies()) > 0 {
			printTasks(task.Dependencies(), depth+1)
		}
	}
}
