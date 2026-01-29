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
if has('termguicolors')
  set termguicolors
endif

set t_Co=256

" more misc stuff "
"""""""""""""""""""
set textwidth=100
set colorcolumn=101
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
  Plug 'conradirwin/vim-bracketed-paste'
  Plug 'jiangmiao/auto-pairs'
  Plug 'kaarmu/typst.vim'
  Plug 'jnurmine/zenburn'
  call plug#end()

  set updatetime=100

  fun! JumpToDef()
    if exists("*GotoDefinition_" . &filetype)
      call GotoDefinition_{&filetype}()
    else
      exe "norm! \<C-]>"
    endif
    endf

  if has("syntax")
    syntax on
    set background=dark
	colorscheme zenburn
    hi Normal ctermbg=NONE guibg=NONE
    hi clear SignColumn
    hi Comment ctermbg=NONE guibg=NONE
    hi LineNr cterm=NONE ctermbg=NONE ctermfg=6 gui=NONE guibg=NONE guifg=#606360
  endif
else
  colorscheme retrobox
endif
