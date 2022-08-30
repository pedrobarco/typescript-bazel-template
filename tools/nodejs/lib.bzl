"""
lib macros
"""

load("@aspect_rules_js//js:defs.bzl", "js_library")
load("@aspect_rules_js//npm:defs.bzl", "npm_package")

def lib(main = "src/index.js", srcs = [], **kwargs):
    name = native.package_name().split("/")[-1]
    package_name = "@usrbinboat/%s" % name

    native.genrule(
        name = "manifest",
        outs = ["package.json"],
        cmd = """
cat << EOF > $@
{
  "name": "%s",
  "main": "%s"
}
EOF
""" % (package_name, main),
    )

    js_library(
        name = "lib",
        srcs = srcs + [":manifest"],
        visibility = ["//visibility:public"],
        **kwargs
    )

    npm_package(
        name = name,
        srcs = [":lib"],
        package = package_name,
        visibility = ["//visibility:public"],
    )
