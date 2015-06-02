remote_file '/etc/yum.repos.d/jenkins.repo' do
	source 'http://pkg.jenkins-ci.org/redhat/jenkins.repo'
end

execute 'rpm-import' do 
	command 'rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key'
end

yum_package 'java'

yum_package 'jenkins'
