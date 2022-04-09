package main

import (
	"context"
	"deep_into_dagger"
	"log"
	"os"
	"time"

	"cuelang.org/go/cue"
	"cuelang.org/go/tools/flow"
)

var r cue.Runtime
var lg = log.New(os.Stderr, "flow: ", log.Ltime)

func main() {
	if len(os.Args) != 2 {
		panic("Usage: ./main.go *.cue")
	}

	file := os.Args[1]

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
			isTask := flowVal.Lookup("isTask")
			if !isTask.Exists() {
				return nil, nil
			}

			sleep, err := flowVal.Lookup("sleep").Int64()
			if err != nil {
				panic("should mock io duration")
			}

			return flow.RunnerFunc(func(t *flow.Task) error {
				lg.Printf("task %s start, sleep %d seconds\n", t.Path(), sleep)
				if sleep > 0 {
					time.Sleep(time.Duration(sleep) * time.Second)
				}
				lg.Printf("task %s complete\n", t.Path())
				return nil
			}), nil
		},
	)

	deep_into_dagger.PrintTasks(flow.Tasks(), 0)

	if err := flow.Run(context.TODO()); err != nil {
		panic(err)
	}
}
