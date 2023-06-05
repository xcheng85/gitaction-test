#!/bin/bash

VERSION=""

usage() { echo "Usage: $0 [-v <string>]" 1>&1; exit 1; }

# get input args v

while getopts ":v:" o; do
    case "${o}" in
        v)
            VERSION=${OPTARG}
            ;;
        *)
            usage
            ;;
    esac
done
shift $((OPTIND-1))

if [ -z "${VERSION}" ]; then
    usage
fi

echo "v = ${VERSION}"

#2>/dev/null is to hide errors produced by grep by redirect any diagnostic messages to /dev/null 

git fetch --prune --unshallow 2>/dev/null
CURRENT_VERSION=`git describe --abbrev=0 --tags 2>/dev/null`

if [[ $CURRENT_VERSION == '' ]]
then
    CURRENT_VERSION='v0.1.0'
fi

echo "CURRENT_VERSION: $CURRENT_VERSION"
# replace . with space
CURRENT_VERSION_PARTS=(${CURRENT_VERSION//./ })

MAJOR=${CURRENT_VERSION_PARTS[0]}
MINOR=${CURRENT_VERSION_PARTS[1]}
PATCH=${CURRENT_VERSION_PARTS[2]}

if [[ $VERSION == 'major' ]]
then
    MAJOR=v$((MAJOR+1))  # v0 -> v1
elif [[ $VERSION == 'minor' ]]
then
    MINOR=$((MINOR+1))
elif [[ $VERSION == 'patch' ]]
then
    PATCH=$((PATCH+1))
else
    echo "incorrect version type: -v major/minor/patch"
    exit 1
fi

NEWTAG="$MAJOR.$MINOR.$PATCH"
echo "($VERSION) updating $CURRENT_VERSION to $NEWTAG"

#  get current hash and see if it already has a tag
GIT_COMMIT=`git rev-parse HEAD`
NEEDS_TAG=`git describe --contains $GIT_COMMIT 2>/dev/null`

if [ -z "$NEEDS_TAG"];then
    echo "Tagged with $NEWTAG"
    git tag $NEWTAG
    git push --tags
    git push
else
    echo "Already a tag on this commit"
fi

# git action output
# output var: git-tag
echo ::set-output name=git-tag::$NEWTAG

exit 0