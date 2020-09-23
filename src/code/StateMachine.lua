StateMachine = class()

function StateMachine:init(states)
    self.currentState = BaseState()
    self.states = states
end

function StateMachine:changeState(newState, parameters)
    assert(self.states[newState])
    self.currentState:exit()
    self.currentState = self.states[newState]
    self.currentState:enter(parameters)
end

function StateMachine:update(dt)
    self.currentState:update(dt)
end

function StateMachine:render()
    self.currentState:render()
end
