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
			Type = "NumericLiteral",
			Value = 42,
		},
	},
}
