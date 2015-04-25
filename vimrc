" Modeline and Notes {{{

" vim:shiftwidth=2:tabstop=8:expandtab
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={{{,}}} foldlevel=0 foldmethod=marker:

" }}}

" Environment {{{

    " Basics {{{

        set nocompatible        " Must be first line
    " }}}

" }}}

" General {{{

    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8
    " Save when losing focus
    au FocusLost * :silent! wall

    " Resize splits when the window is resized
    au VimResized * :wincmd =
    " Automatically switch to the current file directory when
    " a new buffer is opened;
    " Always switch to the current file directory
    autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
    set autowrite                       " Automatically write a file when leaving a modified buffer
    highlight clear CursorLineNr    " Remove highlight color from current line number

    set shortmess+=filmnrxoOtT          " Abbrev. of messages (avoids 'hit enter')
    set virtualedit=onemore             " Allow for cursor beyond last character
    set history=1000                    " Store a ton of history (default is 20)
    set hidden                          " Allow buffer switching without saving
    set spell
    set spelllang=en
    nnoremap <F6> :set spell!<CR>
    autocmd GUIEnter * set vb t_vb=
    set hidden                          " remember undo after quitting

    " Restore cursor to file position in previous editing session
    function! ResCur()
        if line("'\"") <= line("$")
            normal! g`"
            return 1
        endif
    endfunction

    augroup resCur
        autocmd!
        autocmd BufWinEnter * call ResCur()
    augroup END
    set autochdir
    set autoread

" }}}

" Vim UI {{{

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode
    set cursorline                  " Highlight current line

    highlight clear SignColumn      " SignColumn should match background
    highlight clear LineNr          " Current line number row will have same background color in relative mode

    if has('cmdline_info')
        set ruler                   " Show the ruler
        set rulerformat=%30(%=\:b%n%y%m%r%w\ %l,%c%V\ %P%) " A ruler on steroids
        set showcmd                 " Show partial commands in status line and
                                    " Selected characters/lines in visual mode
    endif

    if has('statusline')
        set laststatus=2
        set statusline=%<%f\                     " Filename
        set statusline+=%w%h%m%r                 " Options
        set statusline+=\ [%{&ff}/%Y]            " Filetype
        set statusline+=\ [%{getcwd()}]          " Current dir
        set statusline+=%=%-14.(%l,%c%V%)\ %p%%  " Right aligned file nav info
    endif

    set guioptions=e                 " no menus, scrollbars, or other junk
    set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    set nu                          " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms
    set winminheight=0              " Windows can be 0 line high
    set ignorecase                  " Case insensitive search
    set smartcase                   " Case sensitive when uc present
    set wildmenu                    " Show list instead of just completing
    set wildmode=list:longest,full  " Command <Tab> completion, list matches, then longest common part, then all.
    set whichwrap=b,s,h,l,<,>,[,]   " Backspace and cursor keys wrap too
    set scrolljump=5                " Lines to scroll when cursor leaves screen
    set scrolloff=3                 " Minimum lines to keep above and below cursor
    set foldenable                  " Auto fold code
    set list
    set listchars=tab:›\ ,trail:•,extends:>,precedes:<,eol:¬ " Highlight problematic whitespace
    set vb t_vb=

    " Only have cursorline in current window
    autocmd WinLeave * set nocursorline
    autocmd WinEnter * set cursorline

    " Reuse status as window title
    let &titlestring='%{getcwd()}/%f]   %y  #%n   %p%%   %l/%L,%c%V'
    set titlestring+=\ {%{v:servername}}

" }}}

" Formatting {{{

    set nowrap                      " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set smartindent
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current
    set pastetoggle=<F12>           " pastetoggle (sane indentation on pastes)
    set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks

" }}}

" Key (re)Mappings {{{

    " The mapleader  ',' as it's in a standard
    let mapleader = ','
    "edit vimrc and source vimrc
    nnoremap <leader>er :tabedit $MYVIMRC<cr>
    "nnoremap <leader>sr :source $MYVIMRC<cr>
    augroup AutoReloadVimRC
        au!
        " automatically reload vimrc when it's saved
        au BufWritePost $MYVIMRC so $MYVIMRC
    augroup END

    " Easier moving in tabs and windows
    noremap <C-j> <C-W>j<C-W>
    noremap <C-k> <C-W>k<C-W>
    noremap <C-l> <C-W>l<C-W>
    noremap <C-h> <C-W>h<C-W>
    nnoremap <silent> <Leader>+ :exe "resize ".(winheight(0) * 3/2)<CR>
    nnoremap <silent> <Leader>- :exe "resize ".(winheight(0) * 2/3)<CR>
    " Maxiamize current viewports
    noremap <F3> <C-W>_<C-W><Bar>
    " Adjust viewports to the same size
    noremap <F4> <C-W>=

    " Copy and Paste with System buffer
    noremap <leader>sy "+yy
    noremap <leader>sp "+gP
    " Wrapped lines goes down/up to next row, rather than next line in file.
    noremap j gj
    noremap k gk
    noremap B ^
    noremap E $

    " Moving between tabs,the following two lines conflict with moving to top and
    " bottom of the screen
    noremap <S-H> gT
    noremap <S-L> gt

    " Most prefer to toggle search highlighting rather than clear the current
    " search results.
    " Key mapping to stop the search highlight
    nnoremap <silent> n   n:call HLNext(0.3)<CR>
    nnoremap <silent> N   N:call HLNext(0.3)<CR>

    function! HLNext(blinktime)
        highlight airline_warning_bold term=bold cterm=bold ctermfg=230 ctermbg=166 gui=bold guifg=#fdf6e3 guibg=#cb4b16
        let [bufnum, lnum, col, off] = getpos('.')
        let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))
        let target_pat = '\c\%#'.@/
        let blinks = 2
        for n in range(1,blinks)
            let red = matchadd('airline_warning_bold', target_pat, 101)
            redraw
            exec 'sleep '.float2nr(a:blinktime / (2 * blinks) * 1000).'m'
            call matchdelete(red)
            redraw
            exec 'sleep '.float2nr(a:blinktime / (2 * blinks) * 1000).'m'
        endfor
    endfunction

    nnoremap <silent> <F2>      :nohlsearch<CR>
    inoremap <silent> <F2> <C-O>:nohlsearch<CR>

    " Shortcuts
    " Change Working Directory to that of the current file
    cnoremap cwd lcd %:p:h
    cnoremap cd. lcd %:p:h

    " Visual shifting (does not exit Visual mode)
    vnoremap < <gv
    vnoremap > >gv

    " Allow using the repeat operator with a visual selection (!)
    vnoremap . :normal .<CR>

    " Some helpers to edit mode
    cnoremap %% <C-R>=expand('%:h').'/'<cr>
    cnoremap && <C-R>=expand('%:p')<cr>
    map <leader>w  : w<CR>
    map <leader>ww : w!<CR>
    map <leader>ew : vsp %%<CR>
    map <leader>es : sp &&<CR>
    map <leader>ev : vsp %%
    map <leader>et : tabe<CR>

    " Map <Leader>ff to display all lines with keyword under cursor
    " and ask which one to jump to
    nnoremap <Leader>ff [I:let nr = input("Which one: ")<Bar>exe "normal " . nr ."[\t"<CR>

    " Easier horizontal scrolling
    noremap zl zL
    noremap zh zH

    " Copy current file full path, name and echo full path
    noremap <silent> <Leader>cp :let @* = expand("%:p")<CR>
    noremap <silent> <Leader>cf :let @* = expand("%:t")<CR>
    noremap <Leader>ef :echo expand("%:p")<CR>

    " Quick substitution the word under cursor in the current paragraph
    nnoremap <leader>s :'{,'}s/\<<c-r>=expand('<cword>')<cr>\>/
    nnoremap <leader>ss :%s/\<<c-r>=expand('<cword>')<cr>\>/

    " Print Message to a New Vsplit
    noremap <leader>pm <esc>:call RedirMessages('messages', 'vnew')<cr>
    noremap <leader>ph <esc>:call RedirMessages('history', 'vnew')<cr>

    " Add surrunding to word or centensce
    vnoremap <leader>" <esc>a"<esc>`<i"<esc>`>2l
    vnoremap <leader>' <esc>a'<esc>`<i'<esc>`>2l
    vnoremap <leader>[ <esc>a]<esc>`<i[<esc>`>2l
    vnoremap <leader>{ <esc>a}<esc>`<i{<esc>`>2l
    vnoremap <leader>( <esc>a)<esc>`<i(<esc>`>2l
    nnoremap <leader>" viw<esc>a"<esc>bi"<esc>el
    nnoremap <leader>' viw<esc>a'<esc>bi'<esc>el
    nnoremap <leader>[ viw<esc>a]<esc>bi[<esc>el
    nnoremap <leader>( viw<esc>a)<esc>bi(<esc>el
    nnoremap <leader>{ viw<esc>a}<esc>bi{<esc>el

    " ,n to insert the time, 'n'ow
    map <leader>n "=strftime("%FT%T%z")<CR>Pa<SPACE>

    " map za to zA to open fold recursively
    nnoremap za zA
" }}}
