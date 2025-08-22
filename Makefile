default:
	@echo 'Usage:'
	@echo '	make print-$$APP - Print all the dev build settings of the app'
	@echo '	make dev-$$APP - Build the default variant of the app (usually alpine on linux/amd64)'
	@echo '	make check-$$APP - Print all the release build settings of the app'
	@echo '	make build-$$APP - Build all the variant of the app'
	@echo '	make release-$$APP - Build and push all the variant of the app to the registries'

print-%:
	docker buildx bake --print $*

dev-%:
	docker buildx bake $*

check-%:
	docker buildx bake -f docker-bake.hcl -f docker-bake.prod.hcl --print $*

build-%:
	docker buildx bake -f docker-bake.hcl -f docker-bake.prod.hcl $*

release-%:
	docker buildx bake -f docker-bake.hcl -f docker-bake.prod.hcl --push $*
