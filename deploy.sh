docker build -t shashank021/multi-client:latest -t shashank021/multi-client:$SHA -f ./complex/client/Dockerfile ./complex/client
docker build -t shashank021/multi-server:latest -t shashank021/multi-server:$SHA -f ./complex/server/Dockerfile ./complex/server 
docker build -t shashank021/multi-worker:latest -t shashank021/multi-worker:$SHA -f ./complex/worker/Dockerfile ./complex/worker

docker push shashank021/multi-client:latest
docker push shashank021/multi-server:latest
docker push shashank021/multi-worker:latest

docker push shashank021/multi-client:$SHA
docker push shashank021/multi-server:$SHA
docker push shashank021/multi-worker:$SHA

kubectl apply -f ./complex/k8s
kubectl set image deployments/server-deployment server=multi-server:$SHA
kubectl set image deployments/client-deployment client=multi-client:$SHA
kubectl set image deployments/worker-deployment worker=multi-worker:$SHA