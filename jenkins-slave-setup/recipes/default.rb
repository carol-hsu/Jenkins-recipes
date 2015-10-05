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

#add jenkins public key in user "jenkins"'s authorized file
file '/home/jenkins/.ssh/authorized_keys' do
	owner 'jenkins'
    group 'jenkins'
    mode '0600'
    content "#{slave-pubkey}"
    action :create
end

#grant user permission to jenkins
bash 'add-public-key' do
	user 'root'
	code <<-EOH
	cat /home/ec2-user/.ssh/authorized_keys >> /home/jenkins/.ssh/authorized_keys
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
	yum -y install docker
	service docker start
	usermod -aG docker jenkins
	echo "# /etc/sysconfig/docker" > /etc/sysconfig/docker
	echo 'other_args="--insecure-registry dcsrd-docker-registry.trendmicro.com"' >> /etc/sysconfig/docker
	service docker restart
	EOH
end

#create dir
directory '/media/ephemeral0/jenkins' do
    owner 'jenkins'
    group 'jenkins'
    mode '0755'
    action :create
    recursive true
end

Chef::Log.info("***************** Jenkins slave setup finished **************")
