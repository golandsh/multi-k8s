docker build -t golandsh/multi-client:latest -t golandsh/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t golandsh/multi-server:latest -t golandsh/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gokandsh/multi-worker:latest -t golandsh/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push golandsh/multi-client:latest
docker push golandsh/multi-server:latest
docker push golandsh/multi-worker:latest

docker push golandsh/multi-client:$SHA
docker push golandsh/multi-server:$SHA
docker push golandsh/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=golandsh/multi-client:$SHA
kubectl set image deployments/server-deployment server=golandsh/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=golandsh/multi-worker:$SHA
