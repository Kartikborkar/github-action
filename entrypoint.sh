#!/bin/sh -l

CODE_INSPECTOR_BIN="/usr/bin/code-inspector-github-action"

MIN_QUALITY_GRADE=$1
MIN_QUALITY_SCORE=$2
MAX_DEFECTS_RATE=$3
MAX_COMPLEX_FUNCTIONS_RATE=$4
MAX_LONG_FUNCTIONS_RATE=$5
PROJECT_NAME=$6
MAX_TIMEOUT_SEC=$7
FORCE_BRANCH=$8


echo "Code Inspector GitHub action"
echo "Running with this parameters"
echo "~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
echo "MIN_QUALITY_GRADE:          ${MIN_QUALITY_GRADE}"
echo "MIN_QUALITY_SCORE:          ${MIN_QUALITY_SCORE}"
echo "MAX_DEFECTS_RATE:           ${MAX_DEFECTS_RATE}"
echo "MAX_COMPLEX_FUNCTIONS_RATE: ${MAX_COMPLEX_FUNCTIONS_RATE}"
echo "MAX_LONG_FUNCTIONS_RATE:    ${MAX_LONG_FUNCTIONS_RATE}"
echo "PROJECT_NAME:               ${PROJECT_NAME}"
echo "MAX_TIMEOUT_SEC:            ${MAX_TIMEOUT_SEC}"

echo "INPUT_CODE_INSPECTOR_API_TOKEN:            ${INPUT_CODE_INSPECTOR_API_TOKEN}"
echo "INPUT_CODE_INSPECTOR_ACCESS_KEY:            ${INPUT_CODE_INSPECTOR_ACCESS_KEY}"
echo "INPUT_CODE_INSPECTOR_SECRET_KEY:            ${INPUT_CODE_INSPECTOR_SECRET_KEY}"

if [ "$INPUT_CODE_INSPECTOR_API_TOKEN" != "" ]; then
  export CODE_INSPECTOR_API_TOKEN=${INPUT_CODE_INSPECTOR_API_TOKEN}
fi

if [ "$INPUT_CODE_INSPECTOR_ACCESS_KEY" != "" ] && [ "$INPUT_CODE_INSPECTOR_SECRET_KEY" != "" ]; then
  export CODE_INSPECTOR_ACCESS_KEY=${INPUT_CODE_INSPECTOR_ACCESS_KEY}
  export CODE_INSPECTOR_SECRET_KEY=${INPUT_CODE_INSPECTOR_SECRET_KEY}
fi


# By default, use the GitHub ref
REF_TO_CHECK=${GITHUB_REF}
SHA_TO_CHECK=${GITHUB_SHA}

# If the branch is forced, we do not specify a SHA and force the branch
if [ "$FORCE_BRANCH" != "none" ] && [ "$FORCE_BRANCH" != "none" ]; then
  REF_TO_CHECK=$FORCE_BRANCH
  SHA_TO_CHECK="none"
fi

${CODE_INSPECTOR_BIN} \
  --token "${INPUT_REPO_TOKEN}" \
  --actor "${GITHUB_ACTOR}" \
  --repository "${GITHUB_REPOSITORY}" \
  --sha "${SHA_TO_CHECK}" \
  --ref "${REF_TO_CHECK}" \
  --project "${PROJECT_NAME}" \
  --min-quality-score "${MIN_QUALITY_SCORE}" \
  --min-quality-grade "${MIN_QUALITY_GRADE}" \
  --max-defects-rate "${MAX_DEFECTS_RATE}" \
  --max-complex-functions-rate "${MAX_COMPLEX_FUNCTIONS_RATE}" \
  --max-long-functions-rate "${MAX_LONG_FUNCTIONS_RATE}" \
  --max-timeout-sec "${MAX_TIMEOUT_SEC}" \

exit $?