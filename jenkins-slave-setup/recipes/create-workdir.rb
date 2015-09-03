#create dir
directory '/media/ephemeral0/jenkins' do
    owner jenkins
    group jenkins
	mode '0755'
	action :create
    recursive true
end

