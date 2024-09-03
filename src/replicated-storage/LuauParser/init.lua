-- dependency
local Parser = require(script.Parser)

-- public
local function initLuauParser() end

return {
	initialize = initLuauParser,
	parse = Parser.parse,
}
