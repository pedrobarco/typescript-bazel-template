"""
prettier macros
"""

load("@npm//:prettier/package_json.bzl", "bin")

def prettier(
        srcs = None,
        deps = [
            "//:node_modules/@usrbinboat/prettier-config",
            "//:node_modules/c8",
        ],
        config = "//:prettierrc",
        ignore = "//:prettierignore"):
    srcs = srcs if srcs else native.glob(
        include = [
            "**/*.js",
            "**/*.ts",
            "**/*.graphql",
            "**/*.json",
            "**/*.yaml",
            "**/*.adoc",
            "**/*.md",
        ],
        exclude = ["node_modules/**/*"],
    )

    bin.prettier_test(
        name = "prettier",
        data = [
            config,
            ignore,
        ] + srcs + deps,
        args = [
            "--config $(rootpath %s)" % config,
            "--ignore-path $(rootpath %s)" % ignore,
            "--check",
        ] + [
            "$(rootpath %s)" % src
            for src in srcs
        ],
        tags = ["lint"],
    )
