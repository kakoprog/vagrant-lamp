# インストール
package "httpd" do
    action :install
end

package "mysql-server" do
    action :install
end

package "php" do
    action :install
end
package "php-mbstring" do
    action :install
end
package "php-mysql" do
    action :install
end

# サービスの起動設定
service "httpd" do
  action [:start, :enable]
end

service 'mysqld' do
  action [:start, :enable]
end


# apache設定ファイルの設置
template "vhost.conf" do
  path "/etc/httpd/conf.d/vhost.conf"
  source "vhost.conf.erb"
  mode 0644
  notifies :restart, 'service[httpd]'
end

template "timezone.ini" do
  path "/etc/php.d/timezone.ini"
  source "timezone.ini.erb"
  mode 0644
  notifies :restart, 'service[httpd]'
end


# MySQL用コマンドの作成（MySQLでユーザーを作成するコマンド）
execute "mysql-create-user" do
    command "/usr/bin/mysql -u root --password=\"\" < /tmp/grants.sql"
    action :nothing
end

# MySQLにユーザーを作成する
template "/tmp/grants.sql" do
    owner "root"
    group "root"
    mode "0600"
    variables(
        :user     => "test",
        :password => "",
        :database => "test"
    )
    notifies :run, "execute[mysql-create-user]", :immediately
end
