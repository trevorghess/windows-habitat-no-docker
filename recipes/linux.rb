#
# Cookbook:: windows-habitat-no-docker
# Recipe:: linux
#
# Copyright:: 2018, The Authors, All Rights Reserved.

remote_file '/tmp/habitat-install.sh' do
  source 'https://raw.githubusercontent.com/habitat-sh/habitat/master/components/hab/install.sh'
  mode '0755'
end

file '/tmp/habitat-install.sh' do
  mode '0755'
end

execute '/tmp/habitat-install.sh'

execute 'habitat build' do
  cwd '/tmp/package'
  command 'hab pkg build ./'
end
