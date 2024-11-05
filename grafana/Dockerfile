FROM grafana/grafana:10.2.5

ENV GF_PATHS_PROVISIONING=/etc/grafana/provisioning
ENV GF_AUTH_ANONYMOUS_ENABLED=true
ENV GF_AUTH_ANONYMOUS_ORG_ROLE=Admin
ENV GF_SERVER_ROOT_URL=http://grafana.ranchat.com

EXPOSE 3000

COPY ./launch.sh /launch.sh

ENTRYPOINT ["/launch.sh"]