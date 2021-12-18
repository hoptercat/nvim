function Prettier()
  return {
    exe = "prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
    stdin = true
  }
end
require("formatter").setup(
  {
    logging = false,
    filetype = {
      javascript = {
        -- prettier
        Prettier
      },
      typescript = {
        -- prettier
        Prettier
      },
      typescriptreact = {
        -- prettier
        Prettier
      },
      javascriptreact = {
        -- prettier
        Prettier
      },
      vue = {
        -- prettier
        Prettier
      },
      go = {
        function()
          return {
            exe = "gofmt",
            stdin = true
          }
        end
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)
