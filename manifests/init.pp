# Class to install and configure apache example.
#
# Use this module to install and configure apache example.
#
# @example Declaring the class
#   include ::example
#
# @param archive_source (String) Location of example binary release.
# @param group (String) Group that owns example files.
# @param install_dir (String) Location of example binary release.
# @param install_method (String) How to install example.
# @param manage_service (Boolean) Manage the example service.
# @param manage_user (Boolean) Manage example user and group.
# @param package_name (String) Name of package to install.
# @param package_version (String) Version of example to install.
# @param service_name (String) Name of service to manage.
# @param service_provider (String) init system that is used.
# @param user (String) user that owns example files.
class example (
  $archive_source   = $::example::params::archive_source,
  $group            = $::example::params::group,
  $install_dir      = $::example::params::install_dir,
  $install_method   = $::example::params::install_method,
  $manage_service   = $::example::params::manage_service,
  $manage_user      = $::example::params::manage_user,
  $package_name     = $::example::params::package_name,
  $package_version  = $::example::params::package_version,
  $service_name     = $::example::params::service_name,
  $service_provider = $::example::params::service_provider,
  $user             = $::example::params::user,
) inherits example::params {
  validate_bool(
    $manage_service,
    $manage_user,
  )
  if $install_method == 'archive' {
    validate_string(
      $archive_source
    )
  }
  validate_string(
    $group,
    $install_dir,
    $install_method,
    $package_name,
    $package_version,
    $service_name,
    $service_provider,
    $user,
  )

  anchor { 'example::begin': }
  -> class{ '::example::install': }
  -> class{ '::example::config': }
  ~> class{ '::example::service': }
  -> anchor { 'example::end': }
}
