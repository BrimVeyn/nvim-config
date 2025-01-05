local function lsp_server_indicator()
	local bufnr = vim.api.nvim_get_current_buf()
    local buf_clients = vim.lsp.get_clients({ bufnr = bufnr })

    if next(buf_clients) == nil then
        return " No LSP"
    end

    local client_names = {}
    for _, client in pairs(buf_clients) do
        table.insert(client_names, client.name)
    end

    return " LSP: " .. table.concat(client_names, ", ")
end

return {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
	lazy = false,
	config = function()
		require('lualine').setup({
			options = {
				theme  = 'auto',
			},
			sections = {
				lualine_c = {
					{ lsp_server_indicator, icon = '' }, -- Add LSP indicator with an icon
				}
			},
		})
	end,
}
