"""
custom nodejs rules
"""

load("//tools/nodejs:ts_project.bzl", _ts_project = "ts_project")
load("//tools/nodejs:jest.bzl", _jest = "jest", _jest_test = "jest_test")
load("//tools/nodejs:prettier.bzl", _prettier = "prettier")
load("//tools/nodejs:api.bzl", _api = "api")
load("//tools/nodejs:lib.bzl", _lib = "lib")

ts_project = _ts_project
jest = _jest
jest_test = _jest_test
prettier = _prettier
api = _api
lib = _lib
