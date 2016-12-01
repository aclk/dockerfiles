#!/bin/bash
#################
# Setup script
#################

# Start the strong-pm service
/usr/local/bin/sl-pm --base . --listen 8701 --skip-default-install &

# Wait for Strong-PM to be up and running
sleep 10

# Deploy the code
/usr/local/bin/sl-deploy --service 1 http://localhost:8701 artifact.tgz

# Wait until the deployment is complete
while [ ! -e /home/strong-pm/svc/1/work/current ];
do
  echo -n '.'
  sleep 1
done
echo -n '[OK]'

# Wait until the process are launched - then cleanly stop strong-pm
sleep 10
/usr/local/bin/sl-pmctl shutdown