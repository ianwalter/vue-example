workflow "CI" {
  on = "push"
  resolves = ["Build", "Lint", "Bundlewatch"]
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
  needs = ["Install"]
  runs = "yarn"
  args = "bundlewatch"
}
