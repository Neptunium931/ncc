AS = as
ncc_src = ./src/entry.s
ncc_obj = $(ncc_src:.s=.s.o) 

ncc: $(ncc_obj)
	ld -o $@ $^

%.s.o: %.s
	$(AS) -o $@ $<

clean:
	rm -f $(ncc_obj)
	rm -f ncc
