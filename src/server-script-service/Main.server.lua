local ReplicatedStorage = game:GetService("ReplicatedStorage")

local TestsFolder = ReplicatedStorage.Tests

local TestEZ = require(ReplicatedStorage.TestEZ)
local LuauParser = require(ReplicatedStorage.LuauParser)

LuauParser.initialize()
TestEZ.TestBootstrap:run({ TestsFolder })
