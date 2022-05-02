"""
eslint rules wrapper
"""

load("@npm//eslint:index.bzl", "eslint_test")

def eslint(
        name,
        config = "//:.eslintrc.json",
        srcs = None,
        deps = [],
        ignore = "//packages/eslint-config:.eslintignore"):
    srcs = srcs if srcs else native.glob(["**/*.js", "**/*.jsx", "**/*.ts", "**/*.tsx"])

    eslint_test(
        name = name,
        data = [
            config,
            ignore,
            "@npm//@typescript-eslint/eslint-plugin",
            "@npm//@typescript-eslint/parser",
            "@npm//eslint-config-prettier",
            "@npm//eslint-import-resolver-typescript",
            "@npm//eslint-plugin-import",
            "@npm//eslint-plugin-jest",
            "@npm//eslint-plugin-jest-formatting",
            "@npm//eslint-plugin-prettier",
            "@npm//@types/jest",
            "@npm//jest",
            "@npm//ts-jest",
            "@npm//prettier",
            "//:tsconfig.json",
            "//:tsconfig.eslint.json",
            "//packages/eslint-config",
            "//packages/prettier-config",
            "//:.prettierrc.json",
            "//:jest.config.ts",
        ] + srcs + deps,
        templated_args = [
            "--config $(rootpath " + config + ")",
            "--ignore-path $(rootpath " + ignore + ")",
        ] + [
            "$(rootpath " + src + ")"
            for src in srcs
        ],
        tags = ["lint"],
    )
