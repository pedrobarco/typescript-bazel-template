"""
eslint macros
"""

load("@npm//eslint:index.bzl", "eslint_test")

def eslint(
        srcs = None,
        deps = [],
        config = "//:.eslintrc.js",
        ignore = "//:.eslintignore"):
    srcs = srcs if srcs else native.glob(
        include = ["**/*.ts"],
        exclude = ["node_modules/**/*"],
    )

    eslint_test(
        name = "eslint",
        data = [
            config,
            ignore,
            "//:tsconfig.eslint.json",
            "//:tsconfig.json",
            "@npm//@types/jest",
            "@npm//@typescript-eslint/eslint-plugin",
            "@npm//@typescript-eslint/parser",
            "@npm//eslint-config-prettier",
            "@npm//eslint-import-resolver-typescript",
            "@npm//eslint-plugin-import",
            "@npm//eslint-plugin-jest",
            "@npm//eslint-plugin-jest-formatting",
            "@npm//eslint-plugin-jsdoc",
            "@npm//eslint-plugin-prettier",
            "@npm//eslint-plugin-sonarjs",
            "@npm//eslint-plugin-tsdoc",
            "@npm//jest",
            "@npm//prettier",
            "@npm//ts-jest",
            "//packages/libraries/eslint-config",
            "//packages/libraries/prettier-config",
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
