#
# Cookbook:: windows-habitat-no-docker
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

include_recipe 'chocolatey::default'

%w( habitat git googlechrome vscode ).each do |pkg|
  chocolatey_package pkg do
    action :install
  end
end
