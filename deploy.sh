docker build -t niksadi/multi-client -f ./client/Dockerfile ./client
docker build -t niksadi/multi-server -f ./server/Dockerfile ./server
docker build -t niksadi/multi-worker -f ./worker/Dockerfile ./worker

docker push niksadi/multi-client
docker push niksadi/multi-server
docker push niksadi/multi-worker

docker push niksadi/multi-client
docker push niksadi/multi-server
docker push niksadi/multi-worker

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=niksadi/multi-server
kubectl set image deployments/client-deployment client=niksadi/multi-client
kubectl set image deployments/worker-deployment worker=niksadi/multi-worker
kubectl set image deployments/upload-deployment worker=us.gcr.io/dci-architecture-sbx/upload


