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

-- GameState to manage the game state
GameState = {}
GameState.__index = GameState

function GameState:new()
    local gameState = {
        rules = {},
        playerEntity = nil
    }
    setmetatable(gameState, GameState)
    return gameState
end

function GameState:setPlayerEntity(entity)
    self.playerEntity = entity
end

function GameState:addRule(rule)
    table.insert(self.rules, rule)
    self:notifyObservers()
end

-- Usage
gameState = GameState:new()
interpreter = RuleInterpreter:new()
interpreter:interpret("Baba Is You", gameState)