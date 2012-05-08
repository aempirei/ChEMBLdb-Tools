CC = gcc
CCFLAGS = -Wall -W -I. -lm
CFLAGS = -Wall -W -I.
TARGETS = chembl_13.rb

.PHONY: all clean wipe

all: $(TARGETS)

chembl_13.rb: chembl_13.schema.sql process_schema.sh
	./process_schema.sh < chembl_13.schema.sql > chembl_13.rb

clean:
	rm -f *.o *~

wipe: clean
	rm -f $(TARGETS)
