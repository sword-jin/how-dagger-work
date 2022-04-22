package main

import (
	"fmt"
	"os"

	"cuelang.org/go/cue"
	"cuelang.org/go/cue/cuecontext"
	cuejson "cuelang.org/go/encoding/json"
)

var issue []byte

func init() {
	issue, _ = os.ReadFile("./issue.json")
}

func main() {
	compiler := cuecontext.New()

	root := compiler.CompileString("_", cue.Filename(""))
	if root.Err() != nil {
		panic(root.Err())
	}

	expr, err := cuejson.Extract("", issue)
	if err != nil {
		panic(err)
	}

	issueExpr := compiler.BuildExpr(expr, cue.Filename(""))
	if issueExpr.Err() != nil {
		panic(issueExpr.Err())
	}

	valueWithIssue := root.Fill(issueExpr, "issue")
	fmt.Print(valueWithIssue)
}
