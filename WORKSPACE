workspace(
    name = "typescript-bazel-template",
)

load("@bazel_tools//tools/build_defs/repo:http.bzl", "http_archive")

RULES_NODEJS_TAG = "5.5.2"

RULES_NODEJS_SHA = "c78216f5be5d451a42275b0b7dc809fb9347e2b04a68f68bad620a2b01f5c774"

RULES_JS_TAG = "1.1.0"

RULES_JS_SHA = "25bcb082d49616ac2da538bf7bdd33a9730c8884edbec787fec83db07e4f7f16"

RULES_TS_TAG = "1.0.0-rc2"

RULES_TS_SHA = "b491ff46f8d9167986033552bdd7b39106fac5a1cbc4d5ea44582d3d71557519"

RULES_JEST_TAG = "0.10.0"

RULES_JEST_SHA = "bb3226707f9872185865a6381eb3a19311ca7b46e8ed475aad50975906a6cb6a"

RULES_DOCKER_TAG = "0.25.0"

RULES_DOCKER_SHA = "b1e80761a8a8243d03ebca8845e9cc1ba6c82ce7c5179ce2b295cd36f7e394bf"

http_archive(
    name = "build_bazel_rules_nodejs",
    sha256 = RULES_NODEJS_SHA,
    url = "https://github.com/bazelbuild/rules_nodejs/releases/download/%s/rules_nodejs-%s.tar.gz" % (RULES_NODEJS_TAG, RULES_NODEJS_TAG),
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
    name = "io_bazel_rules_docker",
    sha256 = RULES_DOCKER_SHA,
    url = "https://github.com/bazelbuild/rules_docker/releases/download/v%s/rules_docker-v%s.tar.gz" % (RULES_DOCKER_TAG, RULES_DOCKER_TAG),
)

load("@build_bazel_rules_nodejs//:repositories.bzl", "build_bazel_rules_nodejs_dependencies")

build_bazel_rules_nodejs_dependencies()

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

load(
    "@io_bazel_rules_docker//repositories:repositories.bzl",
    container_repositories = "repositories",
)

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

load(
    "@io_bazel_rules_docker//nodejs:image.bzl",
    _nodejs_image_repos = "repositories",
)

_nodejs_image_repos()
