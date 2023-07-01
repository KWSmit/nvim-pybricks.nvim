# nvim-pybricks.nvim

Neovim lua-plugin for programming LEGO® Powered Up hubs with the Pybricks
firmware running on it. With this plugin you can write your code locally on
your PC and upload to and run it on your Pybricks hub.

## Requirements

On your PC:

- Neovim 7.0 or newer.
- *This plugin is tested on Linux (Pop!_OS 22.04 LTS) and Windows 10.*

On your LEGO® Powered Up hub:

- Pybricks version 3.2 or newer.

## Pybricks

Pybricks is Python coding for LEGO® Powered Up hubs. Run MicroPython scripts
directly on the hub, and get full control of your motors and sensors. Pybricks
is free and open source.

To use the nvim-pybricks plugin, you have to install the Pybricks firmware
on your LEGO® hub. Go to the [Pybricks website](https://pybricks.com/) for
more information.

## Installation

Install with your plugin manager just like any other lua plugin, for instance
with `Packer`:

```
use 'kwsmit/nvim-pybricks.nvim'
```

## Setup

There is one setting you need to add to the setup of the plugin, namely the
name of the hub you use most often. For instance:

```
nvim_pybricks.setup({
    -- Define global name for hubname
    vim.api.nvim_set_var('global_pybricks_hub_name', '<name of your hub>')
})
```

If you don't want to specify a global hubname, replace the second argument
`'<name of your hub>'` by `nil` (without the quotes).

## Usage

With this plugin you can write your Pybricks MicroPython code inside Neovim
and upload and run it on your Pybricks hub. To upload and run your program
Neovim must know the name of your hub. You set this name when installing the
Pybricks firmware on your hub. If you use more hubs be sure to give every hub
its own unique name.

The plugin lets you define one global name for a hub. This hubname is saved
during your programming session, it is lost when you close Neovim. But in the
setup of the plugin you can declare a hubname which will be the global hubname
when you start Neovim.

It is possible to change the global hubname during your programming session
and you can always overrule the global hubname, which makes it easy to work
with several different hubs while programming and testing.

### User commands

**PybricksRunFile <hubname\>**

- Upload the program to the given hub <hubname\> and run the program.
- When <hubname\> is omitted, the program will be uploaded to and run on the
hub with the current global hubname.
- If the global hubname is not set, the plugin will ask the user for a hubname.
When entered, this hubname becomes the new global hubname.
- When <hubname\> is given the hub with this name will be used, no matter 
what the global hubname is. The given hubname is only used this time, 
the global hubname will not change.

**PybricksSetHubName**

- Use this command to set the global hubname.

### Keybindings

**<leader\>pr**

- Upload the program to the hub with the global hubname and run the program.
- You cannot specify a hubname, the plugin will use the global hubname. If the
global hubname is not specified, the plugin will ask the user to enter a
hubname. This hubname will become the new global hubname and thus will be
used the next time this keybinding is used. If you want to use a different
hubname, use command `PybricksSetHubName` to change the global hubname.

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
