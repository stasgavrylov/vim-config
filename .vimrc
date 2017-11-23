" My vim config
"
" Maintainer:	Stas Gavrylov <stasgavrylov@gmail.com>
" Last change: Nov 21, 2017
"
" Installation
" git clone git@github.com:stasgavrylov/vim-config.git ~/.vim
" 
" Create symlinks
" ln -s ~/.vim/.vimrc ~/.vimrc
" ln -s ~/.vim/.vimrc ~/.ideavimrc  // if you use IdeaVIM, obviously
"
" DEFAULT CONFIG
"
" Use Vim settings, rather than Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

" allow backspacing over everything in insert mode
set backspace=indent,eol,start
set history=50		" keep 50 lines of command line history
set ruler		" show the cursor position all the time
set showcmd		" display incomplete commands
set incsearch		" do incremental searching
"
" Don't use Ex mode, use Q for formatting
map Q gq

" CTRL-U in insert mode deletes a lot.  Use CTRL-G u to first break undo,
" so that you can undo CTRL-U after inserting a line break.
inoremap <C-U> <C-G>u<C-U>

" In many terminal emulators the mouse works just fine, thus enable it.
if has('mouse')
  set mouse=a
endif

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " Enable file type detection.
  " Use the default filetype settings, so that mail gets 'tw' set to 72,
  " 'cindent' is on in C files, etc.
  " Also load indent files, to automatically do language-dependent indenting.
  filetype plugin indent on

  " Put these in an autocmd group, so that we can delete them easily.
  augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  autocmd FileType text setlocal textwidth=78

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  " Also don't do it when the mark is in the first line, that is the default
  " position when opening a file.
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

  augroup END

else

  set autoindent		" always set autoindenting on

endif " has("autocmd")

" Convenient command to see the difference between the current buffer and the
" file it was loaded from, thus the changes you made.
" Only define it when not defined already.
if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif



" PERSONAL CONFIG
"
" Map jj to Esc in INLINE mode
imap jj <Esc>

" make < > shifts keep selection
:vnoremap < <gv
:vnoremap > >gv
set shiftwidth=2 " number of columns text is indented with > <

set softtabstop=2 " number of columns for Tab shift in insert mode
set expandtab " convert Tab to spaces in insert mode
set number " show current line number under cursor
set relativenumber " show relative line numbers instead of absolute
set showmode " show current mode
set incsearch " instant move to search query when typing
set ic " ignore case during search
set ts=2 "set tabstop to 2 characters
nmap gD :action GotoImplementation<CR> "for IdeaVIM

set scrolloff=3         " keep 3 lines when scrolling
set ai                  " set auto-indenting on for programming

set showcmd             " display incomplete commands
set nobackup            " do not keep a backup file

set showmatch           " jump to matches when entering regexp
set smartcase           " no ignorecase if Uppercase char present

set visualbell t_vb=    " turn off error beep/flash
set novisualbell        " turn off visual bell

set surrond             " enable vim-surround plugin in IdeaVIM
