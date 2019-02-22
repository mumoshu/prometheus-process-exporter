dev:
	helm tiller run tiller-system -- helm template charts/prometheus-process-exporter
	helm tiller run tiller-system -- helm upgrade --debug --install --force prometheus-exporter charts/prometheus-process-exporter
	kubectl port-forward svc/process-exporter-prometheus-process-exporter 9100
