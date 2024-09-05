return {
	Program = [[
    ((1 + 2) * (3 - 4)) + 5 / (6  + 7)
]],
	SyntaxTree = {
		Type = "Chunk",
		Body = {
			{
				Type = "ExpressionStatement",
				Expression = {
					Type = "BinaryExpression",
					Operator = "+",
					Left = {
						Type = "BinaryExpression",
						Operator = "*",
						Left = {
							Type = "BinaryExpression",
							Operator = "+",
							Left = {
								Type = "NumericLiteral",
								Value = 1,
							},
							Right = {
								Type = "NumericLiteral",
								Value = 2,
							},
						},
						Right = {
							Type = "BinaryExpression",
							Operator = "-",
							Left = {
								Type = "NumericLiteral",
								Value = 3,
							},
							Right = {
								Type = "NumericLiteral",
								Value = 4,
							},
						},
					},
					Right = {
						Type = "BinaryExpression",
						Operator = "/",
						Left = {
							Type = "NumericLiteral",
							Value = 5,
						},
						Right = {
							Type = "BinaryExpression",
							Operator = "+",
							Left = {
								Type = "NumericLiteral",
								Value = 6,
							},
							Right = {
								Type = "NumericLiteral",
								Value = 7,
							},
						},
					},
				},
			},
		},
	},
}
