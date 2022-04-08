// The logic of finding the root node when flow.New
// The traversal will stop at the level of isRoot and will not affect the continuation of the traversal of sibling nodes

plan: {
	actions: {
		isRoot: true
		labels: [string]: string

		prepare: {
			isRoot: true
		}

		lint: {
		}

		test: {
		}

		build: {
		}
	}

	other: {
		msg: "this is other"
		labels: actions.labels
	}
}

error: {
	"msg": "error msg"
}