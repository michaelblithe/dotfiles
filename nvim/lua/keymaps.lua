vim.keymap.set('n', "<leader>ff", ":Pick files <CR>", { silent = true })
vim.keymap.set('n', '<leader>lf', ':lua vim.lsp.buf.format() <CR>', { silent = true })
vim.keymap.set('i', '<Tab>', function()
  -- If the completion menu is visible, select the next item. Otherwise, insert a tab character.
  if vim.fn.pumvisible() == 1 then
    return '<C-n>'
  end
  return '<Tab>'
end, { expr = true })