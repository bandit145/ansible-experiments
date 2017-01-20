#location of ansible playbooks
location = '/home/ans-between/playbooks/'
#host address local/127.0.0.1 for local or 0.0.0.0 for external use
host = '0.0.0.0'
#port to bind to
port = '8080'
#authtentication key for users(Not secure, looking at switiching to hashing)
auth = '{{auth}}' 
#default is gunicorn
server= 'gunicorn'


dbdir="/home/server/ans-between/"

schemaloc="/home/server/ans-between/"