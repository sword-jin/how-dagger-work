# how-dagger-work

## core idea

### 1. how cue-flow generate a dag

- basic-1.cue, no nest, no dependency
- basic-2.cue, has nest, no dependency
- pipeline.cue, has nest, has dependency

```bash
cd cue-flow-dag
go run main.go basic-1.cue isRoot
```

`flow` can generate some dependency trees like this:

```
#0 Pipeline.client."./".read.contents
#0 Pipeline.client."./_build".write.contents
    #1 Pipeline.jobs.build
        #2 Pipeline.jobs.test
            #3 Pipeline.jobs.lint
```

**core code**

- <https://github.com/cue-lang/cue/blob/41364815392be45549d4be05195010a183b4ac04/tools/flow/tasks.go#L50>

### 2. how cue-flow execute a dag

```bash
cd cue-flow-execute
go run main.go deploy-site.cue
```

`flow` can execute a dag according to dependency trees, **Tasks belonging to the same level of height can be processed in parallel**
**core code**

- <https://github.com/cue-lang/cue/blob/4136481539/tools/flow/run.go#L58>

can describe a simple pseudo-code:

```go
// ...
for {
    for _, t := range flow.tasks {
        switch task.status {
            case Waiting:
                waiting = true
            case Ready:
                t.status = Running
                // handle task
                // if no err
                t.status = Success

                for _, t2 := range flow.tasks {
                    if t2.status == Waiting && t.IsReady() {
                        t2.status = Ready
                    }
                }
        }
    }
}
// ...

// Check task is ready for execute
func (t *Task) IsReady() bool {
    for _, dep := range t.deps {
        if dep.status != Success {
            return false
        }
    }
    return true
}

```

### 3. real-world example

```bash
make test -B
make build -B
```
