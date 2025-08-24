return {
	"pmizio/typescript-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"neovim/nvim-lspconfig"
	},
	opts = {
		settings = {
			-- spawn additional tsserver instance to calculate diagnostics on it
			separate_diagnostic_server = true,
			-- "change"|"insert_leave" determine when the client asks the server about diagnostic refresh
			publish_diagnostic_on = "insert_leave",
			-- array of strings("fix_all"|"add_missing_imports"|"remove_unused"|
			-- "remove_unused_imports"|"organize_imports") -- or string "all"
			-- to include all code actions
			-- specify commands exposed as code_actions
			expose_as_code_action = {},
			-- string|nil - specify a custom path to `tsserver.js` file, if this is nil or file doesn't exist under the
			-- specified path, the plugin will look for typescript in the project's local and global node_modules
			tsserver_path = nil,
			-- specify a list of plugins to load by tsserver, e.g., a plugin which provides inlay hints
			-- if nil, the plugin will look for plugins in the project's local and global node_modules
			tsserver_plugins = {},
			-- this value is passed to: https://nodejs.org/api/cli.html#--max-old-space-size
			-- it can't be changed dynamically, so set it to a reasonable value
			tsserver_max_memory = "auto",
			-- described below
			tsserver_inlay_hints = {
				includeInlayParameterNameHints = "none",
				includeInlayParameterNameHintsWhenArgumentMatchesName = false,
				includeInlayFunctionParameterTypeHints = true,
				includeInlayVariableTypeHints = true,
				includeInlayPropertyDeclarationTypeHints = true,
				includeInlayFunctionLikeReturnTypeHints = true,
				includeInlayEnumMemberValueHints = true,
			},
		},
	},
}
