#!/bin/sh
set -e;

function hsl_to_hex_string() {
  local hex_string=$(pastel format hex "hsl(${1}, ${2}%, ${3}%)");

  echo ${hex_string};
}

function rgb_to_hex_string() {
  local hex_string=$(pastel format hex "rgb(${1}, ${2}, ${3})");

  echo ${hex_string};
}

function gray_to_hex_string() {
  echo $(rgb_to_hex_string $1 $1 $1);
}
