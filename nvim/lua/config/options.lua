-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- -- Subtle dim for inactive splits
vim.api.nvim_set_hl(0, "NormalNC", { bg = "#1e2030" })

-- A touch of bloom for comments and keywords
vim.api.nvim_set_hl(0, "Comment", { fg = "#7f849c", italic = true })
vim.api.nvim_set_hl(0, "Keyword", { fg = "#c6a0f6", italic = true })
vim.api.nvim_set_hl(0, "String", { fg = "#a6da95" })
vim.api.nvim_set_hl(0, "Function", { fg = "#8aadf4" })
