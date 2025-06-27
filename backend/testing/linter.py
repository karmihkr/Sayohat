import re
import pycodestyle
import os
import pathlib


was = False
for root, files in map(lambda elem: [elem[0], list(filter(lambda el: re.fullmatch("[A-Za-z]+_?[A-Za-z]*.py", el),
                                                          elem[2]))], os.walk(pathlib.Path(__file__).parent.parent
                                                                              / "src")):
    for file in files:
        if pycodestyle.Checker(pathlib.Path(root) / file, max_line_length=120).check_all():
            was = True
if was:
    raise SyntaxError("pycodestyle linter found errors!")
