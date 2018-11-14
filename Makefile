SRC_DIR := ./src
BIN_DIR := ./bin
SRC_FILES := $(wildcard $(SRC_DIR)/*.sol)
BIN_FILES := $(patsubst $(SRC_DIR)/%.sol,$(BIN_DIR)/%.bin,$(SRC_FILES))

all: $(BIN_FILES)

$(BIN_DIR)/%.bin: $(SRC_DIR)/%.sol
	solcjs --abi $< -o $(BIN_DIR)
	solcjs --bin $< -o $(BIN_DIR)
