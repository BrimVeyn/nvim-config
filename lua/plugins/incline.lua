return {
  {
    "b0o/incline.nvim",
    main = "incline",
    event = "VeryLazy",
    keys = {
      {
        "<leader>uN",
        function()
          require("incline").toggle()
        end,
        desc = "Incline Toggle",
      },
    },
    opts = function()
      local separator = { left = '', right = '' } -- vim.g.separators.component
      return {
        ---@param props { buf: number, win: number, focused: boolean }
        render = function(props)
          local theme = require("lualine.themes." .. vim.g.colors_name)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")
          local ft_icon, ft_color = require("nvim-web-devicons").get_icon_color(filename)
          local group = props.focused and "Normal" or "Inactive"
          local modified = vim.api.nvim_get_option_value("modified", { buf = props.buf })
          for hl_group, value in pairs({
            InclineBorderNormal = { fg = theme.normal.b.bg, bg = "NONE" },
            InclineBorderInactive = { fg = theme.inactive.b.bg, bg = "NONE" },
            InclineTextNormal = { fg = theme.normal.b.fg, bg = theme.normal.b.bg },
            InclineTextInactive = { bg = theme.inactive.b.bg, fg = theme.normal.b.fg },
          }) do
            vim.api.nvim_set_hl(0, hl_group, value)
          end
          local function expand(render_result)
            local index = 1
            while index < #render_result do
              local value = render_result[index]
              if #value > 0 then
                table.insert(render_result, index + 1, separator.right)
                index = index + 1
              end
              index = index + 1
            end
            return render_result
          end
          return #filename > 0
              and {
                {
                  "", -- vim.g.separators.section.right
                  group = "InclineBorder" .. group,
                },
                expand({
                  {
                    ft_icon and { " ", ft_icon, guifg = ft_color } or "",
                    " ",
                    {
                      filename,
                      gui = modified and "bold" or nil,
                    },
                    " ",
                    modified and "● " or "",
                  },
                  group = "InclineText" .. group,
                }),
              }
            or {}
        end,
        highlight = {
          groups = {
            InclineNormal = { default = false, guifg = "NONE", guibg = "NONE" },
            InclineNormalNC = { default = false, guifg = "NONE", guibg = "NONE" },
          },
        },
        window = {
          padding = 0,
          margin = { vertical = 0, horizontal = 0 },
          placement = { vertical = "top", horizontal = "right" },
        },
      }
    end,
  },
}
