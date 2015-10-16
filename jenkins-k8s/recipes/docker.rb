package "docker" do
	action :install
end

package "bridge-utils" do
  action :install
end


service "docker" do
	action :disable
end

template "/etc/sysconfig/docker" do
    mode "0644"
    owner "root"
    source "docker.erb"
end

template "/etc/cron.daily/docker-clean.cron" do
	mode "0755"
	owner "root"
	source "docker-clean.cron.elb"
end
