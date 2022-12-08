# umd-lib-aspace-theme

ArchivesSpace plugin for UMD Libraries theme elements

## Environment Banner

Per the SSDR policy specified in https://confluence.umd.edu/display/LIB/Create+Environment+Banners
an environment banner should be shown on all non-production systems.

The display of the environment banner is handled by the
UMDLibEnvironmentBannerHelper module, which uses one of two mechanisms to
determine the banner to display:

* Environment variables
* Hostname/Rails environment

The environment variables, if specified, take precedence over the hostname
banner.

### Environment variables

The text and color of the banner can be controlled by the following environment
variables:

* ENVIRONMENT_BANNER - The text to display
* ENVIRONMENT_BANNER_BACKGROUND - The background color of the banner, expressed
as a CSS color (i.e., "#ff0000" for red).
* ENVIRONMENT_BANNER_FOREGROUND - The foreground (text) color of the banner,
expressed as a CSS color (i.e., "#ff0000" for red).
* ENVIRONMENT_BANNER_ENABLED - optional parameter. If set to "false" the banner
will not be displayed.

## Hostname/Rails environment

Determines the banner to display based on the hostname or Rails environment.

Sets the banner to the following environments:

* Local - if hostname matches "local" or Rails.env.development?, or
Rails.env.vagrant? return true
* Development - if hostname matches "dev"
* Staging - if hostname matches "stage"

A hostname matches if the first segment of the hostname ends with the given
string, i.e. "foo-dev.example.com", "foo-dev", and "dev" all match for
"Development".

## Running the Tests

The ArchivesSpace plugin test runner can be used to run the tests:

```bash
$ build/run frontend:test:plugin
```
