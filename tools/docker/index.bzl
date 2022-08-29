"""
custom docker rules
"""

load("//tools/docker:js_image_layer.bzl", _js_image_layer = "js_image_layer")

js_image_layer = _js_image_layer
