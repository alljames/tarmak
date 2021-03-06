define prometheus::wget_file(
  String $url,
  String $destination_dir,
  String $destination_file = '',
  String $user = 'root',
  String $umask = '022',
)
{

  ensure_packages([ 'wget' ])

  if "x${destination_file}x" == 'xx' {
    $filename = regsubst($url, '^http.*\/([^\/]+)$', '\1')
  } else {
    $filename = $destination_file
  }

  exec { "download-${filename}":
    command => "/usr/bin/wget -O ${filename} ${url}",
    cwd     => $destination_dir,
    creates => "${destination_dir}/${filename}",
    user    => $user,
    umask   => $umask,
    require => Package['wget'],
    }
}
