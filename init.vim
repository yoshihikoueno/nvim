set number
set noswapfile
set ignorecase
set smartcase
colorscheme vim
" close the preview window after inserting
" autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
nmap <silent> <ESC><ESC> : pclose <CR>

" Remember the cursor position
if has("autocmd")
  au BufReadPost * if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
endif


" tagbar
" autocmd vimenter * Tagbar
nmap <F8> :TagbarToggle<CR>

" Add a key binding for terminal
nmap <C-T><C-R> <ESC>:terminal<CR>:set nonumber<CR>i

" set python3 prog
let g:python3_host_prog = $HOME."/.config/nvim/env/bin/python3"

" enable search by seletected text
vnoremap // y/<C-R>"<CR>

" split line at comma
nnoremap <silent> ,, f,a<CR><ESC>

" Disable ZQ
nmap ZQ <NOP>

nmap <silent> \w :w<CR>

" insertモードから抜ける
inoremap <silent> jj <ESC>
inoremap <silent> <C-j> j
inoremap <silent> kk <ESC>
inoremap <silent> <C-k> k
" Turn off paste mode when leaving insert
autocmd InsertLeave * set nopaste

" set default tex type to LaTeX
let g:tex_flavor = "latex"

" enable spell-checking
autocmd FileType tex setlocal spell

" enable auto compile
augroup TexAutoCompile
    autocmd FileType tex :autocmd! TexAutoCompile BufWritePost <buffer> :RunWithouOutput
augroup END

" For global replace(Variable rename)
nnoremap gR gD:%s/<C-R>///gc<left><left><left>

filetype indent on
set tabstop=4
set shiftwidth=4
set expandtab

function SetSmallIndent()
    set tabstop=2
    set shiftwidth=2
    set expandtab
endfunction

autocmd FileType javascript call SetSmallIndent()
autocmd FileType vue call SetSmallIndent()
autocmd FileType html call SetSmallIndent()


" プラグインがインストールされるディレクトリ
let s:dein_dir = expand('~/.cache/dein')
" dein.vim 本体
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

" dein.vim がなければ github から落としてくる
if &runtimepath !~# '/dein.vim'
  if !isdirectory(s:dein_repo_dir)
    execute '!git clone https://github.com/Shougo/dein.vim' s:dein_repo_dir
  endif
  execute 'set runtimepath^=' . fnamemodify(s:dein_repo_dir, ':p')
endif

" 設定開始
if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)

  " プラグインリストを収めた TOML ファイル
  " 予め TOML ファイルを用意しておく
  let g:rc_dir    = expand('~/.config/nvim/')
  let s:toml      = g:rc_dir . '/dein.toml'
  let s:lazy_toml = g:rc_dir . '/dein_lazy.toml'

  " TOML を読み込み、キャッシュしておく
  call dein#load_toml(s:toml,      {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})

  " 設定終了
  call dein#end()
  call dein#save_state()
endif

call dein#add('Shougo/vimproc.vim', {'build' : 'make'})
" もし、未インストールものものがあったらインストール
if dein#check_install()
  call dein#install()
endif

set mouse=
