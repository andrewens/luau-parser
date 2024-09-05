return {
	Program = [==[
    
    --[[
        Multi-line comment
    ]]
    42;

    -- Single-line comment
    "hello";
    
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
