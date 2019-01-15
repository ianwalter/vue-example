workflow "CI" {
  on = "push"
  resolves = ["Lint", "Bundlewatch"]
}

action "Install" {
  uses = "docker://node:11-alpine"
  runs = "yarn"
}

action "Build" {
  uses = "docker://node:11-alpine"
  needs = ["Install"]
  runs = "yarn"
  args = "build"
}

action "Lint" {
  uses = "docker://node:11-alpine"
  needs = ["Install"]
  runs = "yarn"
  args = "lint"
}

action "Bundlewatch" {
  uses = "docker://node:11-alpine"
  needs = ["Build"]
  runs = "yarn"
  args = "bundlewatch"
  secrets = ["GITHUB_TOKEN"]
  env = {
    BUNDLEWATCH_GITHUB_TOKEN = "${GITHUB_TOKEN}"
    CI_REPO_OWNER = "ianwalter"
    CI_REPO_NAME = "vue-example"
    CI_COMMIT_SHA = "${GITHUB_SHA}"
    CI_BRANCH = "${GITHUB_REF}"
  }
}
