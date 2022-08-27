"""
ts_project macros
"""

load("@npm//@bazel/typescript:index.bzl", _ts_project = "ts_project")

def ts_project(srcs = None, deps = [], data = [], **kwargs):
    srcs = srcs if srcs else native.glob(
        include = ["**/*.ts"],
        exclude = ["**/*.spec.ts", "node_modules/**/*"],
    )
    _ts_project(
        srcs = srcs,
        deps = deps + ["@npm//@types/node"],
        data = data,
        source_map = True,
        declaration = True,
        declaration_map = True,
        tsconfig = "//:tsconfig",
        **kwargs
    )
