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
local StatementList
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

	error(`Literal: unexpected literal production: {NextToken and NextToken.Type or nil}`)
end
local function PrimaryExpression(self)
	return Literal(self)
end
local function MultiplicativeExpression(self)
	local left = PrimaryExpression(self)

	while self._NextToken and self._NextToken.Type == "MULTIPLICATIVE_OPERATOR" do
		local operator = eatNextToken(self, "MULTIPLICATIVE_OPERATOR").Value
		local right = PrimaryExpression(self)

		left = {
			Type = "BinaryExpression",
			Operator = operator,
			Left = left,
			Right = right,
		}
	end

	return left
end
local function AdditiveExpression(self)
	local left = MultiplicativeExpression(self)

	while self._NextToken and self._NextToken.Type == "ADDITIVE_OPERATOR" do
		local operator = eatNextToken(self, "ADDITIVE_OPERATOR").Value
		local right = MultiplicativeExpression(self)

		left = {
			Type = "BinaryExpression",
			Operator = operator,
			Left = left,
			Right = right,
		}
	end

	return left
end
local function Expression(self)
	return AdditiveExpression(self)
end
local function ExpressionStatement(self)
	return {
		Type = "ExpressionStatement",
		Expression = Expression(self),
	}
end
local function BlockStatement(self)
	eatNextToken(self, "do")

	local body = if self._NextToken.Type == "end" then {} else StatementList(self, "end")

	eatNextToken(self, "end")

	return {
		Type = "BlockStatement",
		Body = body,
	}
end
local function Statement(self)
	if self._NextToken.Type == "do" then
		return BlockStatement(self)
	end
	return ExpressionStatement(self)
end
function StatementList(self, stopLookAheadSymbol)
	local StatList = { Statement(self) }

	while self._NextToken and self._NextToken.Type ~= stopLookAheadSymbol do
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
