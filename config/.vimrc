let s:dein_dir = expand('~/.cache/dein')
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if &compatible
  set nocompatible
endif

if !isdirectory(s:dein_repo_dir)
  execute '!git clone git@github.com:Shougo/dein.vim.git' s:dein_repo_dir
endif

execute 'set runtimepath^=' . s:dein_repo_dir

call dein#begin(s:dein_dir)

call dein#add('Shougo/dein.vim')
call dein#add('Shougo/neocomplete.vim')
call dein#add('Shougo/neosnippet.vim')
call dein#add('Shougo/neosnippet-snippets')
call dein#add('itchyny/lightline.vim')
call dein#add('nathanaelkane/vim-indent-guides')
call dein#add('Townk/vim-autoclose')
call dein#add('honza/vim-snippets')
call dein#add('ujihisa/neco-look')
call dein#add('tpope/vim-surround')
call dein#add('tpope/vim-haml')
call dein#add('tpope/vim-endwise')
call dein#add('ctrlpvim/ctrlp.vim')
call dein#add('thinca/vim-ref')
call dein#add('slim-template/vim-slim')
call dein#add('szw/vim-tags')
call dein#add('scrooloose/syntastic')
call dein#add('cespare/vim-toml')
call dein#add('Shougo/unite.vim')
call dein#add('Shougo/neoinclude.vim')
call dein#add('Shougo/context_filetype.vim')
call dein#add('kana/vim-operator-user')
call dein#add('Shougo/vimproc.vim', {'build': 'make'})
call dein#add('tomasr/molokai')
"call dein#add('joshdick/onedark.vim')
call dein#add('osyo-manga/vim-reunions')
call dein#add('osyo-manga/vim-marching', {
            \ 'depends' : ['Shougo/vimproc.vim', 'osyo-manga/vim-reunions'],
            \ 'autoload' : {'filetypes' : ['c', 'cpp']}
            \ })
call dein#add('vim-jp/cpp-vim', {
            \ 'autoload' : {'filetypes' : 'cpp'}
            \ })
call dein#add('scrooloose/nerdtree')
call dein#add('jistr/vim-nerdtree-tabs')
call dein#add('rhysd/vim-clang-format', {
            \ 'autoload' : {'filetypes' : ['c', 'cpp']}
            \ })
call dein#add('benmills/vimux')
call dein#add('fholgado/minibufexpl.vim')
call dein#add('christoomey/vim-tmux-navigator')

call dein#end()

if dein#check_install()
  call dein#install()
endif

filetype on
filetype plugin indent on

set nu
set encoding=utf-8
colorscheme molokai
"colorscheme onedark
syntax on
set t_Co=256
let g:molokai_original = 1
let g:rehash256 = 1
"let g:onedark_termcolors=16
set background=dark
set showmode
set title
set ruler
set showcmd
set showmatch
set scrolloff=5
set cursorline
highlight CursorLine cterm=underline ctermfg=NONE ctermbg=NONE
set list
set listchars=trail:-
set laststatus=2
highlight ZenkakuSpace cterm=underline ctermfg=lightblue ctermbg=black
au BufNewFile,BufRead * match ZenkakuSpace //
set autoread " update file automaticaly
set expandtab " insert space character insted tab
inoremap <silent> jj <ESC> " change from insert to command by typping jj"
set nosi                " disable smartindext
set tabstop=2 shiftwidth=2 softtabstop=2        "set indent space
set backspace=2
set wrapscan
set ignorecase
set smartcase
set noincsearch
set hlsearch
let &t_ti.="\e[1 q"
let &t_SI.="\e[5 q"
let &t_EI.="\e[1 q"
let &t_te.="\e[0 q"

let g:lightline = {
      \ 'colorscheme': 'molokai',
      \ 'active': {
      \   'left': [['mode', 'paste'],
      \            ['fugitive', 'readonly', 'filename', 'modified']]
      \ },
      \ 'component': {
      \   'readonly': '%{&filetype=="help"?"":&readonly?"":""}',
      \   'modified': '%{&filetype=="help"?"":&modified?"+":&modifiable?"":"-"}',
      \   'fugitive': '%{exists("*fugitive#head")?fugitive#head():""}'
      \ },
      \ 'component_visible_condition': {
      \   'readonly': '(&filetype!="help"&& &readonly)',
      \   'modified': '(&filetype!="help"&&(&modified||!&modifiable))',
      \   'fugitive': '(exists("*fugitive#head") && ""!=fugitive#head())'
      \ },
  \ }
augroup cpp-namespace
  autocmd!
  autocmd FileType cpp inoremap <buffer><expr>; <SID>expand_namespace()
augroup END
augroup cpp-path
      autocmd!
      autocmd FileType cpp setlocal path=.,/usr/include,/usr/local/include,/usr/lib/c++/v1,/home/niwa/local/include
augroup END
function! s:expand_namespace()
  let s = getline('.')[0:col('.')-1]
  if s =~# '\<b;$'
    return "\<BS>oost::"
  elseif s =~# '\<s;$'
    return "\<BS>td::"
  elseif s =~# '\<d;$'
    return "\<BS>etail::"
  elseif s =~# '\<p;$'
    return "\<BS>qxx::"
  else
    return ';'
  endif
endfunction

let g:neomru#time_format = "(%Y/%m/%d %H:%M:%S) "
noremap :um :Unite file_mru

let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_auto_colors = 0
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd ctermbg=97
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven ctermbg=68
let g:indent_guides_guide_size=1


let g:neocomplete#force_overwrite_completefunc = 1
let g:acp_enableAtStartup = 0
let g:neocomplete#enable_at_startup = 1
let g:neocomplete#enable_smart_case = 1
let g:neocomplete#enable_camel_case_completion = 1
let g:neocomplete#enable_underbar_completion = 1
let g:neocomplete#min_syntax_length = 2
let g:neocomplete#enable_auto_select = 1
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
let g:neocomplete#force_omni_input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'
imap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
let g:marching_enable_neocomplete = 1
let g:marching#clang_command#options = {
      \ "cpp" : "-std=c++11"
      \}
let g:marching_include_paths = [
      \ '/usr/include/c++/4.8.5',
      \ '/usr/include/cryptopp',
      \ '/usr/include/pqxx',
      \ '/usr/include/Qt/*',
      \ '/usr/include/QtCore/*',
      \ '/usr/include/QtSql/*',
      \ '/usr/include/QtXml/*',
      \ '/usr/include'
      \]
set updatetime=200

let g:nerdtree_tabs_open_on_console_startup = 1
"autocmd VimEnter * NERDTree
"let g:NERDTreeShowBookmarks=1
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTreeType") && b:NERDTreeType == "primary") | q | endif
autocmd vimenter * wincmd p

autocmd FileType cpp set keywordprg=cppman
command! -nargs=+ Cppman silent! call system("tmux split-window cppman " . expand(<q-args>))
      \}
autocmd FileType cpp nnoremap <silent><Leader>K <ESC>:Cppman <cword><CR>

let g:syntastic_cpp_compiler_options = '-std=c++11'
let g:syntastic_python_checker = ['pyflakes', 'pep8']

nnoremap <C-s> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-i> :split<CR> :exe("tjump ".expand('<cword>'))<CR>

let g:clang_format#code_style = 'google'
autocmd FileType cpp vmap <Leader>cf :ClangFormat<CR>

let mapleader = "\<Space>"
" Run the current file with rspec
map <Leader>vw :call VimuxRunCommand("clear; pwd " . bufname("%"))<CR>
" Prompt for a command to run
map <Leader>vp :VimuxPromptCommand<CR>
" Run last command executed by VimuxRunCommand
map <Leader>vl :VimuxRunLastCommand<CR>
" Inspect runner pane
map <Leader>vj :VimuxInspectRunner<CR>
" Close vim tmux runner opened by VimuxRunCommand
map <Leader>vq :VimuxCloseRunner<CR>
" Interrupt any command running in the runner pane
map <Leader>vc :VimuxInterruptRunner<CR>
" Zoom the runner pane (use <bind-key> z to restore runner pane)
map <Leader>vz :call VimuxZoomRunner()<CR>

" comment out
map <Leader>co <S-i># <ESC>
vmap <Leader>co <S-i># <ESC>
map <Leader>uc ^xx<ESC>


let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
