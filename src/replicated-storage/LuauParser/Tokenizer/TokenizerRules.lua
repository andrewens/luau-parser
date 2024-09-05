return {
	-- ignore comments, semicolons, & whitespace
	{ "^%s+", nil },
	{ "^%-%-%[%[.*%]%]", nil }, -- multi line comments
	{ "^%-%-.[^\n]*", nil },
	{ "^;", nil },

	-- control structures
	{ `^do`, "do" },
	{ `^end`, "end" },
	{ `^%(`, "(" },
	{ `^%)`, ")" },

	-- operators
	{ `^[%+%-]`, "ADDITIVE_OPERATOR" },
	{ `^[%*%/]`, "MULTIPLICATIVE_OPERATOR" },

	-- literals
	{ `^%d+`, "NUMBER" },
	{ `^"[^"]*"`, "STRING" },
	{ `^'[^']*'`, "STRING" },
}
