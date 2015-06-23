service 'Jenkins' do
	service_name 'jenkins'
	supports :restart => true, :reload => true, :status => true, :start => true
	action :nothing
end

bash 'install github plugin' do
	user 'jenkins'
	code <<-EOH
	cd /var/lib/jenkins/plugins
	wget http://updates.jenkins-ci.org/download/plugins/github-api/1.68/github-api.hpi
	wget http://updates.jenkins-ci.org/download/plugins/git-client/1.17.1/git-client.hpi
	wget http://updates.jenkins-ci.org/download/plugins/git/2.3.5/git.hpi
	wget https://updates.jenkins-ci.org/download/plugins/scm-api/0.2/scm-api.hpi
	wget https://updates.jenkins-ci.org/download/plugins/credentials/1.22/credentials.hpi
	wget http://updates.jenkins-ci.org/download/plugins/github/1.11.3/github.hpi

	wget http://updates.jenkins-ci.org/download/plugins/docker-plugin/0.9.3/docker-plugin.hpi
	wget http://updates.jenkins-ci.org/download/plugins/docker-commons/1.0/docker-commons.hpi
	wget http://updates.jenkins-ci.org/download/plugins/dockerhub-notification/1.0.2/dockerhub-notification.hpi
	wget https://updates.jenkins-ci.org/download/plugins/authentication-tokens/1.1/authentication-tokens.hpi
	wget https://updates.jenkins-ci.org/download/plugins/token-macro/1.10/token-macro.hpi
	wget http://updates.jenkins-ci.org/download/plugins/docker-build-publish/1.0/docker-build-publish.hpi

	wget http://updates.jenkins-ci.org/download/plugins/async-http-client/1.7.8/async-http-client.hpi
	wget http://updates.jenkins-ci.org/download/plugins/durable-task/1.5/durable-task.hpi
	wget http://updates.jenkins-ci.org/download/plugins/external-monitor-job/1.4/external-monitor-job.hpi

	EOH
	notifies :restart, 'service[Jenkins]'
end


