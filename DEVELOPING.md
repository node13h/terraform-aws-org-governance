## Setting up a local development environment

Setup instructions should work for both Docker (tested on a Mac with Docker Desktop)
and (rootless) Podman.

### Install prerequisites

- [gitlab-ci-local](https://github.com/firecow/gitlab-ci-local).
- Podman or Docker
- GNU Make
- `qemu-user-static` to enable cros-platform builds.

## Running builds locally

Run `make pipeline` to run the pipeline defined in [.gitlab-ci.yml](.gitlab-ci.yml).

See [Makefile](Makefile) for more details.

## Releasing

- Remove the pre-release version identifier in [VERSION](VERSION).
- Create an annotated (to track the release date) Git tag using `vX.Y.Z` format.
  `X.Y.Z` must match the version in [VERSION](VERSION).
- Push the tag.
- Ensure the Git working tree is clean.
- Run `make tag-pipeline`.
- Increment the version number in [VERSION](VERSION) adding the `-0`
  identifier, and commit the change.

## Updating Terraform lock file for the test configuration

Run `make upgrade-test-lock` to update [test/.terraform.lock.hcl](test/.terraform.lock.hcl).
