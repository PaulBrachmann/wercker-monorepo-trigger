# Monorepo Trigger

A wercker step to trigger the build of a package (sub directory) in a monorepo if it has changed in the last commit.

Prerequisites:

- Create a personal API access token for wercker
- Install git support (if not present already) into your wercker pipeline's box

Example:

    build:
      steps:
        - paulbrachmann/monorepo-trigger:
          package: "ui"
          pipeline: $WERCKER_PIPELINE_ID
          token: $WERCKER_API_TOKEN
