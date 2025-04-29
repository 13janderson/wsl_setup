return{
    {
        dir = "~/projects/kbase",
        config = function()
            -- Call setup function which just adds keybinding for chtsht telescope picker
            require "chtsht".setup()
        end
    }
}

