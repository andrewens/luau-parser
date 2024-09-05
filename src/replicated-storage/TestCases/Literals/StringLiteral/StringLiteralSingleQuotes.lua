return {
	Program = `'hello'`,
	SyntaxTree = {
		Type = "Chunk",
		Body = {
			{
				Type = "ExpressionStatement",
				Expression = {
					Type = "StringLiteral",
					Value = "hello",
				},
			},
		},
	},
}
