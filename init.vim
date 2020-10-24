" BASIC SETUP

call plug#begin('~/.config/nvim/plugged')

" Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'tweekmonster/gofmt.vim'
" Plug 'tpope/vim-fugitive'
" Plug 'vim-utils/vim-man'
" Plug 'mbbill/undotree'
" Plug 'sheerun/vim-polyglot'
" Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
" Plug 'junegunn/fzf.vim'
Plug 'jiangmiao/auto-pairs'
" Plug 'kien/ctrlp.vim'
Plug 'mattn/emmet-vim'
Plug 'preservim/nerdcommenter'
Plug 'preservim/nerdtree'
" Plug 'vimlab/split-term.vim'
" Plug 'vim-airline/vim-airline-themes'
Plug 'ap/vim-css-color'
Plug 'adelarsq/vim-matchit'
Plug 'tpope/vim-surround'
Plug 'gruvbox-community/gruvbox'
" Plug 'sainnhe/gruvbox-material'
" Plug 'phanviet/vim-monokai-pro'
" Plug 'vim-airline/vim-airline'
" Plug 'flazz/vim-colorschemes'

call plug#end()

let g:coc_start_at_startup = v:false

colorscheme gruvbox
let g:airline_theme='gruvbox'
set background=dark
" if color looks wrong...
if ($TERM == "screen" || $TERM =~ "256")
    set t_Co=256
    "set t_kb=
    set t_ut=
endif
"gvim
if has('gui_running')
  set guifont=Lucida_Console:h14	"set font
  set noeb vb t_vb=			"disable beeps
  set lines=999 columns=999		"maximize window
  set autochdir                         "Automatically change the current directory
endif
"end gvim
let mapleader = ","

set nocompatible	"do not act like vi 
set relativenumber
syntax enable
filetype plugin on
set encoding=utf-8
set fileencoding=utf-8
set hidden              " allows you to re-use the same window and switch from an unsaved buffer without saving it first
set diffopt+=vertical   " Always use vertical diffs
set incsearch           " search as characters are entered
set hlsearch            " highlight matches
set ignorecase          " Use case insensitive search, except when using capital letters
set smartcase


set colorcolumn=80
" highlight ColorColumn ctermbg=0 guibg=lightgrey

" Change cursor in insert mode:
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"
" optional reset cursor on start:
augroup myCmds
au!
autocmd VimEnter * silent !echo -ne "\e[2 q"
augroup END

"relative numbers map
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
  else
    set relativenumber
  endif
endfunc

map <leader>r :call NumberToggle()<cr>

" TABS
nmap <leader>+ :tab sp<cr>
nmap <leader>- <c-w>c<cr>

" Allow backspacing over autoindent, line breaks and start of insert action
set backspace=indent,eol,start

" When opening a new line and no filetype-specific indenting is enabled, keep
" the same indent as the line you're currently on. Useful for READMEs, etc.
set autoindent

" Display the cursor position on the last line of the screen or in the status
" line of a window
set ruler

" "Always display the status line, even if only one window is displayed
set laststatus=2
"
"SET STATUSBAR
function! GitBranch()
 return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction
"
function! StatuslineGit()
 let l:branchname = GitBranch()
 return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction
" "
" " hi Base guibg=#212333 guifg=#212333
set statusline=
" set statusline += "%#Base#"
"
" set statusline+=%#PmenuSel#
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\ %f
set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c
set statusline+=\
"
" Instead of failing a command because of unsaved changes, instead raise a
" dialogue asking if you wish to save changed files.
set confirm

" escape:
" jk is escape
inoremap jk <ESC>

" turn off search highlight
nnoremap <leader>h :nohlsearch<CR>

" resize
nnoremap <leader><Up> :resize +2<CR>
nnoremap <leader><Down> :resize -2<CR>
nnoremap <leader><Left> :vertical resize +2<CR>
nnoremap <leader><Right> :vertical resize -2<CR>


":nnoremap <silent> <Leader> :<C-u>try \| execute "b" . v:count \| catch \| endtry<CR>
for i in range(1, 99)
    execute printf('nnoremap <Leader>%d :%db<CR>', i, i)
endfor
for i in range(1, 99)
    execute printf('nnoremap <Leader>d%d :Bdelete %d<CR>', i, i)
endfor
" }}}
map <leader>q :bp<cr>
map <leader>w :bn<cr>




" STYLING
" Set tabs to 2 spaces
set expandtab
set shiftwidth=2
set softtabstop=2
set number
set showcmd             " Show command
set cursorline          " highlight cursorline
filetype indent on      " load filetype-specific indent files
filetype plugin on      " load filetype-specific plugin files
set mouse=a             " Use mouse
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]

" FINDING FILES:

" Search down into subfolders
" Provides tab-completion for all file-related tasks
set path+=**	" ** = search in every subdirectory

" Display all matching files when we tab complete
set wildmenu

" NOW WE CAN:
" - Hit tab to :find by partial match
" - Use * to make it fuzzy

" THINGS TO CONSIDER:
" - :b lets you autocomplete any open buffer


" TAG JUMPING:

" Create the `tags` file (may need to install ctags first)
"command! MakeTags !ctags -R --exclude={.git/*,node_modules/*,.env/*,.idea/*} ./
command! MakeTags !ctags -R -f ./.git/tags --exclude=.git --exclude=node_modules --exclude=test ./ 


" NOW WE CAN:
" - Use ^] to jump to tag under cursor
" - Use g^] for ambiguous tags
" - Use ^t to jump back up the tag stack

" THINGS TO CONSIDER:
" - This doesn't help if you want a visual list of tags




" AUTOCOMPLETE:

" The good stuff is documented in |ins-completion|

" HIGHLIGHTS:
" - ^x^n for JUST this file
" - ^x^f for filenames (works with our path trick!)
" - ^x^] for tags only
" - ^n for anything specified by the 'complete' option

" NOW WE CAN:
" - Use ^n and ^p to go back and forth in the suggestion list
"

" FILE BROWSING:
" Tweaks for browsing
let g:netrw_banner=0        " disable annoying banner
let g:netrw_browse_split=4  " open in prior window
let g:netrw_altv=1          " open splits to the right
let g:netrw_liststyle=3     " tree view
let g:netrw_list_hide=netrw_gitignore#Hide()
let g:netrw_list_hide.=',\(^\|\s\s\)\zs\.\S\+'
let g:netrw_winsize = 25
" open it when open new file 
"augroup ProjectDrawer
"  autocmd!
"  autocmd VimEnter * :Vexplore
"augroup END

" NOW WE CAN:
" - :edit a folder to open a file browser
" - <CR>/v/t to open in an h-split/v-split/tab
" - check |netrw-browse-maps| for more mappings



" Plugins settings:
"""""""NerdTree
nmap <C-n> :NERDTreeToggle %<CR>
let g:NERDTreeIgnore = ['^node_modules$']    

"""""""NerdCommenter
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'
" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1
" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }
" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1
" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1
" Enable hidden files
let NERDTreeShowHidden=1

vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

"""""""""CtrlP
let g:ctrlp_working_path_mode = 'ra'
let os=substitute(system('uname'), '\n', '', '')
if os == 'Darwin' || os == 'Mac'
  set wildignore+=*/tmp/*,*.so,*.swp,*.zip     " MacOSX/Linux
  let g:ctrlp_user_command = 'find %s -type f'        " MacOSX/Linux
elseif os == 'Linux'
  set wildignore+=*\\tmp\\*,*.swp,*.zip,*.exe  " Windows
  let g:ctrlp_user_command = 'dir %s /-n /b /s /a-d'  " Windows
endif

let g:ctrlp_show_hidden = 0

let g:ctrlp_user_command = ['.git/', 'git --git-dir=%s/.git ls-files -oc --exclude-standard']
let g:ctrlp_custom_ignore = '\v[\/]\.(git|hg|svn)$'
let g:ctrlp_custom_ignore = {
 \ 'dir':  '\v[\/]\.(git|hg|svn)$',
 \ 'file': '\v\.(exe|so|dll)$',
 \ 'link': 'some_bad_symbolic_links',
    \ }


"""""""""Vim-airline
" se abilitata non funziona jk x esc
" if ! has('gui_running')
"   set ttimeoutlen=10
"   augroup FastEscape
"     autocmd!
"     au InsertEnter * set timeoutlen=0
"     au InsertLeave * set timeoutlen=1000
"   augroup END
" endif
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
let g:airline_left_sep = ''
let g:airline_right_sep = ''
"
"

"""""""""Syntastic
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 0
" let g:syntastic_check_on_wq = 0
" let g:syntastic_mode_map = { 'mode': 'passive'}

"""""""""""Filetype
au BufNewFile,BufRead *.ejs set filetype=html
au BufNewFile,BufRead *.hbs set filetype=html
au BufNewFile,BufRead *.handlebars set filetype=html
au BufNewFile,BufRead *.svelte set filetype=html


" Comando per chiudere tutti i buffer eccetto l'ultimo
command! BufOnly execute '%bdelete|edit #|normal `"'

" Use tab with emmet
"imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
let g:user_emmet_leader_key=','

" For :Term
set splitbelow
set splitright

" COC
" Install follow https://github.com/neoclide/coc.nvim/wiki/Install-coc.nvim
" GoTo code navigation.
nmap <leader>gd <Plug>(coc-definition)
nmap <leader>gy <Plug>(coc-type-definition)
nmap <leader>gi <Plug>(coc-implementation)
nmap <leader>gr <Plug>(coc-references)
nnoremap <leader>cr :CocRestart

let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-json',
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-phpls',
  \ 'coc-tsserver',
  \ 'coc-vetur',
  \ 'coc-java',
  \ 'coc-python',
  \ ]

autocmd BufNew,BufEnter *.json,*.vim,*.lua,*.md execute "silent! CocDisable"
" autocmd BufLeave *.json,*.vim,*.lua,*.md execute "silent! CocDisable"

let g:ycm_filetype_blacklist = {
            \ 'vim': 1,         
            \ 'lua': 1,         
            \ 'json': 1,        
            \ 'md': 1,        
            \ }


" "VimWiki
" let g:vimwiki_list = [{'path': '~/vimwiki/',
"                       \ 'syntax': 'markdown', 'ext': '.md'}]
"
