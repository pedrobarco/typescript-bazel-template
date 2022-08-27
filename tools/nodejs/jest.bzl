"""
jest macros
"""

load("@npm//jest-cli:index.bzl", _jest = "jest", _jest_test = "jest_test")

def jest(**kwargs):
    __jest(test = False, **kwargs)

def jest_test(**kwargs):
    __jest(test = True, **kwargs)

def __jest(name, data, test, tsconfig = "//:tsconfig", jest_config = "//:jest.config.ts", **kwargs):
    deps = [
        jest_config,
        tsconfig,
        "@npm//c8",
    ]
    templated_args = [
        "--no-cache",
        "--no-watchman",
        "--ci",
        "--colors",
        "--config $(rootpath %s)" % jest_config,
    ]

    if test:
        _jest_test(
            name = name,
            data = deps + data,
            templated_args = templated_args,
            **kwargs
        )
    else:
        _jest(
            name = name,
            data = deps + data,
            templated_args = templated_args,
            **kwargs
        )
