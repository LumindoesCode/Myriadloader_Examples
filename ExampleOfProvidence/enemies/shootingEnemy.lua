shooting_enemy = enemy_data("shooting_enemy")

--Helper functions created by Ennway.
--Useful for turning positions into angles.
function rot_x(rotation) return math.cos(math.rad(rotation)) end
function rot_y(rotation) return -math.sin(math.rad(rotation)) end

--The create function runs every time an enemy is spawned.
function shooting_enemy.Create(obj)
    --Sets the sprite index to a skully who stares into your soul
    set_var(obj, "sprite_index", get_asset("spr_skully"))

    --Sets the health and max health. the max health is important so that health bars don't break.
    set_var(obj, "hp", 75)
    set_var(obj, "maxhp", 75)

    --Sets the default debris this enemy gives.
    set_var(obj, "debris_score", 20)
end

--The step functions runs on every frame.
function shooting_enemy.Step(obj)
    --Initializes an activation_timer variable once.
    --Not to be confused with set_var, which sets a variable multiple times.
    init_var(obj, "activation_timer", 0)
    
    --Increases the timer by 1 every frame.
    set_var(obj, "activation_timer", get_var(obj, "activation_timer") + 1)

    --Checks if the timer is above 60 frames, or 1 second.
    if (get_var(obj, "activation_timer") >= 60) then
        
        --Using this allows for regular delays between shots, in this case, shoot a bullet every 30 frames.
        if (math.fmod(get_var(obj, "activation_timer"), 30) == 0) then
            --Gets the direction needed using Gamemaker's point_direction function.
            local dir = call_function("point_direction", {get_var(obj, "x"), get_var(obj, "y"), player_x, player_y})

            --Spawns a projectile at the current object's x and y value, with the direction it should move in and the asset.
            spawn_projectile(get_var(obj, "x"), get_var(obj, "y"), rot_x(dir), rot_y(dir), get_asset("spr_bullet1"))
        end
    end
end

--Registers the data to Myriadloader.
register_data(shooting_enemy)