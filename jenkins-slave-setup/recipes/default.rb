user 'jenkins' do
    home '/home/jenkins'
    shell '/bin/bash'
    action :create
end

directory '/home/jenkins' do
    owner 'jenkins'
    group 'jenkins'
end

directory '/home/jenkins/.ssh' do
	owner 'jenkins'
	group 'jenkins'
	mode '0700'
end

bash 'install-ant' do
	user 'root'
	code <<-EOH
	yum -y update
	yum -y install java
	yum -y install ant
	EOH
end

#install docker
bash 'install-docker' do
	user 'root'
	code <<-EOH
	yum -y install docker
	service docker start
	usermod -aG docker jenkins
	echo "# /etc/sysconfig/docker" > /etc/sysconfig/docker
	echo 'other_args="--insecure-registry dcsrd-docker-registry.trendmicro.com"' >> /etc/sysconfig/docker
	service docker restart
	EOH
end

Chef::Log.info("***************** Jenkins slave setup finished **************")
