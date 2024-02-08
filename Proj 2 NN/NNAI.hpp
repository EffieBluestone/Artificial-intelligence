#ifndef _NNAI_HPP
#define _NNAI_HPP

#include <list>
#include <cstdlib>
#include <iostream>
#include <fstream>
#include <vector>
#include <cmath>

using namespace std;

class NN{

    public: 

    class Node{
        public:
            double sumValue; 
            double activation;
            double delta; 
            vector<double> weights;    
        };

    double sigmoid(double val);
    double derivSigmoid(double val);
    void nnTrain(ifstream &initfile, ifstream &trainfile, ofstream &outfile, int epoch, double learnRate);
    void nnTest(ifstream &initfile, ifstream &testfile, ofstream &reportfile);
    void readNetFile(ifstream &infile);
    void writeNetFile(ofstream &outfile);

    
    //parse files 
    vector<double> split(const string& str); 
    int loadWeightsToNode(int layer, int index, vector<double> weightsPrevious);
    vector<vector<Node>> network;
    
}; 

#endif