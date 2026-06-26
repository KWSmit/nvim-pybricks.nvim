-- User commands

-- Set global value for hub_name.
vim.api.nvim_create_user_command(
	-- Takes zero or one argument (hub_name).
	"PybricksSetHubName",
	":lua require('nvim-pybricks').set_hub_name(<q-args>)",
	{ nargs = "?" }
)

-- Set connection type )usb or ble).
vim.api.nvim_create_user_command(
	-- Takes zero or one argument (hub_name).
	"PybricksSetConnectionType",
	":lua require('nvim-pybricks').set_connection_type(<q-args>)",
	{ nargs = "?" }
)
-- Upload and run program on hub.
vim.api.nvim_create_user_command(
	-- Takes zero or one argument (hub_name)
	"PybricksRunProgram",
	'lua require("nvim-pybricks").run_program(<q-args>)',
	{ nargs = "?" }
)
