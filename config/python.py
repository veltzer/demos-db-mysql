""" python deps for this project """

install_requires: list[str] = [
    "termcolor",
    "yattag",
    "pylogconf",
]
build_requires: list[str] = [
    "pydmt",
    "pymakehelper",
]
test_requires: list[str] = [
    "pylint",
    "pytest",
    "pytest-cov",
    "mypy",
    # types
    "types-termcolor",
    "types-PyYAML",
]
requires = install_requires + build_requires + test_requires
