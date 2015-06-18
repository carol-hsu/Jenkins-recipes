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

#bash 'install github plugin' do
#	user 'jenkins'
#	code <<-EOH
#	cd /var/lib/jenkins/plugins
#	wget http://updates.jenkins-ci.org/download/plugins/github-api/1.68/github-api.hpi
#	wget http://updates.jenkins-ci.org/download/plugins/git-client/1.17.1/git-client.hpi
#	wget http://updates.jenkins-ci.org/download/plugins/git/2.3.5/git.hpi
#	wget http://updates.jenkins-ci.org/download/plugins/github/1.11.3/github.hpi
#	EOH
#	notifies :restart, 'service[Jenkins]'
#end


