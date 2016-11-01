wget -q -O - https://pkg.jenkins.io/debian/jenkins.io.key | apt-key add -
echo deb http://pkg.jenkins.io/debian-stable binary/ > /etc/apt/sources.list.d/jenkins.list
