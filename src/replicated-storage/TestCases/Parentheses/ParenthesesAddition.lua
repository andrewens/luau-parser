return {
	Program = [[
    
    (1 + 2) * 3    
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
						Type = "NumericLiteral",
						Value = 3,
					},
				},
			},
		},
	},
}
