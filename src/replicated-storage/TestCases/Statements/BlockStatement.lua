return {
	Program = [[
    
do
    42;

    "hello";
end

]],
	SyntaxTree = {
		Type = "Chunk",
		Body = {
			{
				Type = "BlockStatement",
				Body = {
					{
						Type = "ExpressionStatement",
						Expression = {
							Type = "NumericLiteral",
							Value = 42,
						},
					},
					{
						Type = "ExpressionStatement",
						Expression = {
							Type = "StringLiteral",
							Value = "hello",
						},
					},
				},
			},
		},
	},
}
