#!/bin/bash

TRIGGER_BUILD=false

if [ -z "$WERCKER_MONOREPO_TRIGGER_PACKAGE" ]; then
  info "No package name provided."
  TRIGGER_BUILD=true
elif [ "$(git --no-pager diff --name-only HEAD~1 HEAD "$WERCKER_MONOREPO_TRIGGER_PACKAGE" | wc -c)" -ne 0 ]; then
  info "Changed detected in package $WERCKER_MONOREPO_TRIGGER_PACKAGE."
  TRIGGER_BUILD=true
fi

if [ "$TRIGGER_BUILD" = "true" ]; then
  REQ_ENDPOINT="https://app.wercker.com/api/v3/runs/"

  REQ_JSON="{\
  \"pipelineId\": \"$WERCKER_MONOREPO_TRIGGER_PIPELINE\", \
  \"sourceRunId\": \"$WERCKER_RUN_ID\", \
  \"branch\": \"$WERCKER_GIT_BRANCH\", \
  \"commitHash\": \"$WERCKER_GIT_COMMIT\"}"

  info "Initiating build"

  if ! curl --fail --write-out "\n\nStatus code: %{http_code}\n" \
    -H "Content-type: application/json" -H "Authorization: Bearer $WERCKER_MONOREPO_TRIGGER_TOKEN" \
    "$REQ_ENDPOINT" -d "$REQ_JSON"; then
    fail "$WBTC_TRIGGER_RESPONSE"
  fi

  success "\nBuild triggered successfully."
fi
