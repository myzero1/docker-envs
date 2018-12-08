#change the bashrc of docker-machine '/var/lib/boot2docker/bootlocal.sh'

# path/to/.docker/docker-workspace	https://github.com/myzero1/docker-envs.git
# 	docker-envs
# 		app 	# for app code or config
# 		env		# for env
# 		data  	# for data

#change the mirror
#sudo sed -i "s|EXTRA_ARGS='|EXTRA_ARGS='--registry-mirror=http://f1361db2.m.daocloud.io |g" /var/lib/boot2docker/profile
sudo sed -i "s|EXTRA_ARGS='.*$|EXTRA_ARGS='--registry-mirror=http://f1361db2.m.daocloud.io |g" /var/lib/boot2docker/profile

#copy env files
sudo mkdir -p /var/lib/boot2docker/docker-worspace/docker-envs/data;
sudo mkdir -p /var/lib/boot2docker/docker-worspace/docker-envs/env;
#sudo cp -Rf /c/Users/docker-envs/env  /var/lib/boot2docker/docker-worspace/docker-envs/env;
# notice! change the username 'Administrator'.
# sudo cp -Rf /c/Users/Administrator/.docker/docker-workspace/docker-envs/env/*  /var/lib/boot2docker/docker-worspace/docker-envs/env;

find /c/Users/ -name machines -maxdepth 4 -type d > tpmsed;
sed -i "s/\.docker\/machine\/machines//g" tpmsed;
userpath=$(cat tpmsed);
rm -rf tpmsed;
#userpath=$(find /c/Users/ -name machines -maxdepth 4 -type d > /tmp/sed && sed -i "s/\.docker\/machine\/machines//g" /tmp/sed && cat /tmp/sed);
sudo cp -Rf ${userpath}.docker/docker-workspace/docker-envs/env/*  /var/lib/boot2docker/docker-worspace/docker-envs/env;

#phpMyAdmin
if [ ! -d ${userpath}.docker/docker-workspace/docker-envs/app/phpmyadmin ]; then
	ver='4.7.7';
	cd ${userpath}.docker/docker-workspace/docker-envs/app;
	wget https://files.phpmyadmin.net/phpMyAdmin/$ver/phpMyAdmin-$ver-all-languages.zip;
	unzip phpMyAdmin-$ver-all-languages.zip;
	mv phpMyAdmin-$ver-all-languages  phpmyadmin;
	sudo sed -i "s/^\$cfg\['Servers'\]\[\$i\]\['host'\].*$/\$cfg['Servers'][\$i]['host'] = 'mysql';/g" phpmyadmin/libraries/config.default.php;
	sudo sed -i "s/^\$cfg\['Servers'\]\[\$i\]\['password'\].*$/\$cfg['Servers'][\$i]['password'] = 'myzero1\&735';/g" phpmyadmin/libraries/config.default.php;
	rm phpMyAdmin-$ver-all-languages.zip;
fi

