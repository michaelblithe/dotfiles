vim.pack.add({
    {
        src = 'https://github.com/nvim-mini/mini.nvim',
        version = 'v0.17.0'
    },
    { 
        src = 'https://github.com/neovim/nvim-lspconfig',
        version = 'v2.8.0'
    },
})

require('mini.pick').setup()
require('mini.completion').setup()
require('mini.icons').setup()
require('mini.tabline').setup()
require('mini.bufremove').setup()
