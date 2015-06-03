user 'jenkins' do
	home '/home/jenkins'
	shell '/bin/bash'
	password '$1$jky3gbSD$00k0i/rzdjCD1nqDDfeB7/'
	action :create
end

bash 'install-ant' do
	user 'root'
	code <<-EOH
	yum -y update
	yum -y install java
	yum -y install ant
	EOH
end

Chef::Log.info("***************** Jenkins slave setup finished **************")
