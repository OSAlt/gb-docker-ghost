#!/usr/bin/env bash
# Use bash if no command is specified version
if [ $# -lt 1 ]
then
  echo "Usage: `basename $0` version"
  echo -e "\nUpdate ghost to version specified"
  exit 0
else
  version=$1
  shift
fi

sed -i '' -e "s/ghost:.*/ghost:${version}/" Dockerfile
sed -i '' -e "s/gb-ghost:.*/gb-ghost:${version}/" production.yml
sed -i '' -e "s/gb-ghost:.*/gb-ghost:${version}/" development.yml
git commit -a -m "Updating ghost to version ${version}"
git tag ${version}
