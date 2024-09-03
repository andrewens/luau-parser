return {
	{ "^%s+", nil },
	{ `^%d+`, "NUMBER" },
	{ `^"[^"]*"`, "STRING" },
	{ `^'[^']*'`, "STRING" },
}
