workspace(
    name = "typescript-bazel-template",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

RULES_JS_TAG = "1.20.1"

RULES_JS_SHA = "1aa0ab76d1f9520bb8993e2d84f82da2a9c87da1e6e8d121dbb4c857a292c2cd"

RULES_TS_TAG = "1.3.0"

RULES_TS_SHA = "db77d904284d21121ae63dbaaadfd8c75ff6d21ad229f92038b415c1ad5019cc"

RULES_JEST_TAG = "0.16.1"

RULES_JEST_SHA = "fa103b278137738ef08fd23d3c8c9157897a7159af2aa22714bc71680da58583"

RULES_DOCKER_TAG = "0.25.0"

RULES_DOCKER_SHA = "b1e80761a8a8243d03ebca8845e9cc1ba6c82ce7c5179ce2b295cd36f7e394bf"

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
    name = "io_bazel_rules_docker",
    sha256 = RULES_DOCKER_SHA,
    url = "https://github.com/bazelbuild/rules_docker/releases/download/v%s/rules_docker-v%s.tar.gz" % (RULES_DOCKER_TAG, RULES_DOCKER_TAG),
)

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

load("@jest//:npm_repositories.bzl", jest_npm_repositories = "npm_repositories")

jest_npm_repositories()

load("@rules_nodejs//nodejs:repositories.bzl", "DEFAULT_NODE_VERSION", "nodejs_register_toolchains")

nodejs_register_toolchains(
    name = "nodejs",
    node_version = DEFAULT_NODE_VERSION,
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
