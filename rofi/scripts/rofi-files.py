#!/usr/bin/env python3

import subprocess

if __name__ == '__main__':

    files = subprocess.run(['fd'], encoding='utf-8',
                           capture_output=True).stdout.split('\n')

    title = 'files'
    rofi_command = 'rofi -dmenu -i -p {} -theme ~/.config/rofi/files.rasi -no-fixed-num-lines'.format(title)
    rofi_input = '\n'.join(file for file in files)
    cp = subprocess.run(rofi_command.split(), input=rofi_input,
                        encoding='utf-8', capture_output=True)

    if cp.returncode == 0:
        file = cp.stdout.strip()
        xdg_command = ['xdg-open', file]
        subprocess.run(xdg_command,
                       encoding='utf-8', capture_output=True)
