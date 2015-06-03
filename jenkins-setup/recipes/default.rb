remote_file '/etc/yum.repos.d/jenkins.repo' do
	source 'http://pkg.jenkins-ci.org/redhat/jenkins.repo'
end

execute 'rpm-import' do 
	command 'rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key'
end

execute 'update and install' do
	command 'yum -y update && yum -y install java-1.7.0-openjdk && yum -y install jenkins'
end
