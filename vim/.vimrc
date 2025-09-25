"" checks for vim-tiny (vi)
if has("eval")
   let skip_defaults_vim = 1
endif

"""""""""""""""""""""
" some basic tweaks "
"""""""""""""""""""""
set nocompatible
set autoindent
set autowrite
set number
set relativenumber
set ruler
set showmode
set tabstop=2
set vb t_vb=""
set softtabstop=2
set shiftwidth=2
set smartindent
set smarttab
set noignorecase
set noerrorbells
set visualbell


"""""""""""""""""""""""""""""""""""""""
" misc stuff, makes vim less annoying "
"""""""""""""""""""""""""""""""""""""""
if v:version >=  800
  set nofixendofline
  set listchars=space:*,trail:*,nbsp:*,extends:>,precedes:<,tab:\|>
  set listchars+=eol:↩
  set foldmethod=manual
  set nofoldenable
endif

match Visual '\s\+$'
""""""""""
" colors "
""""""""""
"" solarized doesn't work with this on
if has("termguicolors")
  set termguicolors
endif

set t_Co=256

" more misc stuff "
"""""""""""""""""""
set textwidth=72
set colorcolumn=73
set spc=
set expandtab
set nobackup
set noswapfile
set nowritebackup
set noundofile
set icon
set hlsearch
set incsearch
set linebreak
set wrapscan
set nowrap
set shortmess=aoOtTI
set viminfo='20,<1000,s1000 " prevent truncated yanks, deletes, etc
set ttyfast
set ttimeoutlen=0
set showmatch
filetype plugin indent on
set wildmenu
set omnifunc=syntaxcomplete#Complete
set noshowmatch
set hidden
set cinoptions+=:0
set history=100

if has("eval")
  let g:loaded_matchparen=1
endif

" force loclist to always close when buffer does (affects vim-go, etc.)
augroup CloseLoclistWindowGroup
  autocmd!
  autocmd QuitPre * if empty(&buftype) | lclose | endif
augroup END

" format perl on save
if has("eval") " vim-tiny detection
fun! s:Perltidy()
  let l:pos = getcurpos()
  silent execute '%!perltidy -i=2'
  call setpos('.', l:pos)
endfun
"autocmd FileType perl autocmd BufWritePre <buffer> call s:Perltidy()
endif

"autocmd BufWritePost config.def.h,config.h !sudo make install 

" format shell on save
if has("eval") " vim-tiny detection
" TODO check for shfmt and shellcheck before defining
" FIXME stop from blowing away file when there is shell error
fun! s:FormatShell()
  let l:pos = getcurpos()
  "silent execute '%!shfmt' " FIXME: bug report to shfmt
  call setpos('.', l:pos)
endfun
autocmd FileType sh autocmd BufWritePre <buffer> call s:FormatShell()
endif

fun! JumpToDef()
  if exists("*GotoDefinition_" . &filetype)
    call GotoDefinition_{&filetype}()
  else
    exe "norm! \<C-]>"
  endif
endf

set laststatus=0

nnoremap confe :e $HOME/.vimrc<CR>
nnoremap confr :source $HOME/.vimrc<CR>
nnoremap coming i_In development..._<Esc>

set ruf=%30(%=#LineNr#%.50F\ [%{strlen(&ft)?&ft:'none'}]\ %l:%c\ %p%%%)

""""""""""""""""""""
"     Vim-Plug      "
"""""""""""""""""""""
" only run if vim-plug is installed
if filereadable(expand("~/.vim/autoload/plug.vim"))

  call plug#begin('~/.local/share/vim/plugins')
  Plug 'fatih/vim-go'
  Plug 'airblade/vim-gitgutter'
  Plug 'dense-analysis/ale'
  Plug 'conradirwin/vim-bracketed-paste'
  Plug 'jiangmiao/auto-pairs'
  Plug 'Raku/vim-raku'
  Plug 'kaarmu/typst.vim'
  if has('nvim-0.8')
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  endif
  if has ('nvim')
    Plug 'xolox/vim-misc'
    Plug 'xolox/vim-lua-ftplugin'
  endif
  call plug#end()

  let g:ale_sign_error = 'X'
  let g:ale_sign_warning = '!'
  let g:ale_linters = {'go': ['gometalinter', 'gofmt','gobuild']}

  " golang
  let g:go_fmt_fail_silently = 0
  let g:go_fmt_command = 'goimports'
  let g:go_fmt_autosave = 1
  let g:go_gopls_enabled = 1
  let g:go_highlight_types = 1
  let g:go_highlight_fields = 1
  let g:go_highlight_functions = 1
  let g:go_highlight_function_calls = 1
  let g:go_highlight_operators = 1
  let g:go_highlight_extra_types = 1
  let g:go_highlight_variable_declarations = 1
  let g:go_highlight_variable_assignments = 1
  let g:go_highlight_build_constraints = 1
  let g:go_highlight_diagnostic_errors = 1
  let g:go_highlight_diagnostic_warnings = 1
  let g:go_auto_sameids = 0
  "    let g:go_metalinter_command='golangci-lint'
  "    let g:go_metalinter_command='golint'
  "    let g:go_metalinter_autosave=1
  set updatetime=100
  "let g:go_gopls_analyses = { 'composites' : v:false }
  au FileType go nmap <leader>m ilog.Print("made")<CR><ESC>
  au FileType go nmap <leader>n iif err != nil {return err}<CR><ESC>
  if has("syntax")
    syntax enable
    set background=dark
    colorscheme elflord
  endif

  hi Normal ctermbg=NONE guibg=NONE
  hi LineNr ctermbg=NONE guibg=NONE
  hi clear SignColumn
  hi Comment ctermbg=NONE guibg=NONE
else
  autocmd vimleavepre *.go !gofmt -w % " backup if fatih fails
  if has("syntax")
    syntax on
    hi Normal ctermbg=NONE guibg=NONE
    hi LineNr ctermbg=NONE guibg=NONE
    hi clear SignColumn
    hi Comment ctermbg=NONE guibg=NONE
  endif
endif
