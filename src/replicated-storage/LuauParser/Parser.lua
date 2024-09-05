-- dependency
local LuauParserModule = script:FindFirstAncestor("LuauParser")
local Tokenizer = require(LuauParserModule.Tokenizer)

-- private / Parser class methods
local function eatNextToken(self, tokenType)
	local NextToken = self._NextToken

	if NextToken == nil then
		error(`Unexpected end of input; expected "{tokenType}"`)
	end

	if NextToken.Type ~= tokenType then
		error(`Unexpected token: "{NextToken.Type}"; expected "{tokenType}"`)
	end

	self._NextToken = self._Tokenizer:GetNextToken()

	return NextToken
end

-- private / Production methods
local function StringLiteral(self)
    local Token = eatNextToken(self, "STRING")

	return {
		Type = "StringLiteral",
		Value = string.sub(Token.Value, 2, -2),
	}
end
local function NumericLiteral(self)
	local Token = eatNextToken(self, "NUMBER")

	return {
		Type = "NumericLiteral",
		Value = tonumber(Token.Value),
	}
end
local function Literal(self)
	local NextToken = self._NextToken
	if NextToken.Type == "NUMBER" then
		return NumericLiteral(self)
	elseif NextToken.Type == "STRING" then
		return StringLiteral(self)
	end

    error(`Literal: unexpected literal production`)
end
local function Expression(self)
	return Literal(self)
end
local function ExpressionStatement(self)
	return {
		Type = "ExpressionStatement",
		Expression = Expression(self)
	}
end
local function Statement(self)
	return ExpressionStatement(self)
end
local function StatementList(self)
	local StatList = { Statement(self) }

	while (self._NextToken) do
		table.insert(StatList, Statement(self))
	end

	return StatList
end
local function Chunk(self)
	return {
		Type = "Chunk",
		Body = StatementList(self),
	}
end

-- public
local function parseLuauCode(luauCode)
	local self = {}
	self._String = luauCode
	self._Tokenizer = Tokenizer.new(luauCode)
	self._NextToken = self._Tokenizer:GetNextToken()

	return Chunk(self)
end

return {
	parse = parseLuauCode,
}
