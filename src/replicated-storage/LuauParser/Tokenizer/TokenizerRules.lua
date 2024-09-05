return {
	-- ignore comments, semicolons, & whitespace
	{ "^%s+", nil },
	{ "^%-%-%[%[.*%]%]", nil }, -- multi line comments
	{ "^%-%-.[^\n]*", nil },
	{ "^;", nil },

	-- literals
	{ `^%d+`, "NUMBER" },
	{ `^"[^"]*"`, "STRING" },
	{ `^'[^']*'`, "STRING" },

	-- control structures
	{ `^do`, "do" },
	{ `^end`, "end" },
}
