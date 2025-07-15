#!/bin/bash

for release in 7.1.{0..3}; do
  release_tsv="scripts/release-$release.tsv"
  chart_image_file="scripts/chart-images-$release.txt"
  bkpkg_release="scripts/$release.txt"
  gawk -f scripts/chart-appversion.awk "$chart_image_file" > "$release_tsv"
  awk -F"\t" '$4~/^[0-9][0-9.]+(-[a-z0-9.-]+)?/{
    name=$1;version=$4
    sub(/^gsec$/, "gse_agent", name)
    sub(/^gsep$/, "gse_proxy", name)
    print name"\t"version"\t--"
    }' "$bkpkg_release" >> "$release_tsv"
done
