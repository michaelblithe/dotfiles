-- return {
--   {
--     "catppuccin/nvim",
--     name = "catppuccin",
--     priority = 1000,
--     opts = {
--       flavour = "macchiato", -- 🌺 macchiato = dark cozy one
--       background = { light = "latte", dark = "macchiato" },
--       transparent_background = false,
--       term_colors = true,
--       dim_inactive = { enabled = true, percentage = 0.15 },
--       integrations = {
--         cmp = true,
--         gitsigns = true,
--         nvimtree = true,
--         telescope = { style = "nvchad" },
--         treesitter = true,
--         which_key = true,
--         indent_blankline = { enabled = true, scope_color = "lavender" },
--         native_lsp = {
--           enabled = true,
--           virtual_text = { errors = { "pink" }, hints = { "teal" } },
--           underlines = { errors = { "underline" } },
--         },
--       },
--     },
--     config = function(_, opts)
--       require("catppuccin").setup(opts)
--       vim.cmd.colorscheme("catppuccin")
--     end,
--   },
-- }

return {
  -- Disable Mason auto-install since Nix provides our tools
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {},
    },
  },
  -- Configure LSPs provided by Nix
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        nil_ls = {},
      },
    },
  },
  -- Override LazyVim's default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      flavour = "macchiato",
      term_colors = true,
      dim_inactive = { enabled = true, percentage = 0.10 },
      integrations = {
        cmp = true,
        gitsigns = true,
        treesitter = true,
        telescope = { enabled = true },
        lsp_trouble = true,
        which_key = true,
        indent_blankline = { enabled = true },
        native_lsp = { enabled = true },
      },
      highlight_overrides = {
        macchiato = function(c)
          -- plant palette (match kitty above)
          local leaf = "#a6e3a1"
          local leaf2 = "#77d19a"
          local mint = "#6ad3b1"
          local stem = "#2a332e"
          local bloom = "#d1baf7"
          local bud = "#f19dac"
          local sky = "#9dd2ee"
          local soil = "#0f1210"

          return {
            Normal = { fg = "#dfeee5", bg = soil },
            NormalNC = { bg = "#121513" },
            CursorLine = { bg = "#161b18" },
            LineNr = { fg = "#445048" },
            CursorLineNr = { fg = leaf },
            -- syntax
            Identifier = { fg = mint },
            Function = { fg = sky },
            Statement = { fg = leaf2 },
            Keyword = { fg = leaf, italic = true },
            Type = { fg = leaf },
            String = { fg = "#c9e39c" },
            Number = { fg = "#bfe8cf" },
            Constant = { fg = mint },
            Comment = { fg = "#6d7a72", italic = true },
            -- UI bits
            TelescopeTitle = { fg = soil, bg = leaf, bold = true },
            TelescopePromptBorder = { fg = stem },
            TelescopeResultsBorder = { fg = stem },
            TelescopePreviewBorder = { fg = stem },
            Visual = { bg = "#1a221e" },
            Pmenu = { bg = "#141815", fg = "#dfeee5" },
            PmenuSel = { bg = "#1f2823", fg = leaf },
            -- diagnostics (soft pastels)
            DiagnosticError = { fg = bud },
            DiagnosticWarn = { fg = "#e8f3b0" },
            DiagnosticInfo = { fg = sky },
            DiagnosticHint = { fg = bloom },
            -- git signs
            GitSignsAdd = { fg = leaf },
            GitSignsChange = { fg = sky },
            GitSignsDelete = { fg = bud },
          }
        end,
      },
    },
    config = function(_, opts)
      require("catppuccin").setup(opts)
      vim.cmd.colorscheme("catppuccin")
    end,
  },
}
