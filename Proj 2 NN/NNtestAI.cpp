#include <iostream>
#include <fstream>
#include <string>
#include "NNAI.hpp"

 
using namespace std;

int main(){

  string neuralNet, oFile, testFile;
  ifstream tfile, nueralNetfile ;
  ofstream reportfile;

  // IO Setup
  cout << "Enter name of trained neural network file: ";
  getline (cin, neuralNet);

  cout << "Enter name of test set file: ";
  getline (cin, testFile);

  cout << "Enter name of results file: ";
  getline (cin, oFile);

  nueralNetfile.open(neuralNet.c_str());
  

  tfile.open(testFile.c_str());
 

  reportfile.open(oFile.c_str());
 

  NN nueralNetwork;

  nueralNetwork.nnTest(nueralNetfile, tfile, reportfile);

  nueralNetfile.close();
  tfile.close();
  reportfile.close();

  return 0;
}