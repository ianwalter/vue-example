workflow "CI" {
  on = "push"
  resolves = ["Build", "Lint"]
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
