return {
  {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {
      workspaces = {
        {
          name = "grad-school",
          path = "~/Library/Mobile Documents/iCloud~md~obsidian/Documents/grad school", -- or wherever your Obsidian vault is
        },
      },
      notes_subdir = "inbox",
      daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
      },
      completion = {
        nvim_cmp = false,
      },
      ui = {
        enable = true,
        checkboxes = {
          -- cute pastel checkboxes
          [" "] = { char = "󰄱 ", hl_group = "ObsidianTodo" },
          ["x"] = { char = "󰄲 ", hl_group = "ObsidianDone" },
        },
      },
      attachments = {
        -- this handles pasted or dropped images 🖼️
        img_folder = "assets", -- relative to note
        img_name_func = function()
          return string.format("%s", os.date("%Y%m%d%H%M%S"))
        end,
      },
    },
    keys = {
      { "<leader>on", "<cmd>ObsidianNew<cr>", desc = "New note" },
      { "<leader>od", "<cmd>ObsidianToday<cr>", desc = "Daily note" },
      { "<leader>os", "<cmd>ObsidianSearch<cr>", desc = "Search notes" },
      { "<leader>ob", "<cmd>ObsidianBacklinks<cr>", desc = "Backlinks" },
    },
  },
}
