user 'jenkins' do
    home '/home/jenkins'
    shell '/bin/bash'
    password '$1$1BYPpnSk$UiWmVO9/J3lKf290/Oec4.'
    action :create
end

directory '/home/jenkins' do
    owner 'jenkins'
    group 'jenkins'
end

remote_file '/etc/yum.repos.d/jenkins.repo' do
	source 'http://pkg.jenkins-ci.org/redhat/jenkins.repo'
end

execute 'rpm-import' do 
	command 'rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key'
end

bash 'update and install' do
	user 'root'
	code <<-EOH
	yum -y update
	yum -y install java
	yum -y install jenkins
	chkconfig jenkins --level 35 on
	EOH
	notifies :start, 'service[Jenkins]'
end

service 'Jenkins' do
	service_name 'jenkins'
	supports :restart => true, :reload => true, :status => true, :start => true
	action :nothing
end

execute 'create-sshkey' do
    user 'jenkins'
    cwd '/home/jenkins'
    command "mkdir .ssh && ssh-keygen -f .ssh/id_rsa -t rsa -N ''"
end
