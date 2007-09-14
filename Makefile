SNMP_MIBS_DIR = /usr/share/snmp/mibs
SBINDIR = /usr/bin
CONFDIR = /etc/vzt
MIBSDIR = /usr/share/snmp/mibs
###################################
SCRIPTS = vzt-kernel-install  vzt-pxe-boot    vzt-show-list \
vzt-pductl vzt-set-kernel  vzt-vzlist2quilt
CONFIGS = vzt-pductl.cfg vzt-pxe-boot.cfg kernel-install.cfg.example

check:
	@if [ ! -d "$(SNMP_MIBS_DIR)" ]; then \
		echo "Error: seems net-snmp or net-snmp-utils not intalled";  \
		exit 1 ; \
	fi \

installbins: check
	for file in $(SCRIPTS); do \
		install -m 755 $$file $(SBINDIR)/$$file; \
	done
installconf: check
	mkdir -p $(CONFDIR)
	for file in $(CONFIGS); do \
		install -m 755 .$(CONFDIR)/$$file $(CONFDIR)/$$file; \
	done
	
installmibs: check
	cp .$(MIBSDIR)/* $(MIBSDIR)/
	
install: installmibs installbins installconf

.PHONY: all check install
