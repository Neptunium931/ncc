AS = as
ncc_src = ./src/entry.s \
					./src/quit.s \
					./src/openFile.s \
					./src/closeFile.s \
					./src/malloc.s

ncc_obj = $(ncc_src:.s=.s.o) 

ncc: $(ncc_obj)
	ld -o $@ $^ -g

%.s.o: %.s
	$(AS) -o $@ $< -g

clean:
	rm -f $(ncc_obj)
	rm -f ncc

check: ncc
	./ncc

distcheck:

.PHONY: clean check distcheck
