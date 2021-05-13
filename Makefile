EXE=run.exe
BUILD=_build/default/$(EXE)

build:
	rm -f $(EXE)
	dune build
	ln -s $(BUILD)

test: $(EXE)
	for f in test/*.logo; do dune exec ./$(EXE) $$f; done

clean:
	dune clean
	rm -f $(EXE)
