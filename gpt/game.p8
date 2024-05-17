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