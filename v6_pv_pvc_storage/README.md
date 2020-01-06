# App_DevOps_encapsulation
## PersistentVolume (pv) and PersistentVolumeClaims (pvc)

Kubernates with persistant volume

In this session we add pv.yml and pvc.yml files that sets the persistant storage.
Also the redis pod in the deploy-redis-yml was updates with the pvc.

To run the app run the commands:

```bash
	./ping-install.sh
	./ping-unstall.sh
```

To check the service IP:
```bash
        kubectl get svc -n ping-ns | grep flask | awk '{print $4}'
```

Now if you uninstall the flask and reinstall it from scratch, the data will be saved.
Once the app is up again, new pings will accumulate to the previous count which would not be reset.

After the containers are up and running, go to the url:

[http://{IP}:5000/ping](http://localhost:5000/ping)
