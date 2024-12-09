DEB_DIR = repo
PACKAGES = libmysyslog libmysyslog-json libmysyslog-text mysyslog-client mysyslog-daemon mysyslog-meta

.PHONY: all clean repo $(PACKAGES)

all: $(PACKAGES)

$(PACKAGES):
	$(MAKE) -C $@

clean:
	for pkg in $(PACKAGES); do \
		$(MAKE) -C $$pkg clean; \
	done
	rm -rf $(DEB_DIR)

repo: all
	mkdir -p $(DEB_DIR)
	for pkg in $(PACKAGES); do \
		cp $$pkg/*.deb $(DEB_DIR); \
	done
	dpkg-scanpackages $(DEB_DIR) /dev/null | gzip -9c > $(DEB_DIR)/Packages.gz

