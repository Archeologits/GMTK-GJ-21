extends Node
class_name StateMachine

const DEBUG = true

var state: Object
var parent : Object

func _ready():
  # Set the initial state to the first child node
  state = get_child(0)
  parent = get_parent()
  _enter_state()
    
func get_state():
  return state.name

func transition(new_state):
  state.exit(new_state)

func _change_to(new_state):
  state = get_node(new_state)
  _enter_state()

func _enter_state():
  if DEBUG:
    print("Entering state: ", state.name)
  # Give the new state a reference to this state machine script
  state.fsm = self
  state.object = self.parent
  state.enter()

# Route Game Loop function calls to
# current state handler method if it exists
func _process(delta):
  if state.has_method("process"):
    state.process(delta)

func _physics_process(delta):
  if state.has_method("physics_process"):
    state.physics_process(delta)

func _input(event):
  if state.has_method("input"):
    state.input(event)
