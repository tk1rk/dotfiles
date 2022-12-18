local map = function(key)
  -- get the extra options
  local opts = { noremap = true }
  for i, v in pairs(key) do
    if type(i) == 'string' then opts[i] = v end
  end

  -- basic support for buffer-scoped keybindings
  local buffer = opts.buffer
  opts.buffer = nil

  if buffer then
    vim.api.nvim_buf_set_keymap(0, key[1], key[2], key[3], opts)
  else
    vim.api.nvim_set_keymap(key[1], key[2], key[3], opts)
  end
end

map { 'i', 'jk', '<Esc>' }
map { 'i', 'kj', '<Esc>' }
map { 'i', 'kj', '<Esc>' }
vim.cmd [[
    nnoremap <buffer> <expr><c-f> lsp#scroll(+4)
    nnoremap <buffer> <expr><c-d> lsp#scroll(-4)
]]
map { 'n', '<M-j>', ':resize -2<CR>' }
map { 'n', '<M-k>', ':resize +2<CR>' }
map { 'n', '<M-h>', ':vertical resize -2<CR>' }
map { 'n', '<M-l>', ':vertical resize +2<CR>' }

map { 'i', '<c-u>', '<Esc>viwUi' }
map { 'n', '<c-u>', 'viwUi<Esc>' }

map { 'v', '<', '<gv' }
map { 'v', '>', '>gv' }

map { 'n', '<C-s>', ':w<CR>' }

map { 'n', '<C-Q>', ':wq!<CR>' }

map { 'n', '<C-c>', '<Esc>' }

map { 'n', '<C-n>', ':NvimTreeToggle<CR>' }
map { 'n', '<leader>n', ':NvimTreeFindFile<CR>' }
map { 'n', '<F3>', ':noh<CR>' }

map { 'n', '<space>ff', ':Telescope find_files<cr>' }
map { 'n', '<space>fg', ':Telescope live_grep<cr>' }
map { 'n', '<space>fb', ':Telescope buffers<cr>' }
map { 'n', '<space>fh', ':Telescope help_tag<cr>' }
map { 'n', '<space>ll', ':LspRestart<cr>' }
map { 'n', '<space>ls', ':LspStart<cr>' }
map { 'n', '<space>li', ':LspInfo<cr>' }
