return {
	-- ignore comments, semicolons, & whitespace
	{ "^%s+", nil },
	{ "^%-%-%[%[.*%]%]", nil }, -- multi line comments
	{ "^%-%-.[^\n]*", nil },
	{ "^;", nil },

	-- operators
	{ `^[%+/%-]`, "ADDITIVE_OPERATOR" },

	-- control structures
	{ `^do`, "do" },
	{ `^end`, "end" },

	-- literals
	{ `^%d+`, "NUMBER" },
	{ `^"[^"]*"`, "STRING" },
	{ `^'[^']*'`, "STRING" },
}
