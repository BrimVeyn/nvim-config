return {
	"saghen/blink.cmp",
	version = "1.*",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		"onsails/lspkind.nvim",
		'echasnovski/mini.icons',
		"rafamadriz/friendly-snippets",
		'windwp/nvim-autopairs',
	},
	opts = {
		keymap = {
			['<Tab>'] = { 'select_next', 'fallback' },
			['<S-Tab>'] = { 'select_prev', 'fallback' },
			['<C-n>'] = { 'select_next', 'show' },
			['<C-p>'] = { 'select_prev', 'show' },
			['<C-e>'] = { 'hide', 'fallback' },
			['<C-b>'] = { 'scroll_documentation_up', 'fallback' },
			['<C-f>'] = { 'scroll_documentation_down', 'fallback' },
			['<CR>'] = { 'accept', 'fallback' },
		},

		completion = {
			menu = {
				border = 'rounded',
				draw = {
					columns = {
						{ "label",      "label_description", gap = 1 },
						{ "kind_icon",  gap = 1 },
						{ "kind",       gap = 1 },
						{ "source_name" },
					},
					components = {
						kind_icon = {
							text = function(ctx)
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local ok, mini_icon = pcall(require("mini.icons").get_icon, ctx.item.data.type, ctx.label)
									if ok and mini_icon then return mini_icon .. ctx.icon_gap end
								end

								local icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
								return (icon or '') .. ctx.icon_gap
							end,

							-- Optionally, use the highlight groups from mini.icons
							-- You can also add the same function for `kind.highlight` if you want to
							-- keep the highlight groups in sync with the icons.
							highlight = function(ctx)
								if vim.tbl_contains({ "Path" }, ctx.source_name) then
									local ok, mini_icon, mini_hl = pcall(require("mini.icons").get_icon, ctx.item.data.type, ctx.label)
									if ok and mini_icon then return mini_hl end
								end
								return ctx.kind_hl
							end,
						},
						source_name = {
							text = function(ctx)
								if ctx.source_name == 'LSP' or ctx.source_name == 'lsp' then
									local shortnames = {
										["emmet_language_server"] = "Emmet",
										["typescript-tools"] = "TS",
										["lua_ls"] = "Lua",
										["pyright"] = "Py",
										["rust_analyzer"] = "Rust",
										["gopls"] = "Go",
									}
									local client_name = ctx.item.client_name
									local short = shortnames[client_name] or client_name
									return '[' .. short .. ']'
								else
									return '[' .. ctx.source_name .. ']'
								end
							end,
						},
					}
				}
			},
			documentation = {
				window = { border = 'rounded' },
				auto_show = true,
				auto_show_delay_ms = 100,
			},
			list = {
				selection = {
					preselect = false,
				}
			},
			ghost_text = { enabled = true },
			auto_brackets = { enabled = true },
		},

		-- signature = {
		-- 	enabled = true,
		-- 	window = {
		-- 		show_documentation = false,
		-- 	},
		-- },


		snippets = { preset = 'luasnip' },

		sources = {
			default = { 'lsp', 'path', 'snippets', 'buffer' },
		},

		cmdline = {
			keymap = { preset = 'cmdline' },
			completion = { menu = { auto_show = true } },
		},
	},
	config = function(_, opts)
		require("luasnip.loaders.from_vscode").lazy_load()
		require('blink.cmp').setup(opts)
	end,
}
