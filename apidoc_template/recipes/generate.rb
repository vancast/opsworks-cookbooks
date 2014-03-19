node[:deploy].each do |app_name, deploy|

  script "install_bower_deps" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current/docs-template"
    code <<-EOH
    npm install bower -g
    bower install
    EOH
  end

  script "generate_docs" do
      interpreter "bash"
      user "root"
      cwd "#{deploy[:deploy_to]}/current"
      code <<-EOH
      grunt apidocs
      EOH
  end
end