"""
api macros
"""

load("@io_bazel_rules_docker//container:container.bzl", "container_image")
load("@io_bazel_rules_docker//container:layer.bzl", "container_layer")
load("//tools/docker:index.bzl", "js_image_layer")
load("//tools/nodejs:ts_project.bzl", "ts_project")
load("@aspect_rules_js//js:defs.bzl", "js_binary")

def api(
        name = None,
        srcs = None,
        data = None,
        deps = []):
    """Builds an API project (ts_project + nodejs_image)

    Args:
        name: by convention, every public macro needs a "name" argument (even if it doesn't use it)
        srcs: source files to build the typescript project
        data: files needed at runtime by binaries or tests that transitively
        depend on this target.
        deps: list of labels of other rules that produce TypeScript typings.
    """
    package_name = native.package_name()
    name = package_name.split("/")[-1]
    data = data if data else native.glob(["**/*.graphql", ".env*"])

    ts_project(
        srcs = srcs,
        data = data,
        deps = deps,
    )

    js_binary(
        name = name,
        data = [":tsconfig"],
        entry_point = "src/index.js",
        chdir = native.package_name(),
    )

    js_binary(
        name = "bin",
        data = [":tsconfig"],
        entry_point = "src/index.js",
        env = {
            "NODE_ENV": "production",
        },
        visibility = [":__subpackages__"],
    )

    js_image_layer(
        name = "layers",
        binary = ":bin",
        root = "/app",
        tags = ["no-remote-exec"],
    )

    container_layer(
        name = "app_layer",
        tars = [":layers/app.tar"],
    )

    container_layer(
        name = "node_modules_layer",
        tars = [":layers/node_modules.tar"],
    )

    container_image(
        name = "image",
        base = "@debian_amd64//image",
        cmd = ["/app/%s/bin.sh" % package_name],
        entrypoint = ["bash"],
        layers = [
            ":app_layer",
            ":node_modules_layer",
        ],
    )
