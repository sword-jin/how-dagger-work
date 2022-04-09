package deep_into_dagger

import (
	"fmt"
	"strings"

	"cuelang.org/go/tools/flow"
)

func PrintTasks(tasks []*flow.Task, depth int) {
	prefix := strings.Repeat("    ", depth)
	for _, task := range tasks {
		fmt.Printf("%s#%d %s\n", prefix, depth, task.Path().String())
		if len(task.Dependencies()) > 0 {
			PrintTasks(task.Dependencies(), depth+1)
		}
	}
}
