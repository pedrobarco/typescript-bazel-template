workspace(
    name = "typescript-bazel-template",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

RULES_NODEJS_TAG = "5.4.0"

RULES_NODEJS_SHA = "2b2004784358655f334925e7eadc7ba80f701144363df949b3293e1ae7a2fb7b"

http_archive(
    name = "build_bazel_rules_nodejs",
    sha256 = RULES_NODEJS_SHA,
    url = "https://github.com/bazelbuild/rules_nodejs/releases/download/%s/rules_nodejs-%s.tar.gz" % (RULES_NODEJS_TAG, RULES_NODEJS_TAG),
)

RULES_DOCKER_TAG = "0.24.0"

RULES_DOCKER_SHA = "27d53c1d646fc9537a70427ad7b034734d08a9c38924cc6357cc973fed300820"

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = RULES_DOCKER_SHA,
    strip_prefix = "rules_docker-%s" % RULES_DOCKER_TAG,
    url = "https://github.com/bazelbuild/rules_docker/releases/download/v%s/rules_docker-v%s.tar.gz" % (RULES_DOCKER_TAG, RULES_DOCKER_TAG),
)

load("@build_bazel_rules_nodejs//:repositories.bzl", "build_bazel_rules_nodejs_dependencies")

build_bazel_rules_nodejs_dependencies()

load("@rules_nodejs//nodejs:repositories.bzl", "nodejs_register_toolchains")

nodejs_register_toolchains(
    name = "nodejs",
    node_version = "16.14.2",
)

load("@rules_nodejs//nodejs:yarn_repositories.bzl", "yarn_repositories")

yarn_repositories(
    name = "yarn",
)

# The yarn_install rule runs yarn anytime the package.json or yarn.lock file changes.
# It also extracts and installs any Bazel rules distributed in an npm package.
load("@build_bazel_rules_nodejs//:index.bzl", "yarn_install")

yarn_install(
    # Name this npm so that Bazel Label references look like @npm//package
    name = "npm",
    package_json = "//:package.json",
    yarn_lock = "//:yarn.lock",
)

load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")

container_repositories()

load("@io_bazel_rules_docker//nodejs:image.bzl", _nodejs_image_repos = "repositories")

_nodejs_image_repos()
