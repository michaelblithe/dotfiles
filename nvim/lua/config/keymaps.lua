-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Terminal toggle
vim.keymap.set({ "n", "t" }, "<C-`>", function()
  Snacks.terminal()
end, { desc = "Toggle Terminal" })
