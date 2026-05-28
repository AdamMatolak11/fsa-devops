# kube-prometheus-stack

Instalacia:

```powershell
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm upgrade --install kube-prometheus-stack prometheus-community/kube-prometheus-stack `
  -n monitoring `
  --create-namespace `
  -f override.yaml
```

Po instalacii aplikuj:

```powershell
kubectl apply -f ..\..\..\workload\03-app-backend\servicemonitor.yaml
kubectl apply -f ..\..\..\workload\05-ingress\prometheus-ingress.yaml
kubectl apply -f ..\..\..\workload\05-ingress\grafana-ingress.yaml
```

Overenie:

```powershell
kubectl get pods -n monitoring
kubectl get crd | Select-String monitoring.coreos.com
kubectl get servicemonitor -A
```

Pristup:

- Prometheus: https://prometheus.20-234-19-239.sslip.io
- Grafana: https://grafana.20-234-19-239.sslip.io

Grafana login:

- username: `admin`
- password (PowerShell):

```powershell
kubectl get secret -n monitoring kube-prometheus-stack-grafana -o jsonpath="{.data.admin-password}" | % { [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String($_)) }
```

- password (bash):

```bash
kubectl get secret -n monitoring kube-prometheus-stack-grafana -o jsonpath="{.data.admin-password}" | base64 -d && echo
```

Prometheus check:

- otvor `Status -> Targets`
- hladat target pre `fsa-be`
- query na rychly check:

```promql
up{service="fsa-be"}
```
