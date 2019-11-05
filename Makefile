BINARY=ff4j
SRC_DIR=src
ODIN_BINARY=$(shell which odin)
ODIN_DIR=$(shell dirname $(ODIN_BINARY))

all: $(BINARY)

clean:
	rm -f $(BINARY)

$(BINARY): clean
	$(ODIN_DIR)/odin build $(SRC_DIR) -out=$(BINARY)