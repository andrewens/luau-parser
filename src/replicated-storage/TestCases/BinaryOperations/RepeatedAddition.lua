return {
	Program = [[
-- addition is left associative
    2 + 3 - 4
]],
	SyntaxTree = {
		Type = "Chunk",
		Body = {
			{
				Type = "ExpressionStatement",
				Expression = {
					Type = "BinaryExpression",
					Operator = "-",
					Left = {
						Type = "BinaryExpression",
						Operator = "+",
						Left = {
							Type = "NumericLiteral",
							Value = 2,
						},
						Right = {
							Type = "NumericLiteral",
							Value = 3,
						},
					},
					Right = {
						Type = "NumericLiteral",
						Value = 4,
					},
				},
			},
		},
	},
}
