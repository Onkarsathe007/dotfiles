require("config.lazy")

-- EJS filetype configuration
vim.filetype.add({
  extension = {
    ejs = "ejs",
  },
})

-- EJS-specific settings to prevent automatic space insertion
vim.api.nvim_create_autocmd("FileType", {
  pattern = "ejs",
  callback = function()
    vim.opt_local.formatoptions:remove("a")
    vim.opt_local.formatoptions:remove("t")
    vim.opt_local.textwidth = 0
  end,
})
