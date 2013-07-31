# Makefile

# If the first argument is "run"...
ifeq (run,$(firstword $(MAKECMDGOALS)))
  # use the rest as arguments for "run"
  RUN_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  # ...and turn them into do-nothing targets
  $(eval $(RUN_ARGS):;@:)
endif

FILES = hello

YELLOW='\033[00;33m' 
RESTORE='\033[0m'

clean:
	@for file in $(FILES); do \
		echo rm -f $$file.bin $$file.flp; \
		rm -f $$file.bin $$file.flp; \
	done
	@echo $(YELLOW)Removed all compiled files!$(RESTORE)

all: clean
	@for file in $(FILES); do \
		echo nasm -f bin -o $$file.bin $$file.asm; \
		nasm -f bin -o $$file.bin $$file.asm; \
		dd status=noxfer conv=notrunc if=$$file.bin of=$$file.flp; \
		echo dd status=noxfer conv=notrunc if=$$file.bin of=$$file.flp; \
	done
	@echo $(YELLOW)Finished building all!$(RESTORE)

.PHONY: run
run: all
	@echo $(YELLOW)Starting emulation of $(RUN_ARGS)!$(RESTORE)
	qemu -fda $(RUN_ARGS).flp
