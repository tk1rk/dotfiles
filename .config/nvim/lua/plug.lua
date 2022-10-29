-- [[ plug.lua ]]

return require('packer').startup(function(use)
  -- [[ Plugins Go Here ]]
end,
config = {
  package_root = vim.fn.stdpath('config') .. '/site/pack'
})
