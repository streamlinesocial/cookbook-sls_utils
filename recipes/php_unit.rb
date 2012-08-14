# install packages for xdebug
%w{ php-pecl-xdebug php-channel-phpunit php-phpunit-PHPUnit }.each do |pkg|
  package pkg do
    action :install
  end
end
