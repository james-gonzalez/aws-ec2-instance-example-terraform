.PHONY: changelog release

changelog:
	git-chglog -o CHANGELOG.md

release:
	semtag final -s minor

release-patch:
	semtag final -s patch

release-major:
	semtag final -s major
