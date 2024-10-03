@echo off

FOR /F "tokens=* USEBACKQ" %%F IN (`fzf --walker="dir,follow,hidden" --walker-root="E:/lambda/" %*`) DO (
cd %%F
)
