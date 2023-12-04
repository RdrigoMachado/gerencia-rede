KEYCLOAK_URL=$(kubectl get ingress/keycloak -n default -o jsonpath='{.spec.rules[0].host}')
kubectl apply -f - <<EOF
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: gerencia-ingress
  annotations:
    nginx.ingress.kubernetes.io/auth-url: "https://$KEYCLOAK_URL:8080/auth/realms/gerencia/protocol/openid-connect/auth"
    nginx.ingress.kubernetes.io/auth-signin: "https://$KEYCLOAK_URL:8080/auth/realms/gerencia/login"
    nginx.ingress.kubernetes.io/auth-response-headers: "authorization"
spec:
  rules:
  - host: gerencia.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: your-service
            port:
              number: 80
EOF
