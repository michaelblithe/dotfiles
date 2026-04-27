vim.keymap.set('n', "<leader>ff", ":Pick files <CR>", { silent = true })
--- Format
vim.keymap.set('n', '<leader>lf', ':lua vim.lsp.buf.format() <CR>', { silent = true })

-- Go to
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, { silent = true })
vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, { silent = true })
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, { silent = true })
vim.keymap.set('n', 'gt', vim.lsp.buf.type_definition, { silent = true })
vim.keymap.set('n', 'gr', vim.lsp.buf.references, { silent = true })

-- Info / docs
vim.keymap.set('n', 'K', vim.lsp.buf.hover, { silent = true })
vim.keymap.set('n', '<C-Space>', vim.lsp.buf.signature_help, { silent = true })
vim.keymap.set('i', '<C-Space>', vim.lsp.buf.signature_help, { silent = true })

-- Actions
vim.keymap.set('n', '<leader>la', vim.lsp.buf.code_action, { silent = true })
vim.keymap.set('n', '<leader>lr', vim.lsp.buf.rename, { silent = true })
vim.keymap.set('i', '<Tab>', function()
  -- If the completion menu is visible, select the next item. Otherwise, insert a tab character.
  if vim.fn.pumvisible() == 1 then
    return '<C-n>'
  end
  return '<Tab>'
end, { expr = true })