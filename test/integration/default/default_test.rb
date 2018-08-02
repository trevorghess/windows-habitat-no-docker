# # encoding: utf-8

# Inspec test for recipe windows-habitat-no-docker::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe chocolatey_package('habitat') do
  it { should be_installed }
  its('version') { should eq '-.59.0/20180712120048' }
end
