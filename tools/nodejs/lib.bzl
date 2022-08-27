"""
lib macros
"""

load("@build_bazel_rules_nodejs//:index.bzl", "js_library")

def lib(main = "src/index.js", srcs = [], **kwargs):
    name = native.package_name().split("/")[-1]

    native.genrule(
        name = "manifest",
        outs = ["package.json"],
        cmd = """
cat << EOF > $@
{
  "name": "@lib/%s",
  "main": "%s"
}
EOF
""" % (name, main),
    )

    js_library(
        name = name,
        package_name = "@usrbinboat/%s" % name,
        visibility = ["//visibility:public"],
        srcs = srcs + [":manifest"],
        **kwargs
    )
