return {
	-- ignore comments & whitespace
	{ "^%s+", nil },
	{ "^%-%-%[%[.*%]%]", nil }, -- multi line comments
	{ "^%-%-.[^\n]*", nil },

	-- literals
	{ `^%d+`, "NUMBER" },
	{ `^"[^"]*"`, "STRING" },
	{ `^'[^']*'`, "STRING" },
}
