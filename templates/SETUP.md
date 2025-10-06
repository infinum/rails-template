# Post-apply instructions

To complete project setup from this template, complete the following steps:

## Required changes

- [ ] Update `README.md`
- [ ] Update infrastructure concerns in coordination with the DevOps team
    - [ ] Specify ECS task definitions (`/infra/ecs/*`)
    - [ ] Update ECS deployment configuration (`.github/workflows/deploy-*`).
    - [ ] Review [action triggers gotchas](#github-actions-triggers).
- [ ] Review and resolve `TODO` comments
- [ ] Delete the `SETUP.md` file

#### Github Actions trigger gotchas

You will likely enable automatic deployments using the [workflow_run](https://docs.github.com/en/actions/reference/workflows-and-actions/events-that-trigger-workflows#workflow_run) trigger when CI checks complete:

```yaml
on:
  workflow_run:
    workflows: [Build]
    types:
      - completed
```

**Be aware** that different triggers set `GITHUB_SHA` and `GITHUB_REF` values differently in the executing action. To prevent issues with incorrect code revision being checked out for the common `workflow_run` trigger a default way to determine the correct SHA to checkout is defined in `.github/workflows/deploy.yml` :

```yaml
jobs:
  context:
    name: Setup context
    outputs:
      git_revision: ${{ github.event.workflow_run.head_sha || github.sha }}
```

This value is then passed as an explicit `git_ref` to the build and deployment reusable actions.

Review the docs carefully for the triggers you have chosen and update accordingly.
