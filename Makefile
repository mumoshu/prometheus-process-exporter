dev:
	helm tiller run tiller-system -- helm template charts/prometheus-process-exporter
	helm tiller run tiller-system -- helm upgrade --debug --install --force prometheus-exporter charts/prometheus-process-exporter
	kubectl port-forward svc/process-exporter-prometheus-process-exporter 9100

repackage-all:
	scripts/repackage-all.sh

# Creates a packages-up/prometheus-process-exporter-x.y.z.tgz and a prometheus-process-exporter-x.y.z tag and then creates a corresponding github release
upload:
	mkdir -p packages-up
	rm -rf packages-up/*
	helm package charts/prometheus-process-exporter --destination packages-up
	cr upload -o mumoshu -t $(GITHUB_TOKEN) -r prometheus-process-exporter -p packages-up
	cp packages-up/* packages/

.PHONY: delta
delta:
	mkdir delta
	helm package charts/prometheus-process-exporter --destination delta
	cr upload -o mumoshu -t $(GITHUB_TOKEN) -r prometheus-process-exporter -p delta
	cp delta/* packages/

index:
	cr index -p packages -r prometheus-process-exporter -i docs/index.yaml -o mumoshu -c https://github.com/mumoshu/prometheus-process-exporter
	git add docs/index.yaml
