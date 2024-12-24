local opt = vim.opt
opt.number = true
opt.relativenumber = true
opt.colorcolumn = "80"
opt.tabstop = 2
opt.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"
opt.shiftwidth = 2
opt.expandtab = true
opt.autoindent = true
opt.wrap = false
opt.ignorecase = true
opt.smartcase = true
opt.termguicolors = true
opt.background = "dark"
opt.signcolumn = "yes"
opt.mouse = "a"
opt.cursorline = true
opt.conceallevel = 2
--opt.backspace = "indent,eol,start"
opt.clipboard:append("unnamedplus")
opt.splitright = true
opt.splitbelow = true
opt.swapfile = false
vim.g.mapleader = " "
vim.g.localmapleader = " "
opt.foldlevel = 99
opt.formatoptions = "jcroqlnt" -- tcqj
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
-- opt.statuscolumn = [[%!v:lua.require'snacks.statuscolumn'.get()]]
opt.smoothscroll = true

-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0
