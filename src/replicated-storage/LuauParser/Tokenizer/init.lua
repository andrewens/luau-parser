-- dependency
local TokenizerRules = require(script.TokenizerRules)

-- var
local TokenizerMetatable

-- public / Tokenizer class methods
local function tokenizerHasMoreTokens(self)
	return self._Cursor <= string.len(self._String)
end
local function tokenizerGetNextToken(self)
	if not tokenizerHasMoreTokens(self) then
		return
	end

	for _, TokenizerRule in TokenizerRules do
        local regexp, tokenType = table.unpack(TokenizerRule)
		local matchedValue = string.match(self._String, regexp, self._Cursor)

		if matchedValue == nil then
			continue
		end

		self._Cursor += string.len(matchedValue)

        if tokenType == nil then
            return tokenizerGetNextToken(self)
        end

		return {
			Type = tokenType,
			Value = matchedValue,
		}
	end

	error(`Unexpected token: "{string.sub(self._String, self._Cursor, self._Cursor)}"`)
end

-- public
local function newTokenizer(luauCode)
	local self = {}
	self._Cursor = 1
	self._String = luauCode

	setmetatable(self, TokenizerMetatable)

	return self
end
local function initializeTokenizer()
	local TokenizerMethods = {
		HasMoreTokens = tokenizerHasMoreTokens,
		GetNextToken = tokenizerGetNextToken,
	}
	TokenizerMetatable = { __index = TokenizerMethods }
end

return {
	new = newTokenizer,
	initialize = initializeTokenizer,
}
