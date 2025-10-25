
--Without this, you cannot make an enemy.
moving_enemy = enemy_data("moving_enemy")

--Helper functions created by Ennway.
--It gets two x and y values, and calculates a direction x and y.
function rot_x(rotation) return math.cos(math.rad(rotation)) end
function rot_y(rotation) return -math.sin(math.rad(rotation)) end
function get_direction(x1, y1, x2, y2)
  local dir = {}
  local d = call_function("point_direction", {x1, y1, x2, y2})
  dir.x = rot_x(d)
  dir.y = rot_y(d)
  return dir
end

--Helper function created by Ennway.
--Allows for linear interpolation.
function lerp(a, b, x) return a + ((b - a) * x) end

--The create function runs every time an enemy is spawned.
function moving_enemy.Create(obj)
    --Sets the sprite index of the enemy to an existing sprite (in this case, that of the basic ghost enemy.)
    set_var(obj, "sprite_index", get_asset("spr_cuddledroid"))

    --Sets the health and max health. the max health is important so that health bars don't break.
    set_var(obj, "hp", 75)
    set_var(obj, "maxhp", 75)

    --Sets the default debris this enemy gives.
    set_var(obj, "debris_score", 20)
end

--The step functions runs on every frame.
function moving_enemy.Step(obj)
    --Initializes an activation_timer variable once.
    --Not to be confused with set_var, which sets a variable multiple times.
    init_var(obj, "activation_timer", 0)
    
    --Increases the timer by 1 every frame.
    set_var(obj, "activation_timer", get_var(obj, "activation_timer") + 1)

    --Checks if the timer is above 60 frames, or 1 second.
    if (get_var(obj, "activation_timer") >= 60) then
        --Gets the x and y direction the enemy needs to move into the player
        local dir = get_direction(get_var(obj, "x"), get_var(obj, "y"), get_var(player, "x"), get_var(player, "y"))

        --Takes the current horizontal speed of the enemy, setting it to the horizontal direction it needs to move,
        --interpolating it so it doesn't move at incredibly high speeds.
        --Finally, it sets the horizontal speed to this interpolated value.
        set_var(obj, "hspeed", lerp(get_var(obj, "hspeed"), dir.x, 0.12))

        --Ditto, but with vertical speed instead.
        set_var(obj, "vspeed", lerp(get_var(obj, "vspeed"), dir.y, 0.12))

        --Makes the enemy slow down when it has no direction.
        --Otherwise it will not stop moving.
        set_var(obj, "hspeed", get_var(obj, "hspeed") * 0.99)
        set_var(obj, "vspeed", get_var(obj, "vspeed") * 0.99)
    end
end

--Registers the data to Myriadloader.
register_data(moving_enemy)
