# nvim-pybricks.nvim

Neovim lua-plugin for programming LEGO® Powered Up hubs with the Pybricks
firmware running on it. With this plugin you can write your code locally on
your PC and upload to and run it on your LEGO hub.

## Requirements

On your PC:

- Neovim 7.0 or newer.
- [pybricksdev](https://github.com/pybricks/pybricksdev).

On your LEGO® Powered Up hub:

- Pybricks Beta v3.0.0-beta.9 version 3.2 or newer.

## Pybricks

Pybricks is Python coding for LEGO® Powered Up hubs. Run MicroPython scripts
on the hub, and get full control of your motors and sensors. Pybricks
is free and open source.

To use the nvim-pybricks plugin, you have to install the Pybricks firmware
on your LEGO® hub. Go to the [Pybricks website](https://pybricks.com/) for
more information.

## Installation and configuration

Install with your plugin manager just like any other lua plugin, for instance
with `LazyVim`:

```
{ -- Pybricks programming
  'kwsmit/nvim-pybricks.nvim',
  init = function()
    vim.keymap.set('n', '<leader>pr', require('nvim-pybricks').run_program, { desc = 'Run program on hub' })
    vim.keymap.set('n', '<leader>ph', require('nvim-pybricks').set_hub_name, { desc = 'Set the name for the hub to use' })
    vim.keymap.set('n', '<leader>pc', require('nvim-pybricks').set_connection_type, { desc = 'Set the type of connection to hub' })
    -- Define global name for hubname
  end,
  opts = {
    hub_name = 'InventorHub',
    connection_type = 'ble',
  },
},
```

To be able to upload programs to your LEGO hub, the plugin needs following
information:

- hub name. You set this hub name when installing the Pybricks firmware on
your hub (see the Pybricks documentation).
- connection type between your PC and hub. This can be either `usb` or
`ble` (Bluetooth Low Energy).

You can set both in the `opt` section of your plugin configuration,
see the example above. Each time you start Neovim, these values will be used.

During your session you can change both hub name and connection type, so it's
easy to work with several different LEGO hubs. Be aware that these changed
settings are not stored when closing Neovim, so when restarting Neovim the
values are retreived form the plugin configuration.

When no hub name or connection type is specified in your plugin configuration,
the plugin asks you to enter these the first time you want to run a programm
in your current programming session.

If you like to use keyboard shortcuts to operate the plugin, you can define
your keymappings in the `init` section like in the example above. You can
set keymappings for:

- upload and run the program in your current buffer.
- set the name of the hub you want the programme run on.
- set the connection type between your PC and the hub.


## Usage

With this plugin you can write your Pybricks MicroPython code inside Neovim
and upload and run it on your Pybricks hub.

### User commands

**PybricksRunProgram**

- Upload the program in your active buffer to the default hub and run the program.
- If there's no default hub name set, the plugin will ask the user for it.
When entered, this will become the new default hubname.
- if there's no default connection type set, the plugin will ask for it.
When entered, this will become the new default connection type.

**PybricksSetHubName**

- Use this command to set a new value for the default hubname.

**PybricksSetConnectionType**

- Use this command to set the default connection type to use. This can be either
`usb` or `ble`.

## Tips

- Install Pybricks in the virtual environment of your project. If you have
setup a Python language server in Neovim then you get syntax highlighting and
code completion when programming.
- Although Pybricks has no filesystem, you can work with multiple MicroPython
files (`*.py`). For instance you have a module `my_module.py` with several
methods or classes you use in your main programfile `main.py`. Just be sure to
use command `PybricksRunFile` or keybinding `<leader>pr` in the buffer which
contains the entrypoint of your application, in this case `main.py`.
This only works with MicroPython files, not with files with other
file-extensions.
