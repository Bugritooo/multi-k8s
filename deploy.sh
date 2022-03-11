docker build -t bugrahan23/multi-client:latest -t bugrahan23/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bugrahan23/multi-server:latest -t bugrahan23/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bugrahan23/multi-worker:latest -t bugrahan23/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push bugrahan23/multi-client:latest
docker push bugrahan23/multi-server:latest
docker push bugrahan23/multi-worker:latest

docker push bugrahan23/multi-client:$SHA
docker push bugrahan23/multi-server:$SHA
docker push bugrahan23/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=bugrahan23/multi-server:$SHA
kubectl set image deployment/client-deployment client=bugrahan23/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=bugrahan23/multi-worker:$SHA