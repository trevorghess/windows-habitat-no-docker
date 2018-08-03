$pkg_name="vscode"
$pkg_origin="lauck"
$pkg_version="1.25.1"
$pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
$pkg_license=@("MIT")
$pkg_source="https://az764295.vo.msecnd.net/stable/1dfc5e557209371715f655691b1235b6b26a06be/VSCode-win32-x64-1.25.1.zip"
# $pkg_filename="$pkg_name-$pkg_version.zip"
# $pkg_deps=@()

# $pkg_lib_dirs=@("lib")
# $pkg_include_dirs=@("include")

# $pkg_svc_run="MyBinary.exe"
# $pkg_exports=@{
#   host="srv.address"
#   port="srv.port"
#   ssl-port="srv.ssl.port"
# }
# $pkg_exposes=@("port", "ssl-port")
# $pkg_binds=@{
#   database="port host"
# }
# $pkg_binds_optional=@{
#   storage="port host"
# }
# $pkg_description="Some description."
# $pkg_upstream_url="http://example.com/project-name"

$pkg_shasum="aa920ae1b7e8861dcf13a93077206e30de48ea245f0b30bd3ddbea496df16102"
$pkg_build_deps = @("core/7zip")
$pkg_bin_dirs=@("bin")

function Invoke-Unpack {
  Push-Location (Resolve-Path $HAB_CACHE_SRC_PATH).Path
  Try {
    7z x -y -o"$pkg_dirname" (Resolve-Path $HAB_CACHE_SRC_PATH/$pkg_filename).Path
  }
  Finally { Pop-Location }
}

function Invoke-Install {
  Copy-Item * "$pkg_prefix/bin" -Recurse -Force
}
