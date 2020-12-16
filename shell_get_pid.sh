# get pid

getPID(){
	pid=$(ps -ef | grep "$1" |grep -v grep | awk '{print $2}')
	echo "$pid"
}

getPID "$1"