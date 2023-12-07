#Inicia minikube
minikube start --driver=docker --cpus 4 --memory 3926

#Configuracao basica do istio
cd ~Documents
curl -L https://istio.io/downloadIstio | sh -
cd istio-1.20.0
export PATH=$PWD/bin:$PATH
istioctl install --set profile=demo -y

#habilita injecao de codigo istio por padrao nos pods que forem lancados no namespace default
kubectl label namespace default istio-injection=enabled

#Clona projeto de gerencia
git clone git@github.com:RdrigoMachado/gerencia-rede.git

#Faz o deploy dos apps v1 e v2 e seus respectivos servicos
cd gerencia-rede
kubectl apply -f gerencia-deploy-v1.yaml
kubectl apply -f gerencia-deploy-v2.yaml

#Cria rotas para cada um dos servicos nas urls ingress_ip/v1 e ingress_ip/v2
kubectl apply -f gerencia-gateway.yaml

#Pegar os links para ambos os servicos
ingress_ip=$(kubectl get services -n istio-system istio-ingressgateway -o jsonpath="{.status.loadBalancer.ingress[0].ip}")
echo "link v1: http://$ingress_ip/v1"
echo "link v2: http://$ingress_ip/v2"

