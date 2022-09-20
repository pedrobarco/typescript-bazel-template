<div align="center">
  <a href="https://github.com/pedrobarco/typescript-bazel-template">
    <img width="100px" height="auto" src="https://blog.bazel.build/images/bazel-icon.svg" />
  </a>
  <br>
  <h1>Typescript + Bazel Template</h1>
  <p>
    Template monorepo for building typescript apps with <a href="https://bazel.build">Bazel</a>
  </p>
</div>

# Usage

Setup

- `bazel run -- @pnpm//:pnpm -C $PWD i` (Install required software and sets up project)
- `bazel run -- @pnpm//:pnpm -C $PWD outdated` (Check for outdated dependencies)

Development

- `bazel build //...` (Build all packages)
- `bazel test //...` (Test all packages)
- `bazel run //packages/server` (Start development backend service)
- `bazel run //packages/server:image` (Build server image)
- `docker run --rm -i -p 8080:8080 bazel/packages/server:image` (Run container image)
- `bazel test //packages/<package>` (Run tests)

Deployment (TBD)

# Codebase

**Services**

- [`server`](packages/server) **Typescript**, web application

**Libraries**

- [`@usrbinboat/core`](packages/core) **Typescript**, core operation class
- [`@usrbinboat/add`](packages/add) **Typescript**, add operation class

**Miscellaneous**

- [`@usrbinboat/eslint-config`](packages/eslint-config), tooling and configurations for eslint
- [`@usrbinboat/prettier-config`](packages/prettier-config), tooling and configurations for prettier
