"""
prettier macros
"""

load("@npm//prettier:index.bzl", "prettier_test")

def prettier(
        srcs = None,
        deps = [
            "//packages/prettier-config",
            "@npm//c8",
        ],
        config = "//:.prettierrc.json",
        ignore = "//:.prettierignore"):
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

    prettier_test(
        name = "prettier",
        data = [
            config,
            ignore,
        ] + srcs + deps,
        templated_args = [
            "--config $(rootpath " + config + ")",
            "--ignore-path $(rootpath " + ignore + ")",
            "--check",
        ] + [
            "$(rootpath " + src + ")"
            for src in srcs
        ],
        tags = ["lint"],
    )
