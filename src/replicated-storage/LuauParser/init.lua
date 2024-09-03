-- dependency
local Parser = require(script.Parser)
local Tokenizer = require(script.Tokenizer)

-- public
local function initLuauParser()
    Tokenizer.initialize()
end

return {
	initialize = initLuauParser,
	parse = Parser.parse,
}
