# Monorepo Trigger

A wercker step to trigger the build of a package (sub directory) in a monorepo if it has changed in the last commit.

You will need to create a personal API access token for wercker.

Example:

    build:
      steps:
        - PaulBrachmann/monorepo-trigger:
          package: "ui"
          pipeline: $WERCKER_PIPELINE_ID
          token: $WERCKER_API_TOKEN
