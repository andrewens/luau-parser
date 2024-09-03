-- dependency
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local LuauParser = require(ReplicatedStorage.LuauParser)

local TestCasesFolder = ReplicatedStorage.TestCases

-- private
local function tableDeepEqual(Table1, Table2)
	if typeof(Table1) == "table" and typeof(Table2) == "table" then
		for k, v in Table1 do
			if not tableDeepEqual(v, Table2[k]) then
				return false
			end
		end
		for k, v in Table2 do -- redundant, but avoids extra memory
			if not tableDeepEqual(v, Table1[k]) then
				return false
			end
		end

		return true
	end

	return Table1 == Table2
end

-- test
return function()
	describe("LuauParser", function()
		for i, TestCaseModule in TestCasesFolder:GetChildren() do
			local TestCase = require(TestCaseModule)

			it(TestCaseModule.Name, function()
				local AST = LuauParser.parse(TestCase.Program)

				if not tableDeepEqual(AST, TestCase.SyntaxTree) then
					warn("Program:", TestCase.Program)
					warn("Result", AST)
					warn("Correct Answer", TestCase.SyntaxTree)
					error(`Failed Test`)
				end
			end)
		end
	end)
end
