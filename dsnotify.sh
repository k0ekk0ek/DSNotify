#!/bin/sh
dsnotify="/usr/local/bin/dsnotify"
config_file="/usr/local/etc/dsnotify/dsnotify.conf"
pid_file="/var/run/dsnotify.pid" # default

if [ -f "$config_file" ]; then
  source "$config_file"
fi

getpid()
{
  local pid=0
  local stopped=1

  if [ -f "$pid_file" ]; then
    pid=$(head -n 1 "$pid_file" 2>/dev/null)
    if [ $? -eq 0 ]; then
      kill -0 "$pid" 1>/dev/null 2>&1
      stopped=$?
    fi
  fi

  if [ $stopped -eq 0 ]; then
    echo "$pid"
  fi

  return $stopped
}


exit_code=0

case "$1" in
  start)
    pid=$(getpid)
    if [ $? -eq 0 ]; then
      echo "dsnotify already running with pid $pid"
    else
      $dsnotify --script "$script" --user "$user" --password-file "$password_file" --daemonize --pid-file "$pid_file"
      exit_code=$?
      if [ $exit_code -eq 0 ]; then
        echo "dsnotify started"
      else
        echo "could not start dsnotify, process exited with $exit_code"
      fi
    fi
    ;;
  stop)
    pid=$(getpid)
    if [ $? -eq 0 ]; then
      kill -15 $pid 1>/dev/null 2>&1
      exit_code=1
	  for retry in {0..2}; do
        kill -0 $pid 1>/dev/null 2>&1
        if [ $? -eq 0 ]; then
          sleep 5
        else
          exit_code=0
          break
        fi
      done

      if [ $exit_code -eq 0 ]; then
        echo "dsnotify stopped"
        if [ -f "$pid_file" ]; then
          rm -f "$pid_file"
        fi
      else
        echo "dsnotify could not be stopped"
      fi
    else
      echo "dsnotify is not running"
    fi
    ;;
  restart)
    $0 "stop"
    exit_code=$?
    if [ $exit_code -eq 0 ]; then
      $0 "start"
      exit_code=$?
    fi
    ;;
  status)
    pid=$(getpid)
    if [ $? -eq 0 ]; then
      echo "dsnotify is running with pid $pid"
    else
      echo "dsnotify is not running"
    fi
    ;;
  *)
    echo "Usage: $(realpath $0) { start | stop | restart | status }"
    exit_code=1
    ;;
esac

exit $exit_code
