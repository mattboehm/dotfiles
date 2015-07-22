"""Usage: python install.py [-f|-u]
    -f: force deletion of install targets if they already exist
    -u: uninstall symlinks"""
import os
import sys

SOURCE_PATH = os.path.dirname(os.path.realpath(__file__))
TARGET_PATH = os.path.expanduser("~")
PATHS_TO_INSTALL = [
    ("vim", ".vim"),
    ("vim", ".nvim"),
    ("bash/.bashrc", ".bashrc"),
    ("git/gitconfig", ".gitconfig"),
]
#put the directories on the paths
PATHS_TO_INSTALL = [(
        os.path.join(SOURCE_PATH, SOURCE),
        os.path.join(TARGET_PATH, TARGET)
    ) for SOURCE, TARGET in PATHS_TO_INSTALL]

class HandledError(Exception):
    """Any 'expected' exception"""
    pass

def check_targets(path_pairs):
    """raise a `HandledError` if any of the targets exist"""
    for _, target in path_pairs:
        if os.path.lexists(target):
            raise HandledError(
                (
                    "Target directory {} exists, cowardly refusing to continue.\n"
                    "Please move/delete that directory or run this with the -f flag"
                ).format(target)
            )

def install_targets(path_pairs, uninstall_only=False):
    """if uninstall_only: just remove the existing links """
    for link_target, link_name in path_pairs:
        #remove the path if it exists
        if uninstall_only:
            sys.stderr.write("removing {}".format(link_name))
        if os.path.islink(link_name):
            os.remove(link_name)
        if os.path.isdir(link_name):
            os.rmdir(link_name)
        elif os.path.exists(link_name):
            os.remove(link_name)

        if not uninstall_only:
            sys.stderr.write("{link}\n\t-> {target}\n".format(
                link=link_name,
                target=link_target))
            os.symlink(link_target, link_name)


def main(args):
    """handle args and install/uninstall"""
    uninstall = False
    force = False
    if len(args) == 2 and args[1] == "-f":
        force = True
    elif len(args) == 2 and args[1] == "-u":
        uninstall = True
    elif len(args) != 1:
        raise HandledError("Incorrect Usage!\n" + __doc__)

    if not (force or uninstall):
        check_targets(PATHS_TO_INSTALL)

    install_targets(PATHS_TO_INSTALL, uninstall_only=uninstall)


if __name__ == '__main__':
    try:
        main(sys.argv)
    except HandledError, err:
        sys.stderr.write(err.message+"\n")
