
SRCS = erf_cody.cpp rationalcubic.cpp normaldistribution.cpp lets_be_rational.cpp
OBJS = $(SRCS:.cpp=.o)

%.o:%.cpp
	$(CXX) -DNDEBUG -Ofast -c $< -o $@

all: liblbr.dylib
liblbr.a: $(OBJS)
	ar crv $@ $^
liblbr.dylib: $(SRCS)
	$(CXX) -dynamiclib -fPIC -DNDEBUG -Ofast $? -o $@

clean:
	rm $(OBJS)
	rm liblbr.a
	rm liblbr.dylib

.PHONY: clean
