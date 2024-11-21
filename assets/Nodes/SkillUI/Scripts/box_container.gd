extends BoxContainer

@onready var amount_textH: Label = $BoxContainer/health/Label
@onready var amount_textS: Label = $BoxContainer/strength/Label
@onready var amount_textA: Label = $BoxContainer/agility/Label
@onready var amount_textD: Label = $BoxContainer/defense/Label
@onready var amount_textC: Label = $BoxContainer/crit_dmg/Label

func update()
