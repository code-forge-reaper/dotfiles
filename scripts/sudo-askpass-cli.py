#!/usr/bin/env python3
import curses
from sys import stdout

passwd = ""


def main(stdscr):
    global passwd
    curses.noecho()
    curses.cbreak()
    stdscr.keypad(True)

    h, w = stdscr.getmaxyx()

    win_h, win_w = 10, 40
    y = (h - win_h) // 2
    x = (w - win_w) // 2

    win = curses.newwin(win_h, win_w, y, x)
    win.keypad(True)

    while True:
        win.clear()
        win.border("|", "|", "-", "-", "/", "\\", "\\", "/")
        win.addstr(4, 4, "Password:")
        win.addstr(5, 4, "*" * len(passwd))
        win.move(5, 4 + len(passwd))
        win.refresh()

        ch = win.getch()

        if ch in (10, 13):  # Enter
            break
        elif ch in (curses.KEY_BACKSPACE, 127, 8):
            passwd = passwd[:-1]
        elif 32 <= ch <= 126:
            passwd += chr(ch)


curses.wrapper(main)
stdout.write(passwd + "\n")
stdout.flush()
