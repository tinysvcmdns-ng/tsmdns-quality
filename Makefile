PROJECT=tynisvcmdns
PROJECTBASEDIR=..
SONAR_ORGANIZATION?=tinysvcmdns-ng
BWOUT=bw-output
PLATFORM=x86-64

MAKE=make

all: ../mdnsd.c
	$(MAKE) -C $(PROJECTBASEDIR)

clean:
	make -C $(PROJECTBASEDIR) clean
	rm -rf $(BWOUT)

buildwrap: MAKE=build-wrapper-linux-$(PLATFORM)  --out-dir $(BWOUT) make
buildwrap: all

sonar-analyze: clean buildwrap
	sonar-scanner -Dsonar.projectBaseDir=$(PROJECTBASEDIR) -Dproject.settings=$(PWD)/sonar-project.properties -Dsonar.cfamily.build-wrapper-output=$(BWOUT) -Dsonar.projectKey=$(strip $(SONAR_ORGANIZATION)_$(PROJECT)) -Dsonar.organization=$(SONAR_ORGANIZATION) -Dsonar.login=$(SONAR_TOKEN)
