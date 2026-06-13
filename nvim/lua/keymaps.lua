vim.keymap.set('n', "<leader>ff", ":Pick files <CR>", { silent = true })
vim.keymap.set('n', '<leader>fg', ':Pick grep_live <CR>', {silent = true})
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

-- Splits and tabs
vim.keymap.set('n', '<leader>tn', ':enew <CR>', { silent = true})

vim.keymap.set('n', '<M-j>', '<cmd>BufferLineCyclePrev<CR>') -- Alt+j to move to left
vim.keymap.set('n', '<M-k>', '<cmd>BufferLineCycleNext<CR>') -- Alt+k to move to right
vim.keymap.set('n', '<C-w>', function() MiniBufremove.delete(nil, true) end) -- shift+w to close current tab
vim.keymap.set('n', 'g1', function() vim.cmd("b1") end)
vim.keymap.set('n', 'g2', function() vim.cmd("b2") end)
vim.keymap.set('n', 'g3', function() vim.cmd("b3") end)
vim.keymap.set('n', 'g4', function() vim.cmd("b4") end)
vim.keymap.set('n', 'g5', function() vim.cmd("b5") end)
vim.keymap.set('n', 'g6', function() vim.cmd("b6") end)
vim.keymap.set('n', 'g7', function() vim.cmd("b7") end)
vim.keymap.set('n', 'g8', function() vim.cmd("b8") end)
vim.keymap.set('n', 'g9', function() vim.cmd("b9") end)

--- Terminal
vim.keymap.set('n', '<leader>th', ':15split | terminal<CR>', { silent = true })
vim.keymap.set('t', '<Esc>', "<C-\\><C-n><C-w>h",{silent = true})

-- Movement
vim.keymap.set({'n', 't'}, '<C-h>', '<C-w>h')
vim.keymap.set({'n', 't'}, '<C-j>', '<C-w>j')
vim.keymap.set({'n', 't'}, '<C-k>', '<C-w>k')
vim.keymap.set({'n', 't'}, '<C-l>', '<C-w>l')

