-- You dont need to set any of these options. These are the default ones. Only
-- the loading is important
require('telescope').setup {
  extensions = {
    fzf = {
      -- false will only do exact matching
      fuzzy = true,                    
      
      -- override the generic sorter
      override_generic_sorter = true,  
      
      -- override the file sorter
      override_file_sorter = true, 
      
      -- or "ignore_case" or "respect_case"
      case_mode = "smart_case",  
    },
    media_files = { 
      -- filetypes whitelist, 
      -- defaults to {"png", "jpg", "mp4", "webm", "pdf"}         
      filetypes = {"png", "webp", "jpg", "jpeg"}, 
      find_cmd = "rg" -- find command (defaults to `fd`) 
      } 
    },
  }
}
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('file_browser')
require('telescope').load_extension('frecency')
require('telescope').load_extension('fzf')
require('telescope').load_extension('media_files')
require('telescope').load_extension('file_browser')


require('telescope').extensions.media_files.media_files()
