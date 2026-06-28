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
	vim.ui.select({ "ble", "usb" }, {
		prompt = "Select how the hub is connected: ",
		format_item = function(item)
			return item
		end,
	}, function(connection_type, idx)
		if connection_type then
			global_opts.connection_type = connection_type
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

	-- Filename from current buffer.
	local f = vim.fn.expand("%:p")
	-- Pybricksdev command to upload and run program.
	local pybricksdev = "pybricksdev run " .. global_opts.connection_type .. " --name " .. hub .. " " .. f
	-- Toggleterm command to open terminal and run pybricksdev.
	local termex_command = "TermExec cmd='" .. pybricksdev .. "'"
	-- Open terminal and run command.
	vim.cmd(termex_command)
end

return M
