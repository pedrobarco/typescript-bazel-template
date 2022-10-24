"""
jest macros
"""

load("@npm//:jest-cli/package_json.bzl", "bin")
load("@aspect_rules_jest//jest:defs.bzl", _jest_test = "jest_test")

_DEPS = [
    "//:node_modules/c8",
]

def jest_test(data, config = "//:jest_config", **kwargs):
    _jest_test(
        config = config,
        data = _DEPS + data,
        **kwargs
    )

def jest(name, data, jest_config = "//:jest_config", **kwargs):
    bin.jest_binary(
        name = name,
        data = _DEPS + data + [jest_config],
        args = [
            "--no-cache",
            "--no-watchman",
            "--ci",
            "--colors",
            "--config $(rootpath %s)" % jest_config,
        ],
        **kwargs
    )
