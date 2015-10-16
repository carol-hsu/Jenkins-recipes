bash 'install_kubernetes' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
  wget --max-redirect 255 https://github.com/GoogleCloudPlatform/kubernetes/releases/download/v1.0.1/kubernetes.tar.gz
  tar zxvf kubernetes.tar.gz
  cd kubernetes/server
  tar zxvf kubernetes-server-linux-amd64.tar.gz
  cd kubernetes/server/bin
  mv * /usr/local/bin
  EOH
end
