#
# Cookbook:: windows-habitat-no-docker
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'chocolatey::default'

%w( habitat ).each do |pkg|
  chocolatey_package pkg do
    action :install
  end
end

powershell_script 'habitat build' do
  cwd '/tmp/package/habitat'
  code <<-EOH
  $env:PATH += ";C:\habitat"
  hab pkg build --windows
  EOH
end
