BINDIR = $(HOME)/.local/bin
SCRIPT = $(PWD)/envbackup.sh

.PHONY: install uninstall

install:
	@mkdir -p $(BINDIR)
	@ln -sf $(SCRIPT) $(BINDIR)/envbackup
	@echo "Symlink créé"

uninstall:
	@rm -f $(BINDIR)/envbackup
	@echo "Symlink supprimé"
