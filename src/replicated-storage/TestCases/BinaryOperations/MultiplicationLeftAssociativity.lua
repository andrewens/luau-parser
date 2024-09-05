return {
	Program = [[

    123 * 69 * 420

]],
	SyntaxTree = {
		Type = "Chunk",
		Body = {
			{
				Type = "ExpressionStatement",
				Expression = {
					Type = "BinaryExpression",
					Operator = "*",
					Left = {
						Type = "BinaryExpression",
						Operator = "*",
						Left = {
							Type = "NumericLiteral",
							Value = 123,
						},
						Right = {
							Type = "NumericLiteral",
							Value = 69,
						},
					},
					Right = {
						Type = "NumericLiteral",
						Value = 420,
					},
				},
			},
		},
	},
}
