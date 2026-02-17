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
  -- Direnv integration - auto-load .envrc environments
  {
    "direnv/direnv.vim",
    lazy = false,
  },

  -- Override LazyVim's default colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "ThePrimeagen/99",
    config = function()
      local _99 = require("99")

      -- For logging that is to a file if you wish to trace through requests
      -- for reporting bugs, i would not rely on this, but instead the provided
      -- logging mechanisms within 99.  This is for more debugging purposes
      local cwd = vim.uv.cwd()
      local basename = vim.fs.basename(cwd)
      _99.setup({
        -- provider = _99.ClaudeCodeProvider, -- default: OpenCodeProvider
        logger = {
          level = _99.DEBUG,
          path = "/tmp/" .. basename .. ".99.debug",
          print_on_error = true,
        },

        --- Completions: #rules and @files in the prompt buffer
        completion = {
          -- I am going to disable these until i understand the
          -- problem better.  Inside of cursor rules there is also
          -- application rules, which means i need to apply these
          -- differently
          -- cursor_rules = "<custom path to cursor rules>"

          --- A list of folders where you have your own SKILL.md
          --- Expected format:
          --- /path/to/dir/<skill_name>/SKILL.md
          ---
          --- Example:
          --- Input Path:
          --- "scratch/custom_rules/"
          ---
          --- Output Rules:
          --- {path = "scratch/custom_rules/vim/SKILL.md", name = "vim"},
          --- ... the other rules in that dir ...
          ---
          custom_rules = {
            "scratch/custom_rules/",
          },

          --- Configure @file completion (all fields optional, sensible defaults)
          files = {
            enabled = true,
            max_file_size = 102400, -- bytes, skip files larger than this
            max_files = 5000, -- cap on total discovered files
            exclude = { ".env", ".env.*", "node_modules", ".git", "venv" },
          },

          --- What autocomplete do you use.  We currently only
          --- support cmp right now
          source = "cmp",
        },

        --- WARNING: if you change cwd then this is likely broken
        --- ill likely fix this in a later change
        ---
        --- md_files is a list of files to look for and auto add based on the location
        --- of the originating request.  That means if you are at /foo/bar/baz.lua
        --- the system will automagically look for:
        --- /foo/bar/AGENT.md
        --- /foo/AGENT.md
        --- assuming that /foo is project root (based on cwd)
        md_files = {
          "AGENT.md",
        },
      })

      -- take extra note that i have visual selection only in v mode
      -- technically whatever your last visual selection is, will be used
      -- so i have this set to visual mode so i dont screw up and use an
      -- old visual selection
      --
      -- likely ill add a mode check and assert on required visual mode
      -- so just prepare for it now
      vim.keymap.set("v", "<leader>9v", function()
        _99.visual()
      end)

      --- if you have a request you dont want to make any changes, just cancel it
      vim.keymap.set("v", "<leader>9s", function()
        _99.stop_all_requests()
      end)
    end,
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
