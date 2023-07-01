local M = {}

local _config = {}
local _hub_name = nil


function M.setup(config)
    _config = config
end

function ask_hub()
    -- Ask hub name
    result = nil
    vim.ui.input({
        prompt = "Enter hub name: ",
    }, function(input)
        if input then
            result = input 
        end
    end)
    return result
end

function M.run_file(hub_name)
    -- Upload and run current file on specified LEGO Hub.
    -- hub_name is optional argument. Use argument hub_name when given,
    -- or the global value for hubname when argument not given.

    if hub_name ~= '' and hub_name ~= nil then
        -- Argument given
        _hub_name = hub_name
    else
        -- Check if global variable for hubname is not nil
        global_hub_name = vim.api.nvim_get_var('global_pybricks_hub_name')
        if global_hub_name == nil then
            -- No value, so ask user for hubname
            global_hub_name = ask_hub()
            -- Set global variable for hubname for later use during session
            vim.api.nvim_set_var('global_pybricks_hub_name', global_hub_name)
        end
        _hub_name = global_hub_name
    end

    -- Upload and run current file to hub.
    f = vim.fn.expand('%:p')
    vim.cmd("! pybricksdev run ble --name " .. _hub_name .. " " .. f)

end

function M.set_global_hub_name(hub_name)
    -- Set value for global variable for hubname

    if hub_name ~= '' and hub_name ~= nil then
        _hub_name = hub_name
    else
        _hub_name = ask_hub()
    end

    -- Set global variable for hubname for later use during session
    vim.api.nvim_set_var('global_pybricks_hub_name', _hub_name)

end

return M
