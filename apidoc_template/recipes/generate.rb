node[:deploy].each do |app_name, deploy|

  script "install_bower" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<--EOH
    npm install -g bower
    EOH
  end

  script "generate_docs" do
    interpreter "bash"
    user "#{deploy[:user]}"
    cwd "#{deploy[:deploy_to]}/current/docs-template"
    code <<-EOH
    bower install
    EOH
  end

  script "generate_docs" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    npm install -g grunt-cli
    grunt apidoc
    EOH
  end

end