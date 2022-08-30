"""
ts_project macros
"""

load("@aspect_rules_ts//ts:defs.bzl", _ts_project = "ts_project")

def ts_project(name = "tsconfig", srcs = None, deps = [], data = [], **kwargs):
    srcs = srcs if srcs else native.glob(
        include = ["**/*.ts"],
        exclude = ["**/*.spec.ts", "node_modules/**/*"],
    )
    _ts_project(
        name = name,
        srcs = srcs,
        deps = deps + ["//:node_modules/@types/node"],
        data = data,
        source_map = True,
        declaration = True,
        declaration_map = True,
        tsconfig = "//:tsconfig",
        **kwargs
    )
