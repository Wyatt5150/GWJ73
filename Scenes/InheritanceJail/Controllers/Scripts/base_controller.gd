extends ConnectedParent
class_name BaseController

func Do_Action(action : String, _args : Array = []):
	if action in parent.commands.keys():
		parent.commands[action].call(_args)
		
