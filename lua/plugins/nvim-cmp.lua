return {
	"hrsh7th/nvim-cmp",
	event = { "InsertEnter", "CmdlineEnter" },
	dependencies = {
		"hrsh7th/cmp-buffer",
		"hrsh7th/cmp-path",
		"hrsh7th/cmp-cmdline",
		{
			"L3MON4D3/LuaSnip",
			version = "v2.*",
			build = "make install_jsregexp",
		},
		-- "github/copilot.vim",
		"saadparwaiz1/cmp_luasnip",
		"rafamadriz/friendly-snippets",
		"onsails/lspkind.nvim",
		'windwp/nvim-autopairs',
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require("luasnip")
		local lspkind = require("lspkind")
		local mappings = require("core.mappings")
		local cmp_autopairs = require('nvim-autopairs.completion.cmp')
		require("luasnip.loaders.from_vscode").lazy_load()

		cmp.event:on(
			'confirm_done',
			cmp_autopairs.on_confirm_done()
		)

		cmp.setup({
			completion = {
				completeopt = "menu,menuone,preview,noselect",
			},

			window = {
				completion = cmp.config.window.bordered(),
				documentation = cmp.config.window.bordered(),
			},

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			mapping = cmp.mapping.preset.insert(mappings.cmp_native(cmp, luasnip)),

			sources = cmp.config.sources({
				{ name = "nvim_lsp", keyword_length = 1 },
				{ name = "luasnip",  keyword_length = 2 },
				{ name = "buffer",   keyword_length = 2 },
				{ name = "path",     keyword_length = 2 },
			}),

			formatting = {
				fields = { "kind", "abbr", "menu" },

				format = function(entry, vim_item)
					local kind = lspkind.cmp_format({
						mode = "symbol_text",
					})(entry, vim.deepcopy(vim_item))
					local highlights_info = require("colorful-menu").cmp_highlights(entry)

					-- highlight_info is nil means we are missing the ts parser, it's
					-- better to fallback to use default `vim_item.abbr`. What this plugin
					-- offers is two fields: `vim_item.abbr_hl_group` and `vim_item.abbr`.
					if highlights_info ~= nil then
						vim_item.abbr_hl_group = highlights_info.highlights
						vim_item.abbr = highlights_info.text
					end
					local strings = vim.split(kind.kind, "%s", { trimempty = true })
					vim_item.kind = " " .. (strings[1] or "") .. " "
					vim_item.menu = ""

					return vim_item
				end,
			},
		})

		cmp.setup.cmdline('/', {
			view = {
				entries = { name = 'wildmenu', separator = '|' }
			},
			mapping = cmp.mapping.preset.cmdline(),
			sources = ({
				{ name = "buffer" },
			}),
		})

		cmp.setup.cmdline(':', {
			mapping = cmp.mapping.preset.cmdline(),
			sources = cmp.config.sources({
				{ name = 'path' },
				{ name = 'cmdline' }
			}),
			matching = {
				disallow_symbol_nonprefix_matching = false,
				disallow_fuzzy_matching = true,
				disallow_fullfuzzy_matching = true,
				disallow_partial_fuzzy_matching = true,
				disallow_partial_matching = false,
				disallow_prefix_unmatching = true,
			},
		})
	end,
}
