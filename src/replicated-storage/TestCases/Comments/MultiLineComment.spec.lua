return {
	Program = [==[

	--[[
		Multi-line comment:
	]]
	42
	
]==],
	SyntaxTree = {
		Type = "Chunk",
		Body = {
			{
				Type = "ExpressionStatement",
				Expression = {
					Type = "NumericLiteral",
					Value = 42,
				},
			},
		},
	},
}
