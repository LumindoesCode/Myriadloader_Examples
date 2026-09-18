
--This creates a global data object and assigns it to the debug variable.
debug = global_data()

function debug.Step()
    --This line checks for whenever the R button is pressed, and executes the code inside of it.
    if (call_function("keyboard_check_pressed", {call_function("ord", {"R"})}) == 1) then
        --use spawn_object to, well, spawn objects.
        local damage_up = spawn_object(view_x + 120, view_y + 120, "obj_damage_up")
        --The line below takes the damage_up variable (which has the damage up object),
        --and sets its shop cost to 0.

        --Without this, the object will spawn with a scrap price, which is not ideal for testing.
        set_var(damage_up, "shop_cost", 0)
    end
end

--This registers the global data to Myriad, letting it function in game!
--Don't forget it, since it could save you lots of trouble.
register_data(debug)


--REQUIRED FUNCTION: Put your require()s in here
function mod_load()
    require("ExampleOfProvidence/enemies/movingEnemy")
    require("ExampleOfProvidence/enemies/shootingEnemy")
end

--REQUIRED FUNCTION: Currently mostly useless, but required nonetheless
function mod_unload()
    
end
