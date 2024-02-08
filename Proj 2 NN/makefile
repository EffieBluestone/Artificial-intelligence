.PHONY: all
all: NNtrainAI.exe NNtestAI.exe


NNtrainAI.exe: NNtrainAI.o NNAI.o
	g++ --std=c++11 -o NNtrainAI.exe NNtrainAI.o NNAI.o

NNtestAI.exe: NNtestAI.o NNAI.o
	g++ --std=c++11 -o NNtestAI.exe NNtestAI.o NNAI.o

NNAI.o: NNAI.cpp NNAI.hpp
	g++ --std=c++11 -c NNAI.cpp

NNtrainAI.o: NNtrainAI.cpp NNAI.hpp
	g++ --std=c++11 -c NNtrainAI.cpp

NNtestAI.o: NNtestAI.cpp NNAI.hpp
	g++ --std=c++11 -c NNtestAI.cpp

debug:
	g++ --std=c++11 -g -o trainDebug.exe NNtrainAI.cpp NNAI.cpp NNtestAI.cpp 

clean:
	rm -f *.exe *.o *.stackdump *~

backup:
	test -d backups || mkdir backups
	cp *.cpp backups
	cp *.h backups