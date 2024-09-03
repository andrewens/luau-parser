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

    local char = string.sub(self._String, self._Cursor, self._Cursor)

    -- numbers
    if tonumber(char) then
        local number = ""
        repeat
            number ..= char
            char = getNextChar(self)
        until tonumber(char) == nil

        return {
            Type = "NUMBER",
            Value = tonumber(number),
        }
    end

    -- strings
    if char == '"' or char == "'" then
        local string = char
        repeat
            char = getNextChar(self)
            string ..= char
        until char == '"' or isEndOfFile(self)

        return {
            Type = "STRING",
            Value = `{string}`
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
