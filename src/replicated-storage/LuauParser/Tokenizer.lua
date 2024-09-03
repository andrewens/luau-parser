-- var
local TokenizerMetatable

-- private / Tokenizer class methods
local function isEndOfFile(self)
	return self._Cursor > string.len(self._String)
end
local function getNextChar(self)
	self._Cursor += 1
	return string.sub(self._String, self._Cursor, self._Cursor)
end

-- public / Tokenizer class methods
local function tokenizerHasMoreTokens(self)
	return self._Cursor <= string.len(self._String)
end
local function tokenizerGetNextToken(self)
	if not tokenizerHasMoreTokens(self) then
		return
	end

	-- numbers
	local number = string.match(self._String, "^%d+", self._Cursor)
	if number then
		self._Cursor += string.len(number)

		return {
			Type = "NUMBER",
			Value = number,
		}
	end

	-- strings
    local matchedString = string.match(self._String, `^"[^"]*"`, self._Cursor)
        or string.match(self._String, `^'[^']*'`, self._Cursor)
	if matchedString then
        self._Cursor += string.len(matchedString)

		return {
			Type = "STRING",
			Value = matchedString,
		}
	end
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
