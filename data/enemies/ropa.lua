local enemy = ...

-- Ropa.

sol.main.load_file("enemies/generic_towards_hero")(enemy)
enemy:set_properties({
  sprite = "enemies/ropa",
  life = 2,
  damage = 2,
  normal_speed = 32,
  faster_speed = 32,
  hurt_style = "monster",
  movement_create = function()
    return sol.movement.create("random")
  end
})

