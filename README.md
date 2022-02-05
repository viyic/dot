# dot
just my dotfiles.
this is mostly for windows.
i put my explanations, notes, reasonings, and rants below.

## nvim
i try to make my init.vim minimal, in keymaps and plugins, and loads fast. if i could do it without plugins, then i should. if you want a fast nvim gui client for windows, use nvy.

i wanted to use fuzzy finder, but for some reason i always need to tap <ESC> or <C-C> twice to close it. so i use ctrlp instead. i don't think it's that big of a deal (for now?). i don't think i need fuzzy search anyway(?).
vim-completes-me sometimes requires me to tap <Tab> twice, which is kind of annoying, but whatever.

i used to use molokai for my theme. it's a good theme in my opinion. but for some reason, even after i highlight functions, delimiters, operators etc. i still find it hard to read sometimes. so i've been watching jon blow vods for a long while (years probably? idk), and even with minimal colorscheme, the code is fairly easy to read. idk how. or maybe it might just be placebo effect where i think i program better because i use the same config as the person that i see as a better programmer. either way, whether it's placebo or not, it works, and honestly the colorscheme looks nice. just to be clear, i'm not an extreme jon blow fanboy, i do think he has good points, but i can see his flaws.

## mycmd & scripts
mycmd is a cmd shortcut with proggysquarettsz font and a monokai theme ripped from cmder. it runs initcmd.bat on start.

scripts folder has initcmd.bat which sets the prompt to be similar with cmder and run doskeys, build\_template.bat for cpp projects, and mpv-audio.bat to listen to audio-only ytdl mpv.

the reason why i use mycmd is because cmder is pretty slow. it does have a lot of features, but i think i'm fine without them, and i prefer speed instead. i've tried some alternatives like ConsoleZ, but i always find something weird about them. to be fair, i only tried 2 or 3 terminals and a lot of them are kind of "old looking". i haven't tried alacritty, tabby, windows terminal, etc. because i assume they're slower than cmd because of all the frills they put on to make it "pretty". and some of them use javascript which just makes me go (put grimacing face emoji here). (i might be too critical of javascript idk).i would try out alacritty though, but for now mycmd is fast (enough) and just works, which is all that i need.
