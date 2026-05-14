vim.pack.add({
    {
        src = 'https://github.com/nvim-mini/mini.nvim',
        version = 'v0.17.0'
    }
})

require('mini.pick').setup()
require('mini.completion').setup()