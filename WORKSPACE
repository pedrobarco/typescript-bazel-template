workspace(
    name = "typescript-bazel-template",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

RULES_PKG_TAG = "0.7.0"

RULES_PKG_SHA = "8a298e832762eda1830597d64fe7db58178aa84cd5926d76d5b744d6558941c2"

RULES_PYTHON_TAG = "0.10.2"

RULES_PYTHON_SHA = "a3a6e99f497be089f81ec082882e40246bfd435f52f4e82f37e89449b04573f6"

RULES_JS_TAG = "1.3.1"

RULES_JS_SHA = "0707a425093704fab05fb91c3a4b62cf22dca18ea334d8a72f156d4c18e8db90"

RULES_TS_TAG = "1.0.0-rc2"

RULES_TS_SHA = "b491ff46f8d9167986033552bdd7b39106fac5a1cbc4d5ea44582d3d71557519"

RULES_JEST_TAG = "0.10.0"

RULES_JEST_SHA = "bb3226707f9872185865a6381eb3a19311ca7b46e8ed475aad50975906a6cb6a"

RULES_GO_TAG = "0.34.0"

RULES_GO_SHA = "16e9fca53ed6bd4ff4ad76facc9b7b651a89db1689a2877d6fd7b82aa824e366"

RULES_DOCKER_TAG = "0.25.0"

RULES_DOCKER_SHA = "b1e80761a8a8243d03ebca8845e9cc1ba6c82ce7c5179ce2b295cd36f7e394bf"

http_archive(
    name = "rules_pkg",
    sha256 = RULES_PKG_SHA,
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_pkg/releases/download/%s/rules_pkg-%s.tar.gz" % (RULES_PKG_TAG, RULES_PKG_TAG),
        "https://github.com/bazelbuild/rules_pkg/releases/download/%s/rules_pkg-%s.tar.gz" % (RULES_PKG_TAG, RULES_PKG_TAG),
    ],
)

http_archive(
    name = "rules_python",
    sha256 = RULES_PYTHON_SHA,
    strip_prefix = "rules_python-%s" % RULES_PYTHON_TAG,
    url = "https://github.com/bazelbuild/rules_python/archive/refs/tags/%s.tar.gz" % RULES_PYTHON_TAG,
)

http_archive(
    name = "aspect_rules_js",
    sha256 = RULES_JS_SHA,
    strip_prefix = "rules_js-%s" % RULES_JS_TAG,
    url = "https://github.com/aspect-build/rules_js/archive/refs/tags/v%s.tar.gz" % RULES_JS_TAG,
)

http_archive(
    name = "aspect_rules_ts",
    sha256 = RULES_TS_SHA,
    strip_prefix = "rules_ts-%s" % RULES_TS_TAG,
    url = "https://github.com/aspect-build/rules_ts/archive/refs/tags/v%s.tar.gz" % RULES_TS_TAG,
)

http_archive(
    name = "aspect_rules_jest",
    sha256 = RULES_JEST_SHA,
    strip_prefix = "rules_jest-%s" % RULES_JEST_TAG,
    url = "https://github.com/aspect-build/rules_jest/archive/refs/tags/v%s.tar.gz" % RULES_JEST_TAG,
)

http_archive(
    name = "io_bazel_rules_go",
    sha256 = RULES_GO_SHA,
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v%s/rules_go-v%s.zip" % (RULES_GO_TAG, RULES_GO_TAG),
        "https://github.com/bazelbuild/rules_go/releases/download/v%s/rules_go-v%s.zip" % (RULES_GO_TAG, RULES_GO_TAG),
    ],
)

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = RULES_DOCKER_SHA,
    url = "https://github.com/bazelbuild/rules_docker/releases/download/v%s/rules_docker-v%s.tar.gz" % (RULES_DOCKER_TAG, RULES_DOCKER_TAG),
)

load("@rules_pkg//:deps.bzl", "rules_pkg_dependencies")

rules_pkg_dependencies()

load("@io_bazel_rules_go//go:deps.bzl", "go_register_toolchains", "go_rules_dependencies")

go_rules_dependencies()

go_register_toolchains(version = "1.18")

load("@aspect_rules_js//js:repositories.bzl", "rules_js_dependencies")

rules_js_dependencies()

load("@aspect_rules_ts//ts:repositories.bzl", "rules_ts_dependencies", TS_LATEST_VERSION = "LATEST_VERSION")

rules_ts_dependencies(ts_version = TS_LATEST_VERSION)

load("@aspect_rules_jest//jest:dependencies.bzl", "rules_jest_dependencies")

rules_jest_dependencies()

load("@aspect_rules_jest//jest:repositories.bzl", "jest_repositories", JEST_LATEST_VERSION = "LATEST_VERSION")

jest_repositories(
    name = "jest",
    jest_version = JEST_LATEST_VERSION,
)

load("@rules_nodejs//nodejs:repositories.bzl", "nodejs_register_toolchains")

nodejs_register_toolchains(
    name = "nodejs",
    node_version = "16.16.0",
)

load("@aspect_rules_js//npm:npm_import.bzl", "npm_translate_lock")

npm_translate_lock(
    name = "npm",
    pnpm_lock = "//:pnpm-lock.yaml",
    verify_node_modules_ignored = "//:.bazelignore",
)

load("@npm//:repositories.bzl", "npm_repositories")

npm_repositories()

load("@io_bazel_rules_docker//repositories:repositories.bzl", rules_docker_repositories = "repositories")

rules_docker_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", rules_docker_deps = "deps")

rules_docker_deps()

load("@io_bazel_rules_docker//container:container.bzl", "container_pull")

container_pull(
    name = "debian_arm64",
    architecture = "arm64",
    digest = "sha256:bd276cb1059f6502e342d3052a4c2767f2b3a0196508f5c2c34ce6da4a15b104",
    registry = "docker.io",
    repository = "debian",
)

container_pull(
    name = "debian_amd64",
    architecture = "amd64",
    digest = "sha256:9a67b70d0ba1d7c7690f917eedd8d24974dd8fd493205368b1e555a90c954208",
    registry = "docker.io",
    repository = "debian",
)
