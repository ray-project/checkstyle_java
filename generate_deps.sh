#!/usr/bin/env bash

bazel run //:bazel_deps -- generate -r `pwd` -s third_party/workspace.bzl -d dependencies.yaml
