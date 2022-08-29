"""
jest macros
"""

load("@npm//:jest-cli/package_json.bzl", "bin")

def jest(**kwargs):
    _jest(test = False, **kwargs)

def jest_test(**kwargs):
    _jest(test = True, **kwargs)

def _jest(name, data, test, tsconfig = "//:tsconfig", jest_config = "//:jest_config", **kwargs):
    deps = [
        jest_config,
        tsconfig,
        "//:node_modules/c8",
    ]
    args = [
        "--no-cache",
        "--no-watchman",
        "--ci",
        "--colors",
        "--config $(rootpath %s)" % jest_config,
    ]

    if test:
        bin.jest_test(
            name = name,
            data = deps + data,
            args = args,
            **kwargs
        )
    else:
        bin.jest_binary(
            name = name,
            data = deps + data,
            args = args,
            **kwargs
        )
