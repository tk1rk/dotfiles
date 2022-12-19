local db = require('dashboard')
db.custom_header  -- type can be nil,table or function(must be return table in function)
                  -- if not config will use default banner
db.custom_center  -- table type and in this table you can set icon,desc,shortcut,action keywords. desc must be exist and type is string
                  -- icon type is nil or string
                  -- icon_hl table type { fg ,bg} see `:h vim.api.nvim_set_hl` opts
                  -- shortcut type is nil or string also like icon
                  -- action type can be string or function or nil.
                  -- if you don't need any one of icon shortcut action ,you can ignore it.
db.custom_footer  -- type can be nil,table or function(must be return table in function)
db.preview_file_Path          -- string or function type that mean in function you can dynamic generate height width
db.preview_file_height        -- number type
db.preview_file_width         -- number type
db.preview_command            -- string type (can be ueberzug which only work in linux)
db.confirm_key                -- string type key that do confirm in center select
db.hide_statusline            -- boolean default is true.it will hide statusline in dashboard buffer and auto open in other buffer
db.hide_tabline               -- boolean default is true.it will hide tabline in dashboard buffer and auto open in other buffer
db.hide_winbar                -- boolean default is true.it will hide the winbar in dashboard buffer and auto open in other buffer
db.session_directory          -- string type the directory to store the session file
db.session_auto_save_on_exit  -- boolean default is false.it will auto-save the current session on neovim exit if a session exists and more than one buffer is loaded
db.session_verbose            -- boolean default true.it will display the session file path on SessionSave and SessionLoad
db.header_pad                 -- number type default is 1
db.center_pad                 -- number type default is 1
db.footer_pad                 -- number type default is 1


-- Custom events
DBSessionSavePre   -- a custom user autocommand to add functionality before auto-saving the current session on exit
DBSessionSaveAfter -- a custom user autocommand to add functionality after auto-saving the current session on exit

-- Example: Close NvimTree buffer before auto-saving the current session
autocmd('tk', {
    pattern = 'DBSessionSavePre',
    callback = function()
      pcall(vim.cmd, 'NvimTreeClose')
    end,
})


-- Highlight Group
DashboardHeader DashboardCenter DashboardShortCut DashboardFooter

-- Command

DashboardNewFile  -- if you like use `enew` to create file,Please use this command,it's wrap enew and restore the statsuline and tabline
SessionSave,SessionLoad,SessionDelete
