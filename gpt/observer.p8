-- Observer Pattern
Subject = {}
Subject.__index = Subject

function Subject:new()
    local subject = {
        observers = {}
    }
    setmetatable(subject, Subject)
    return subject
end

function Subject:addObserver(observer)
    table.insert(self.observers, observer)
end

function Subject:notifyObservers()
    for _, observer in ipairs(self.observers) do
        observer:update(self)
    end
end

RuleObserver = {}
RuleObserver.__index = RuleObserver

function RuleObserver:new()
    local observer = {}
    setmetatable(observer, RuleObserver)
    return observer
end

function RuleObserver:update(subject)
    print("Rules updated:", table.concat(subject.rules, ", "))
end

-- Extending GameState to be an observable subject
setmetatable(GameState, {__index = Subject})

-- Usage
gameState = GameState:new()
ruleObserver = RuleObserver:new()
gameState:addObserver(ruleObserver)
gameState:addRule("Baba Is You")