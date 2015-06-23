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
