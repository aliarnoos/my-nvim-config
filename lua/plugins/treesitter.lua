return {
	'nvim-treesitter/nvim-treesitter', 
	build = ':TSUpdate',
	config = function()
		local treeConfig = require('nvim-treesitter.configs')
		treeConfig.setup({
			ensure_installed = {'javascript', 'lua', 'typescript', 'zig', 'php', 'go', 'markdown'},
			auto_install = true,
			highlit = { enabled = true },
			indent = { enabled = true }
		})
	end
}
