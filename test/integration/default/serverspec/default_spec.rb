require 'spec_helper'

dockerize_app_name = 'products'
dockerize_app_version = '0.0.1'
dockerize_artifact = "#{dockerize_app_name}-#{dockerize_app_version}.tar.gz"
dockerize_tmp_dir = '/var/tmp/dockerize'
dockerize_build_dir = "#{dockerize_tmp_dir}/#{dockerize_app_name}"
dockerize_registry_domain = 'localhost:5000'

%W( #{dockerize_tmp_dir} #{dockerize_build_dir} ).each do |d|
  describe file(d) do
    it { should be_directory }
    it { should be_mode 755 }
  end
end

describe file("#{dockerize_tmp_dir}/#{dockerize_artifact}") do
  it { should be_file }
  it { should be_mode 644 }
end

describe file("#{dockerize_build_dir}/Dockerfile") do
  it { should be_file }
  it { should be_mode 644 }
end

describe docker_image("#{dockerize_registry_domain}/#{dockerize_app_name}:#{dockerize_app_version}") do
    it { should exist }
end

describe docker_image("#{dockerize_registry_domain}/#{dockerize_app_name}:latest") do
  it { should exist }
end

describe command("docker ps | grep #{dockerize_app_name} | wc -l") do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match '2' }
end
