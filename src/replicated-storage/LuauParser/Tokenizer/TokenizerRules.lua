return {
	{ "^%s+", nil },
	{ "%-%-.[^\n]*", nil },
	{ `^%d+`, "NUMBER" },
	{ `^"[^"]*"`, "STRING" },
	{ `^'[^']*'`, "STRING" },
}
