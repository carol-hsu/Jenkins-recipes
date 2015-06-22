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

#grant user permission to jenkins
bash 'add-public-key' do
	user 'root'
	code <<-EOH
	cat /home/ec2-user/.ssh/authorized_keys >> /home/jenkins/.ssh/authorized_keys
	chmod 600 /home/jenkins/.ssh/authorized_keys
	chown jenkins /home/jenkins/.ssh/authorized_keys
	chgrp jenkins /home/jenkins/.ssh/authorized_keys
	echo "jenkins  ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoer
	EOH
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
	curl -O -sSL https://get.docker.com/rpm/1.7.0/centos-6/RPMS/x86_64/docker-engine-1.7.0-1.el6.x86_64.rpm
	yum -y localinstall --nogpgcheck docker-engine-1.7.0-1.el6.x86_64.rpm
	service docker start
	usermod -aG docker jenkins
	echo "# /etc/sysconfig/docker" > /etc/sysconfig/docker
	echo 'other_args="--insecure-registry dcsrd-docker-registry.trendmicro.com"' >> /etc/sysconfig/docker
	service docker restart
	EOH
end


Chef::Log.info("***************** Jenkins slave setup finished **************")
