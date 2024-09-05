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

--[[
	Generic binary expression.
]]
local function binaryOperator(self, expressionMethod, operatorToken)
	local left = expressionMethod(self)

	while self._NextToken and self._NextToken.Type == operatorToken do
		local operator = eatNextToken(self, operatorToken).Value
		local right = expressionMethod(self)

		left = {
			Type = "BinaryExpression",
			Operator = operator,
			Left = left,
			Right = right,
		}
	end

	return left
end

-- private / Production methods
local StatementList, Expression

--[[
	StringLiteral
	  : STRING
	  ;
]]
local function StringLiteral(self)
	local Token = eatNextToken(self, "STRING")

	return {
		Type = "StringLiteral",
		Value = string.sub(Token.Value, 2, -2),
	}
end

--[[
	NumericLiteral
	  : NUMBER
	  ;
]]
local function NumericLiteral(self)
	local Token = eatNextToken(self, "NUMBER")

	return {
		Type = "NumericLiteral",
		Value = tonumber(Token.Value),
	}
end

--[[
	Literal
	  : NumericLiteral
	  | StringLiteral
	  ;
]]
local function Literal(self)
	local NextToken = self._NextToken
	if NextToken.Type == "NUMBER" then
		return NumericLiteral(self)
	elseif NextToken.Type == "STRING" then
		return StringLiteral(self)
	end

	error(`Literal: unexpected literal production: {NextToken and NextToken.Type or nil}`)
end

--[[
	ParenthesizedExpression
	  : '(' Expression ')'
	  ;
]]
local function ParenthesizedExpression(self)
	eatNextToken(self, "(")
	local expression = Expression(self)
	eatNextToken(self, ")")
	return expression
end

--[[
	PrimaryExpression
	  : Literal
	  | ParenthesizedExpression
	  ;
]]
local function PrimaryExpression(self)
	if self._NextToken.Type == "(" then
		return ParenthesizedExpression(self)
	end
	return Literal(self)
end

--[[
	MultiplicativeExpression
	  : PrimaryExpression
	  | MultiplicativeExpression MULTIPLICATIVE_OPERATOR PrimaryExpression
	  ;
]]
local function MultiplicativeExpression(self)
	return binaryOperator(self, PrimaryExpression, "MULTIPLICATIVE_OPERATOR")
end

--[[
	AdditiveExpression
	  : MultiplicativeExpression
	  | AdditiveExpression ADDITIVE_OPERATOR MultiplicativeExpression
	  ;
]]
local function AdditiveExpression(self)
	return binaryOperator(self, MultiplicativeExpression, "ADDITIVE_OPERATOR")
end

--[[
	Expression
	  : Literal
	  ;
]]
function Expression(self)
	return AdditiveExpression(self)
end

--[[
	ExpressionStatement
	  : Expression
	  ;
]]
local function ExpressionStatement(self)
	return {
		Type = "ExpressionStatement",
		Expression = Expression(self),
	}
end

--[[
	BlockStatement
	  : 'do' StatementList 'end'
	  ;
]]
local function BlockStatement(self)
	eatNextToken(self, "do")

	local body = if self._NextToken.Type == "end" then {} else StatementList(self, "end")

	eatNextToken(self, "end")

	return {
		Type = "BlockStatement",
		Body = body,
	}
end

--[[
	Statement
	  : BlockStatement
	  | ExpressionStatement
	  ;
]]
local function Statement(self)
	if self._NextToken.Type == "do" then
		return BlockStatement(self)
	end
	return ExpressionStatement(self)
end

--[[
	StatementList
	  : Statement
	  | StatementList Statement --> Statement Statement Statement ... Statement
	  ;
]]
function StatementList(self, stopLookAheadSymbol)
	local StatList = { Statement(self) }

	while self._NextToken and self._NextToken.Type ~= stopLookAheadSymbol do
		table.insert(StatList, Statement(self))
	end

	return StatList
end

--[[
	Chunk
	  : StatementList
	  ;
]]
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
