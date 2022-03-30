# dot
just my dotfiles.
mostly for windows.
i put my explanations, notes, reasonings, and rants below.

## key features
features that i think are pretty good and worth checking out.
* quick mark
    <space> to place a mark, <shift-space> to go to mark. use numbers to make multiple marks (3<space>, 2<shift-space>). without a number, <space> and <shift-space> defaults to 0.
* emacs go-to-line
    takes number as input in commandline instead of vim's (number)G.
* emacs find-and-replace
    starts at current line, and loops back to the beginning of the file. always ask for confirmation.
* cycle windows without quickfix
* minimal statusline
    i realized that i don't need a statusline plugin since my statusline is quite simple. i doubt you need many things in statusline anyway.
* keymap reworks
    replacing ancient keybinds that are quite useless with things that i do quite often.

## nvim
i try to make my init.vim minimal, in keymaps and plugins, and loads fast. if i can do it without plugins, then i should. if you want a fast nvim gui client for windows, use nvy.

i wanted to use fuzzy finder, but for some reason i always need to tap <ESC> or <C-C> twice to close it. so i use ctrlp instead. i don't think it's that big of a deal. i'll find a replacement (or fix for fuzzy finder) when i need to.
replaced vim-completes-me with vim-mucomplete.

i used to use molokai for my colorscheme. it's a good colorscheme in my opinion. but for some reason, even after i highlight functions, delimiters, operators etc. i still find it hard to read sometimes. so i've been watching jon blow vods for a long while (years probably? idk), and even with minimal colorscheme, the code is fairly easy to read. idk how. or maybe it might just be placebo effect where i think i program better because i use the same config as the person whom i see as a better programmer. either way, whether it's placebo or not, it works, and honestly the colorscheme looks nice.

## mycmd & scripts
mycmd is a cmd shortcut with proggysquarettsz font and a monokai theme ripped from cmder. it runs initcmd.bat on start.

scripts folder has initcmd.bat which sets the prompt to be similar with cmder and run doskeys, build\_template.bat for cpp projects, and mpv-audio.bat to listen to audio-only ytdl mpv.

the reason why i use mycmd is because cmder is pretty slow. it does have a lot of features, but i think i'm fine without them, and i prefer speed instead. i've tried some alternatives like ConsoleZ, but i always find something weird about them. to be fair, i only tried 2 or 3 terminals and a lot of them are kind of "old looking". i haven't tried alacritty, tabby, windows terminal, etc. because i assume they're slower than cmd because of all the frills they put on to make it look "pretty". and some of them use javascript which just makes me go (put grimacing face emoji here). i would try out alacritty though, but for now mycmd is fast (enough) and it just werks, which is all that i need.
