"""
app macros
"""

load("@build_bazel_rules_nodejs//:index.bzl", "nodejs_binary")
load("@io_bazel_rules_docker//nodejs:image.bzl", "nodejs_image")
load("@io_bazel_rules_docker//container:container.bzl", "container_push")
load("//tools/nodejs:ts_project.bzl", "ts_project")

def api(
        srcs = None,
        data = None,
        deps = []):
    """Builds an API project (ts_project + nodejs_image)

    Args:
        srcs: Source files to build the typescript project
        data: Files needed at runtime by binaries or tests that transitively
        depend on this target.
        deps: List of labels of other rules that produce TypeScript typings.
    """
    name = native.package_name().split("/")[-1]
    data = data if data else native.glob(["**/*.graphql", ".env*"])

    ts_project(
        srcs = srcs,
        data = data,
        deps = deps,
    )

    nodejs_binary(
        name = name,
        data = [":tsconfig"],
        entry_point = ":src/index.ts",
        chdir = native.package_name(),
    )

    nodejs_binary(
        name = "bin",
        data = [":tsconfig"],
        entry_point = ":src/index.ts",
        env = {
            "NODE_ENV": "production",
        },
        visibility = [":__subpackages__"],
    )

    nodejs_image(
        name = "image",
        binary = "bin",
        include_node_repo_args = False,
        node_repository_name = "nodejs_linux_amd64",
    )

    container_push(
        name = "push",
        format = "Docker",
        image = ":image",
        registry = "registry.tools.cosmic.sky",
        repository = "olisipo/test/%s" % name,
        tag = "{version}",
    )
