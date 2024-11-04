#!/bin/sh

sh -euc |
mkdir -p /etc/grafana/provisioning/datasources
cat <<EOF > /etc/grafana/provisioning/datasources/ds.yaml
apiVersion: 1
datasources:
  - name: Loki
    type: loki
    isDefault: true
    access: proxy
    url: http://loki:3100
    jsonData:
      httpHeaderName1: "X-Scope-OrgID"
    secureJsonData:
      httpHeaderValue1: "ranchat-logs"
    timeout: 30000
EOF
/run.sh