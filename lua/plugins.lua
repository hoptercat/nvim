local packer = nil
local function init()
  if packer == nil then
    packer = require "packer"
    packer.init {disable_commands = true}
  end

  local use = packer.use
  packer.reset()

  -- Packer
  use "wbthomason/packer.nvim"
  use {
    "neovim/nvim-lspconfig",
    event = "BufReadPre",
    config = [[require("plugin-config.lsp")]]
  }
  use {
    "srcery-colors/srcery-vim",
    config = [[vim.cmd('colorscheme srcery')]]
  }
  use {"psliwka/vim-smoothie", event = {"BufRead", "BufNewFile"}}
  use {
    "kyazdani42/nvim-tree.lua",
    config = [[require("plugin-config.nvim-tree")]]
  }
  use {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    requires = {
      {"nvim-lua/popup.nvim", opt = true},
      {"nvim-lua/plenary.nvim", opt = true}
    },
    config = [[require("plugin-config.telescope")]]
  }
  use {"rhysd/accelerated-jk"}
  use {
    "rhysd/vim-operator-surround",
    requires = {"kana/vim-operator-user"},
    config = [[require("plugin-config.surround")]],
    keys = {{"v", "sa"}, {"v", "sr"}, {"v", "sd"}}
  }
  use {"mhinz/vim-sayonara", cmd = "Sayonara"}
  use {
    "lukas-reineke/indent-blankline.nvim",
    config = [[require("indent_blankline")]],
    event = {"BufReadPre", "BufNewFile"}
  }
  use {
    "akinsho/nvim-bufferline.lua",
    requires = {"kyazdani42/nvim-web-devicons"},
    config = [[require("plugin-config.bufferline")]]
  }
  use {
    "nvim-treesitter/nvim-treesitter",
    event = "BufRead",
    requires = {
      {"nvim-treesitter/nvim-treesitter-textobjects", after = "nvim-treesitter"},
      {"p00f/nvim-ts-rainbow", after = "nvim-treesitter"},
      {"JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter"}
    },
    config = [[require("plugin-config.treesitter")]]
  }
  use {
    "windwp/nvim-autopairs",
    after = "nvim-cmp",
    config = function()
      require("nvim-autopairs").setup {}
      require("nvim-autopairs.completion.cmp").setup(
        {
          map_cr = true, --  map <CR> on insert mode
          map_complete = true, -- it will auto insert `(` after select function or method item
          auto_select = true -- automatically select the first item
        }
      )
    end
  }
  use {
    "glepnir/galaxyline.nvim",
    requires = {"kyazdani42/nvim-web-devicons"},
    config = [[require("eviline")]]
  }
  use {
    "mhartington/formatter.nvim",
    cmd = "Format",
    config = [[require("plugin-config.formatter")]]
  }
  use {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    config = [[require("plugin-config.nvim-compe")]],
    requires = {
      {"hrsh7th/cmp-nvim-lsp", after = "nvim-cmp"},
      {"hrsh7th/cmp-buffer", after = "nvim-cmp"},
      {"hrsh7th/cmp-path", after = "nvim-cmp"},
      {"f3fora/cmp-spell", after = "nvim-cmp"},
      {"quangnguyen30192/cmp-nvim-tags", after = "nvim-cmp"},
      {"hrsh7th/cmp-vsnip", after = "nvim-cmp"},
      {
        "hrsh7th/vim-vsnip",
        after = "nvim-cmp",
        requires = {
          {"dsznajder/vscode-es7-javascript-react-snippets"},
          {"xabikos/vscode-javascript"},
          {"hollowtree/vscode-vue-snippets"}
        },
        config = [[require("plugin-config.vsnip")]]
      },
      {"hrsh7th/vim-vsnip-integ", after = "nvim-cmp"},
      {"kristijanhusak/vim-dadbod-completion", event = "InsertCharPre"}
    }
  }
end

local plugins =
  setmetatable(
  {},
  {
    __index = function(_, key)
      init()
      return packer[key]
    end
  }
)

return plugins
