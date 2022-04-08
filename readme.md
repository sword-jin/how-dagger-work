# how-dagger-work

## List

- cue-lang
  - basic-1.cue, no nest, no dependency
  - basic-2.cue, has nest, no dependency
  - pipeline.cue, has nest, has dependency

```
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
