-- private / Parser class methods
local function NumericLiteral(self)
	return {
		Type = "NumericLiteral",
		Value = tonumber(self._String),
	}
end
local function Chunk(self)
	return {
		Type = "Chunk",
		Body = NumericLiteral(self),
	}
end

-- public
local function parseLuauCode(luauCode)
	local self = {}
	self._String = luauCode

	return Chunk(self)
end

return {
	parse = parseLuauCode,
}
