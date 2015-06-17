directory '/home/ec2-user/jenkins' do
    owner 'ec2-user'
    group 'ec2-user'
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
