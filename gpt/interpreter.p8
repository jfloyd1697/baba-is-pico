-- Interpreter Pattern
RuleInterpreter = {}
RuleInterpreter.__index = RuleInterpreter

function RuleInterpreter:new()
    local interpreter = {}
    setmetatable(interpreter, RuleInterpreter)
    return interpreter
end

function RuleInterpreter:interpret(rule, gameState)
    local subject, is_, predicate = rule:match("(%w+) (Is) (%w+)")
    if is_ ~= "Is" then
        error("Invalid rule format")
    end
    -- Implement rule logic here
    if subject == "Baba" and predicate == "You" then
        gameState:setPlayerEntity(baba)
    end
end