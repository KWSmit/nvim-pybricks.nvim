local M = {}

global_opts = nil

function M.setup(opts)
	global_opts = opts or {}
end

function M.set_hub_name()
	-- Set the name for the hub to use.
	vim.ui.input({
		prompt = "Enter hub name: ",
	}, function(input)
		if input then
			global_opts.hub_name = input
		end
	end)
end

function M.set_connection_type()
	-- Set connection type (usb or ble).
	vim.ui.input({
		prompt = "Enter connection type (usb or ble): ",
	}, function(input)
		if input then
			global_opts.connection_type = input
		end
	end)
end

function M.run_program(hub_name)
	-- Upload and run current file on specified LEGO Hub.
	-- Argument hub_name is optional. When given, the program
	-- will be uploaded to this hub. Otherwise the global hub_name
	-- will be used.

	local hub = nil

	-- Check if hub_name is given as argument.
	if hub_name ~= "" and hub_name ~= nil then
		hub = hub_name
	else
		if global_opts.hub_name == nil then
			M.set_hub_name()
		end
		hub = global_opts.hub_name
	end

	-- Check if connection_type is set. When not, ask user to set it.
	if global_opts.connection_type == nil then
		M.set_connection_type()
	end

	-- Upload and run current program to hub.
	local f = vim.fn.expand("%:p")
	vim.cmd("! pybricksdev run " .. global_opts.connection_type .. " --name " .. hub .. " " .. f)
end

return M
