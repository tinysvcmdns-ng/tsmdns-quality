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

buildwrap: MAKE=build-wrapper-linux-$(PLATFORM)  --out-dir $(BWOUT) make
buildwrap: all

sonar-analyze: clean buildwrap
	sonar-scanner -Dsonar.projectBaseDir=$(PROJECTBASEDIR) -Dsonar.cfamily.build-wrapper-output=$(BWOUT) -Dsonar.projectKey=$(strip $(SONAR_ORGANIZATION)_$(PROJECT)) -Dsonar.organization=$(SONAR_ORGANIZATION) -Dsonar.login=$(SONAR_TOKEN)
