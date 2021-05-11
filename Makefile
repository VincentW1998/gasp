EXE=turtle.exe
BUILD=_build/defualt/$(EXE)

build:
	rm -f $(EXE)
	dune build
	ln -s $(BUILD)

clean:
	dune clean
	rm -f $(EXE)