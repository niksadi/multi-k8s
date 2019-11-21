docker build -t niksadi/multi-client:latest -t niksadi/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t niksadi/multi-server:latest -t niksadi/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t niksadi/multi-worker:latest -t niksadi/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push niksadi/multi-client:latest
docker push niksadi/multi-server:latest
docker push niksadi/multi-worker:latest

docker push niksadi/multi-client:$SHA
docker push niksadi/multi-server:$SHA
docker push niksadi/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=niksadi/multi-server:$SHA
kubectl set image deployments/client-deployment client=niksadi/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=niksadi/multi-worker:$SHA

