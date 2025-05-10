load("@rules_python//python:py_binary.bzl", "py_binary")
load("@rules_python//python:py_library.bzl", "py_library")

package(
    default_visibility = ["//:__subpackages__"],
)

py_library(
    name = "common",
    srcs = [
        "mk_util.py",
        "mk_exception.py",
        "mk_genfile_common.py",
        "mk_project.py",
        "update_api.py",
    ],
    imports = ["."],
)
py_binary(
    name = "mk_make",
    srcs = ["mk_make.py"],
    deps = [
        ":common",
    ],
    imports = ["."],
)

py_binary(
    name = "pyg2hpp",
    srcs = ["pyg2hpp.py"],
    deps = [
        ":common",
    ],
    imports = ["."],
)

py_binary(
    name = "mk_pat_db",
    srcs = ["mk_pat_db.py"],
    deps = [
        ":common",
    ],
    imports = ["."],
)
