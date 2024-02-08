#include <iostream>
#include <fstream>
#include <string>
#include "NNAI.hpp"

using namespace std;

int main(){

  string initneural, outputfile, trainingfile, epochS, learnRateS;
  string::size_type sz;
  ifstream initfile, trainfile;
  ofstream outfile;

  // IO Setup
  cout << "Enter name of initial neural network file: ";
  getline (cin,initneural);

  cout << "Enter name of training set file: ";
  getline (cin,trainingfile);

  cout << "Enter name of output file: ";
  getline (cin,outputfile);

  cout << "Enter value for epoch: ";
  getline (cin,epochS);
  unsigned int epoch = stoul(epochS,nullptr,0);

  cout << "Enter value for learning rate: ";
  getline (cin,learnRateS);
  float learnRate = stof(learnRateS,&sz);

  initfile.open(initneural.c_str());
 

  trainfile.open(trainingfile.c_str());
  

  outfile.open(outputfile.c_str());
 

  NN nueralNetwork;
  //cout << "Enter";
  nueralNetwork.nnTrain(initfile, trainfile, outfile, epoch, learnRate);
  
  initfile.close();
  trainfile.close();
  outfile.close();
  return 0;
}



