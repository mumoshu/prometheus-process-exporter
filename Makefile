dev:
	helm tiller run tiller-system -- helm template charts/prometheus-process-exporter
	helm tiller run tiller-system -- helm upgrade --debug --install --force prometheus-exporter charts/prometheus-process-exporter
	kubectl port-forward svc/process-exporter-prometheus-process-exporter 9100

repackage-all:
	scripts/repackage-all.sh

upload:
	helm package charts/prometheus-process-exporter --destination packages
	cr upload -o mumoshu -t $(GITHUB_TOKEN) -r prometheus-process-exporter -p packages

index:
	cr index -p packages -r prometheus-process-exporter -i docs/index.yaml -o mumoshu -c https://github.com/mumoshu/prometheus-process-exporter
