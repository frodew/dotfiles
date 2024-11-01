return {

  { "akinsho/bufferline.nvim", enabled = false },

  { "nvim-neo-tree/neo-tree.nvim", enabled = false },

  { "folke/todo-comments.nvim", enabled = false },

  {
    "folke/tokyonight.nvim",
    lazy = true,
    transparent = true,
    opts = { style = "night" },
    styles = {
      sidebars = "transparent",
      floats = "transparent",
    },
  },

  {
    "stevearc/oil.nvim",
    lazy = false,
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
      { "<leader>fo", "<cmd>Oil<CR>", desc = "Oil Explorer" },
    },
    opts = {
      default_file_explorer = true,
      view_options = {
        show_hidden = true,
      },
      keymaps = {
        ["<esc>"] = "actions.close",
        ["q"] = "actions.close",
        ["yp"] = "actions.yank_entry",
      },
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      sections = {
        lualine_z = {},
      },
    },
  },

  {
    "nvimdev/dashboard-nvim",
    opts = function(_, opts)
      -- Add oil.nvim to the dashboard without displaying it
      table.insert(opts.config.center, {
        action = "Oil",
        desc = "",
        icon = "",
        key = "o",
      })
    end,
  },

  {
    "olimorris/codecompanion.nvim",
    cmd = { "CodeCompanion", "CodeCompanionActions", "CodeCompanionToggle", "CodeCompanionAdd", "CodeCompanionChat" },

    config = function()
      local user = vim.env.USER or "User"

      require("codecompanion").setup({
        adapters = {
          anthropic = function()
            return require("codecompanion.adapters").extend("anthropic", {
              env = {
                api_key = "cmd:gpg --decrypt ~/.anthropic_key.gpg 2>/dev/null",
              },
            })
          end,
        },
        strategies = {
          chat = {
            adapter = "anthropic",
            roles = {
              llm = "  CodeCompanion",
              user = "  " .. user,
            },
            keymaps = {
              close = {
                modes = {
                  n = "<C-c>",
                  i = "<C-c>",
                },
              },
              stop = {
                modes = {
                  n = "<Esc>",
                },
              },
            },
          },
          inline = {
            adapter = "anthropic",
          },
          agent = {
            adapter = "anthropic",
          },
        },
      })
    end,

    keys = {
      { "<leader>a", "", desc = "+ai", mode = { "n", "v" } },
      { "<leader>ap", "<cmd>CodeCompanionActions<cr>", mode = { "n", "v" }, desc = "Prompt Actions (CodeCompanion)" },
      { "<leader>aa", "<cmd>CodeCompanionToggle<cr>", mode = { "n", "v" }, desc = "Toggle (CodeCompanion)" },
      { "<leader>ac", "<cmd>CodeCompanionAdd<cr>", mode = "v", desc = "Add code to CodeCompanion" },
      { "<leader>ai", "<cmd>CodeCompanion<cr>", mode = "n", desc = "Inline prompt (CodeCompanion)" },
    },
  },

  -- Edgy integration (with CodeCompanion)
  {
    "folke/edgy.nvim",
    optional = true,
    opts = function(_, opts)
      opts.right = opts.right or {}
      table.insert(opts.right, {
        ft = "codecompanion",
        title = "CodeCompanion Chat",
        size = { width = 50 },
      })
    end,
  },
}
