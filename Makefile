PROJECT=tynisvcmdns
PROJECTDIR=..

all: ../mdnsd.c
	make -C $(PROJECTDIR)

clean:
	make -C $(PROJECTDIR) clean
