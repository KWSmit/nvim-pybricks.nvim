-- Keymapping and user commands

-- Upload and run file on specified Pybricks hub,
vim.api.nvim_create_user_command(
    -- Takes zero or one argument (hubname)
    'PybricksRunFile',
    'lua require("nvim-pybricks").run_file(<q-args>)',
    { nargs = '?' }
)

vim.api.nvim_set_keymap(
    'n',
    '<leader>pr',
    ':lua require("nvim-pybricks").run_file()<CR>',
    { silent = true }
)

-- Set global value for hubname
vim.api.nvim_create_user_command(
    -- Takes zero or one argument (hubname)
    "PybricksSetHubName",
    ":lua require('nvim-pybricks').set_global_hub_name(<q-args>)",
    { nargs = '?' }
)
