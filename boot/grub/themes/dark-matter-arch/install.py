#
#   ,_   _   ,_  ,  ,    , , _  ___,___,_,,_       _,  ,_  ,  ,  __     ___, ,  _, , ,  _,
#   | \,'|\  |_) |_/    |\/|'|\' | ' | /_,|_)     / _  |_) |  | '|_)   ' | |_|,/_,|\/| /_,
#  _|_/  |-\'| \'| \    | `| |-\ |   |'\_'| \    '\_|`'| \'\__| _|_)     |'| |'\_ | `|'\_
# '      '  `'  `'  `   '  ` '  `'   '   `'  `     _|  '  `   `'         ' ' `   `'  `   `
#                                                 '
# Version: 1.0
#
# Written by Vandal (vandalsoul)
# Github: https://github.com/vandalsoul/darkmatter-grub2-theme/


# imports
import subprocess
import os

# functions
def check_root() -> None:
    id = int(subprocess.check_output("id -u", shell=True).decode("utf-8"))
    if id != 0:
        print("(!) Run the script with 'sudo' privileges or as root user !!\n")
        exit()


def change_grub_theme(grub_theme_path: str) -> None:
    with open("/etc/default/grub", "r") as grub_file:
        data = grub_file.readlines()
        flag = False
        for i, line in enumerate(data):
            if line.startswith("GRUB_THEME"):
                flag = True
                data.pop(i)  # removing existing line
                data.insert(i, f'GRUB_THEME="{grub_theme_path}"\n')  # adding new line

        if not flag:
            data.append(f'GRUB_THEME="{grub_theme_path}"\n')

    with open("/etc/default/grub", "w") as grub_file:
        grub_file.writelines(data)


# main-script
def main():
    print(
        r"""
        ,_   _   ,_  ,  ,    , , _  ___,___,_,,_       _,  ,_  ,  ,  __     ___, ,  _, , ,  _,
        | \,'|\  |_) |_/    |\/|'|\' | ' | /_,|_)     / _  |_) |  | '|_)   ' | |_|,/_,|\/| /_,
       _|_/  |-\'| \'| \    | `| |-\ |   |'\_'| \    '\_|`'| \'\__| _|_)     |'| |'\_ | `|'\_
      '      '  `'  `'  `   '  ` '  `'   '   `'  `     _|  '  `   `'         ' ' `   `'  `   `
                                                      '
    Version: 1.0

    Written by Vandal (vandalsoul)
    Github: https://github.com/vandalsoul/darkmatter-grub2-theme/                                                                   
    """
    )
    print("\n( Dark Matter GRUB Theme INSTALLER )\n")
    check_root()

    THEME_DIR = "dark-matter/"

    if os.path.exists("/boot/grub/"):

        GRUB_THEMES_DIR = "/boot/grub/themes/"
        GRUB_UPDATE_CMD = "grub-mkconfig -o /boot/grub/grub.cfg"

        if not os.path.exists(GRUB_THEMES_DIR):
            os.mkdir(GRUB_THEMES_DIR)

    elif os.path.exists("/boot/grub2/"):

        GRUB_THEMES_DIR = "/boot/grub2/themes/"
        GRUB_UPDATE_CMD = "grub2-mkconfig -o /etc/grub2.cfg"

        if not os.path.exists(GRUB_THEMES_DIR):
            os.mkdir(GRUB_THEMES_DIR)

    else:
        print("\n(!) Couldn't find the GRUB directory. Exiting the script ...")
        exit()

    # copying theme folder
    print("\n($) Copying the theme directory ...")
    subprocess.run(f"cp -r {THEME_DIR} {GRUB_THEMES_DIR}", shell=True)

    # editing the grub file
    print("\n($) Editing the GRUB file ...")
    THEME_FILE_PATH = f"{GRUB_THEMES_DIR}{THEME_DIR}theme.txt"
    change_grub_theme(THEME_FILE_PATH)

    # updating grub
    print("\n($) Updating GRUB ...\n")
    subprocess.run(GRUB_UPDATE_CMD, shell=True)

    print("\n($) Dark Matter GRUB theme was Successfully Installed !!\n")
    exit()


if __name__ == "__main__":
    try:
        main()
    except Exception:
        print(
            "\n(!) An unexpected error occured while running the script. Installation FAILED ..."
        )
