docker build -t iryna/multi-client:latest -t iryna/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t iryna/multi-server:latest -t iryna/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t iryna/multi-worker:latest -t iryna/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push iryna/multi-client:latest
docker push iryna/multi-server:latest
docker push iryna/multi-worker:latest

docker push iryna/multi-client:$SHA
docker push iryna/multi-server:$SHA
docker push iryna/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=iryna/multi-server:$SHA
kubectl set image deployments/client-deployment client=iryna/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=iryna/multi-worker:$SHA
