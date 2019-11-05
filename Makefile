BINARY=ffvm
SRC_DIR=src

all: $(BINARY)

clean:
	rm -f $(BINARY)

$(BINARY): clean
	odin build $(SRC_DIR) -out=$(BINARY)