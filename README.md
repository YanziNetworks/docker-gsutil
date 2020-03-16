# gsutil

This is a minimal Docker image for running [gsutil] from Docker. For this to
work, you would ideally create a `.boto` configuration file in the container and
arrange for the file to access the secret key of a service account.

  [gsutil]: https://cloud.google.com/storage/docs/gsutil

The version of `gsutil` to incorporate can be changed at build time by setting
the build argument called `GSUTIL_VERSION` to the [release] number (sans the
leading `v`).

  [release]: https://github.com/GoogleCloudPlatform/gsutil/releases

## Service Account Configuration

To arrange for proper authorisation at Google, you should create a service
account and acquire a secret key for the account. You would then arrange for
modify the following template and place this at `/root/.boto` in the container.

```TOML
[Credentials]

# Google OAuth2 service account credentials (for "gs://" URIs):
gs_service_key_file = <FULL PATH TO JSON KEY FILE>

[Boto]

# Set 'https_validate_certificates' to False to disable server certificate
# checking. The default for this option in the boto library is currently
# 'False' (to avoid breaking apps that depend on invalid certificates); it is
# therefore strongly recommended to always set this option explicitly to True
# in configuration files, to protect against "man-in-the-middle" attacks.
https_validate_certificates = True

[GSUtil]

# 'content_language' specifies the ISO 639-1 language code of the content, to be
# passed in the Content-Language header. By default no Content-Language is sent.
# See the ISO 639-1 column of
# http://www.loc.gov/standards/iso639-2/php/code_list.php for a list of
# language codes.
content_language = en

# 'default_api_version' specifies the default Google Cloud Storage XML API
# version to use. If not set below gsutil defaults to API version 1.
default_api_version = 2

# 'default_project_id' specifies the default Google Cloud Storage project ID to
# use with the 'mb' and 'ls' commands. This default can be overridden by
# specifying the -p option to the 'mb' and 'ls' commands.
default_project_id = <THE STRING ID OF YOUR PROJECT>
```

## Release Tempo

The intention for this repository is to follow the [release] tempo for the
official [gsutil] project. The project will typically pick the latest stable
[Alpine] image at release time. Generated images are automatically
[tagged][tags] with the same version number as the [gsutil] [release] number,
sans the leading `v`.

Missing a release? Open a [PR]!

Releases will be done through creating (git) tags with the same value as the one
in the `GSUTIL_VERSION` build argument of the [Dockerfile]

  [Alpine]: https://hub.docker.com/_/alpine
  [tags]: https://hub.docker.com/r/yanzinetworks/gsutil/tags
  [PR]: https://github.com/YanziNetworks/docker-gsutil/pulls
  [Dockerfile]: ./Dockerfile