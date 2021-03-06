#!/usr/bin/env bats

source "$BATS_TEST_DIRNAME/../modules/bash-commons/src/array.sh"
load "test-helper"

@test "array_contains on empty array" {
  run array_contains "foo"
  assert_failure
}

@test "array_contains on array of length 1 for non matching item" {
  run array_contains "foo" "bar"
  assert_failure
}

@test "array_contains on array of length 1 for matching item" {
  run array_contains "foo" "foo"
  assert_success
}

@test "array_contains on array of length 3 for non matching item" {
  run array_contains "foo" "bar" "baz" "blah"
  assert_failure
}

@test "array_contains on array of length 3 for matching item" {
  run array_contains "foo" "bar" "foo" "blah"
  assert_success
}

@test "array_contains on array of length 3 for multiple matches" {
  run array_contains "foo" "bar" "foo" "foo"
  assert_success
}

@test "array_contains on array of length 3 with spaces in array values" {
  run array_contains "foo" "foo bar" "baz blah"
  assert_failure
}

@test "array_join on empty array" {
  run array_join ","
  assert_success
  assert_output ""
}

@test "array_join on array of length 1" {
  run array_join "," "foo"
  assert_success
  assert_output "foo"
}

@test "array_join on array of length 3" {
  run array_join "," "foo" "bar" "baz"
  assert_success
  assert_output "foo,bar,baz"
}

@test "array_join on array of length 3 with multi character separator" {
  run array_join " == " "foo" "bar" "baz"
  assert_success
  assert_output "foo == bar == baz"
}