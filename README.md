# gsutil

This is a minimal Docker image for running [gsutil] from Docker. For this to
work, you would ideally create a `.boto` configuration file in the home
directory of the `gsutil` user, i.e. in `/home/gsutil` in the container and
arrange for the file to access the secret key of a service account.

  [gsutil]: https://cloud.google.com/storage/docs/gsutil

The version of `gsutil` to incorporate can be changed at build time by setting
the build argument called `GSUTIL_VERSION` to the [release] number (sans the
leading `v`).

  [release]: https://github.com/GoogleCloudPlatform/gsutil/releases
