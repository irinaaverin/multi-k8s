docker build -t irinaid/multi-client:latest -t irinaid/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t irinaid/multi-server:latest -t irinaid/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t irinaid/multi-worker:latest -t irinaid/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push irinaid/multi-client:latest
docker push irinaid/multi-server:latest
docker push irinaid/multi-worker:latest

docker push irinaid/multi-client:$SHA
docker push irinaid/multi-server:$SHA
docker push irinaid/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=irinaid/multi-server:$SHA
kubectl set image deployments/client-deployment client=irinaid/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=irinaid/multi-worker:$SHA