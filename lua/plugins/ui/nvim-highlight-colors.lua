return {
	'brenoprata10/nvim-highlight-colors',
	-- Ensure termguicolors is enabled if not already
	config = function()
		require('nvim-highlight-colors').setup({
			render = 'foreground',
		})
	end
}
