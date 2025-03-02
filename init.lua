print("fuck off!")

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Setup lazy.nvim
require("lazy").setup({
	spec = {
		{ "rose-pine/neovim", name = "rose-pine" },

		{'nvim-telescope/telescope.nvim', tag = '0.1.8', dependencies = { 'nvim-lua/plenary.nvim' }},

		{'nvim-treesitter/nvim-treesitter', build = ':TSUpdate'},

		{
			"nvim-neo-tree/neo-tree.nvim",
			branch = "v3.x",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", 
				"MunifTanjim/nui.nvim",
			}
		}

	},
	install = { colorscheme = { "habamax" } },
	checker = { enabled = true },
})

-- Color Scheme:
require("rose-pine").setup()
vim.cmd.colorscheme "rose-pine"

-- Telescope:
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<D-p>', builtin.find_files, { desc = 'Telescope find files' })
vim.keymap.set('n', '<leader>fg', builtin.live_grep, { desc = 'Telescope live grep' })
vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })

-- Treestitter
local treeConfig = require('nvim-treesitter.configs')
treeConfig.setup({
	ensure_installed = {'javascript', 'lua', 'typescript', 'zig', 'php', 'go', 'markdown_inline', 'markdown'},
	auto_install = true,
	highlit = { enabled = true },
	indent = { enabled = true }
})

-- Neo Tree
vim.keymap.set('n', '<D-b>', ':Neotree filesystem reveal left toggle<CR>', {})
