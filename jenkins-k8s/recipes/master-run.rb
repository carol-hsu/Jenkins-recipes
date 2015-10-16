service "flanneld" do
	action :start
	notifies :run, 'bash[wait_flanneld]', :delayed
end

bash 'wait_flanneld' do
	user 'root'
	cwd '/tmp'
	code <<-EOH
	tries=0
        while [ ! -f /run/flannel/subnet.env -a $tries -lt 10 ]; do
            sleep 1
            tries=$((tries + 1))
        done
	EOH

	action :nothing
	notifies :start, 'service[kubernetes-master]', :delayed
end


service "kubernetes-master" do
	action :nothing
end
