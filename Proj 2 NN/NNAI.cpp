#include "NNAI.hpp"
#include <iomanip>
#include <fstream> 
#include <vector>
#include <sstream>
#include <string>
#include <stdlib.h>     
#include <algorithm>
#include "stat.cpp"

   
using namespace std;

    double NN::sigmoid(double val){
        return 1.0 / (1.0 + exp(-val));
    }
    double NN::derivSigmoid(double val){
        return sigmoid(val) * (1 - sigmoid(val));
    }
    void NN::nnTrain(ifstream &initfile, ifstream &trainfile, ofstream &outfile, int epochs, double learnRate){
        readNetFile(initfile); //set up NN
        //cout << "made it out"; 
            network[0][0].activation = -1; 
            network[1][0].activation = -1; 
            //cout << network[0].size() << ' ' << network[1].size() << ' ' << network[2].size() << endl;  // note the size is +1

            //cout << learnRate << "is learnRate" << endl; 
            
            //USE FOR OUTPUT THE Network 
            // for(int p = 1; p < 3; p++){
            //     for ( int e = 1; e < network[p].size() ; e++){
            //         for(int w = 0; w < network[p-1].size() ; w++){
            //             cout <<  setprecision(3) << fixed << network[p][e].weights[w]<< ' '; 
            //         }
            //         cout << endl;
            //     }
            // }
            //cout << "end intial network" << endl;

            string currLine;
            getline(trainfile, currLine);
            vector<double> paramater = split(currLine);

            //cout << paramater[0] << ' ' << paramater[1] << ' ' << paramater[2] << endl ;
            vector<vector<double>> totalInputs; 
            vector<vector<double>> totalOutputs;
            for(int i = 0 ; i < paramater[0] ; i++){
                getline(trainfile, currLine);
                vector<double> ex = split(currLine);
                auto first = ex.cbegin();
                auto last = ex.cbegin() + paramater[1];
                auto first2 = ex.cbegin() + paramater[1];
                auto last2 = ex.cend();
                vector<double> inputVec(first, last);
                vector<double> outVec(first2,last2);
                totalInputs.push_back(inputVec);
                totalOutputs.push_back(outVec); // only use totalOutputs[x][0] first first element
               //cout << "size is" << totalOutputs[0].size() << endl; 
                //cout << outVec[0];      
            }
            //cout << outVec<< " size outvec" << endl;
            // cout << totalOutputs[0][0] << endl;
            // cout << totalOutputs[0][1] << endl;
            // cout << totalOutputs[0][2] << endl;
            // cout << totalOutputs[0][3] << endl;
       

        for(int epoch = 0; epoch < epochs; epoch++){

            for(unsigned int example = 0; example < paramater[0]; example++){
              //evaluate 
                if(totalInputs[example].size() != (network[0].size()-1)){
                        cerr << "input size mismatch input size: " << totalInputs[example].size() << "nn size: " << network[0].size() << '\n';
                 }
                for (int i = 1; i < network[0].size(); i++){
                    network[0][i].activation = totalInputs[example][i-1];
                }
                for(int l = 1; l < network.size(); l++){
                    for(int j = 1; j < network[l].size(); j++){
                        double newVal = 0;
                        if(network[l][j].weights.size() != network[l-1].size()){
                            cerr << "major size mismatch \n";
                        }
                        for(int w = 0; w < network[l][j].weights.size(); w++){
                            newVal += ((1.0) * network[l][j].weights[w] * network[l-1][w].activation);
                        }
                        network[l][j].sumValue = newVal;
                        network[l][j].activation = sigmoid(newVal);
                    }
                }
                vector<double> ret;
                ret.resize(network[network.size()-1].size()-1);
                for(int i = 1; i < network[network.size()-1].size(); i++){
                    ret[i-1] = network[network.size()-1][i].activation;
                }
                    auto array = ret; 

           // do the delta stuff on outputs 

           if(totalOutputs[0].size() != network[network.size()-1].size() -1){
                cout << "error! mismatch with correct values. totalOutputs[0].size() = " << totalOutputs[0].size() << "and  netwok[network.size()-1].size() -1 = " << network[network.size()-1].size() -1 << '\n';
            }
            for(int index = 1; index < network[network.size()-1].size(); index++){
                network[network.size()-1][index].delta = derivSigmoid(network[network.size()-1][index].sumValue) * (totalOutputs[example][index-1] - network[network.size()-1][index].activation);
            }

            //for the rest of the nodes
            //loop through the remaining layers in reverse order
            for(int layerOne = network.size() - 2; layerOne > 0; layerOne--){
                //for each node:
                for(int node = 1; node < network[layerOne].size(); node++){
                    double sum = 0.0;
                    for(int nodeAfter = 1; nodeAfter < network[layerOne+1].size(); nodeAfter++){
                        sum += network[layerOne+1][nodeAfter].weights[node] * network[layerOne+1][nodeAfter].delta;
                    }
                    // calculate the delta for each of the
                    network[layerOne][node].delta = derivSigmoid(network[layerOne][node].sumValue) * sum ;
                }
            }
            //  use learnRate to update weights
                int layerT = network.size();
                for(layerT = layerT - 1; layerT > 0; layerT--){
                    for (int nodeIn = 0; nodeIn < network[layerT].size(); nodeIn++){
                        for(int weight = 0; weight < network[layerT][nodeIn].weights.size(); weight++){
                            double change = (learnRate * network[layerT-1][weight].activation * network[layerT][nodeIn].delta);
                            double og = network[layerT][nodeIn].weights[weight];
                            network[layerT][nodeIn].weights[weight] = change + og;
                        }
                    }
                }
          // clean up 
            int layerTH = network.size();
                for(layerTH = layerTH -1; layerTH >= 0; layerTH--){
                    for (int nodeIn = 0; nodeIn < network[layerTH].size(); nodeIn++){
                        if(!fixed){
                            network[layerTH][nodeIn].activation = 0;
                            network[layerTH][nodeIn].sumValue = 0;
                        }
                        else{
                            network[layerTH][nodeIn].activation = -1;
                            network[layerTH][nodeIn].sumValue = -1;
                        }
                        network[layerTH][nodeIn].delta = 0; 
                    }
                }
            }
            // cout << "completed epoch #" << epoch << endl;
            
        }
        
        
        outfile << network[0].size()-1 << ' ' << network[1].size()-1 << ' ' << network[2].size()-1 << endl;  // note the size is +1
           // USE FOR OUTPUT THE Network 
            for(int p = 1; p < 3; p++){
                for ( int e = 1; e < network[p].size() ; e++){
                    for(int w = 0; w < network[p-1].size() ; w++){
                        if(w < network[p-1].size() -1){
                            outfile <<  setprecision(3) << fixed << network[p][e].weights[w] << ' '; 
                        }
                        else{
                            //cout << "we here"; 
                            outfile <<  setprecision(3) << fixed << network[p][e].weights[w]; 
                        }

                    }
                    if((e < network[p].size()) && p != 2) { outfile << "\n";}
                    
                }
            }
    }

    void NN::nnTest(ifstream &initfile, ifstream &testfile, ofstream &reportfile){
        readNetFile(initfile); //set up NN

        // begin test 
        string currLine, token;
        getline(testfile, currLine);
        istringstream iss(currLine);
        vector<unsigned int> counts;

        while(iss >> token){
            counts.push_back(stoul(token.c_str(),nullptr,0));
        }
        // cout << counts[0]<< endl;
        // cout << counts[1]<< endl;
        //cout << counts[2]<< endl;
        
         vector<stat> stats;
         stats.resize(network[2].size()-1);
        //cout << stats.size(); 

        int e = 0; 
        while(getline(testfile, currLine)){
            vector<double> ex = split(currLine);
            auto first = ex.cbegin();
            auto last = ex.cbegin() + network[0].size()-1; //+input nodes
            auto first2 = ex.cbegin() + network[0].size()-1;
            auto last2 = ex.cend();
        
            vector<double> inputVec(first, last);
            vector<double> outVec(first2,last2);

            if(inputVec.size() != (network[0].size()-1)){
                cout << "ERROR input size: " << inputVec.size() << "NN size: " << network[0].size() << '\n';
            }
            network[0][0].activation = -1; 
            network[1][0].activation = -1; 
            for (int i = 1; i < network[0].size(); i++){
                network[0][i].activation = inputVec[i-1];
            }
            for(int l = 1; l < network.size(); l++){
                for(int j = 1; j < network[l].size(); j++){
                    double newVal = 0;
                    if(network[l][j].weights.size() != network[l-1].size()){
                        cerr << "major size mismatch \n";
                    }
                    for(int w = 0; w < network[l][j].weights.size(); w++){
                        newVal += ((1.0) * network[l][j].weights[w] * network[l-1][w].activation);
                    }
                    network[l][j].sumValue = newVal;
                    network[l][j].activation = sigmoid(newVal);
                }
            }
            vector<double> ret;
            ret.resize(network[network.size()-1].size()-1);
            for(int i = 1; i < network[network.size()-1].size(); i++){
                ret[i-1] = network[network.size()-1][i].activation;
            }
                    auto array = ret; 

            for(int i = 0; i < stats.size(); i++){

            if(array[i] >= 0.5 && outVec[i] == 1){
                stats[i].A++;
            }else if(array[i] >= 0.5 && outVec[i] == 0){
                stats[i].B++;
            }else if(array[i] < 0.5 && outVec[i] == 1){
                stats[i].C++;
            }else if(array[i] < 0.5 && outVec[i] == 0){
                stats[i].D++;
            }
        }
        e++;
        
    }
    stat totStats;
    double acc = 0;
    double prec = 0;
    double recall = 0; 
    //cout << stats.size()<<endl;
    for(int i = 0; i < stats.size(); i++) {
        //Micro
        totStats.A += stats[i].A;
        totStats.B += stats[i].B;
        totStats.C += stats[i].C;
        totStats.D += stats[i].D;
        //Macro
        acc += stats[i].getAccuracy();
        prec += stats[i].getPrecision();
        recall += stats[i].getRecall();

        reportfile << stats[i].A << " " << stats[i].B << " " << stats[i].C << " " << stats[i].D << " ";
        reportfile <<  setprecision(3) << fixed << stats[i].getAccuracy() << " ";
        reportfile <<  setprecision(3) << fixed << stats[i].getPrecision() << " ";
        reportfile <<  setprecision(3) << fixed << stats[i].getRecall() << " ";
        reportfile <<  setprecision(3) << fixed << stats[i].getF1() << "\n";
    }
    reportfile <<  setprecision(3) << fixed << totStats.getAccuracy() << " ";
    reportfile <<  setprecision(3) << fixed << totStats.getPrecision() << " ";
    reportfile <<  setprecision(3) << fixed << totStats.getRecall() << " ";
    reportfile <<  setprecision(3) << fixed << totStats.getF1() << "\n";

    reportfile <<  setprecision(3) << fixed << acc/stats.size() << " ";
    reportfile <<  setprecision(3) << fixed << prec/stats.size() << " ";
    reportfile <<  setprecision(3) << fixed << recall/stats.size() << " ";
    reportfile <<  setprecision(3) << fixed << (2 * prec/stats.size() * recall/stats.size())/(prec/stats.size() + recall/stats.size());
    
    }

    void NN::readNetFile(ifstream &infile){
        string buf, token;
        getline(infile, buf);
        istringstream iss(buf);
        vector<unsigned int> counts;

        while(iss >> token){
            counts.push_back(stoul(token.c_str(),nullptr,0));
        }

        network.resize(3);  
        network[0].resize(counts[0]+1); //input
        network[1].resize(counts[1]+1); //hidden
        network[2].resize(counts[2]+1); //outputs

        string currLine;
        int layer = 1;
        int index = 1;
        while(getline(infile, currLine)){
            //cout << "call " << k << endl;t
            if(NN::loadWeightsToNode(layer,index,NN::split(currLine)) == -1){
                cerr << "hello \n";
            }
            index++;
            if(index == network[layer].size()){
                index = 1;
                layer++;
                }
            }
           // cout << network[0].size() << ' ' << network[1].size() << ' ' << network[2].size() << endl;  // note the size is +1

            // USE FOR OUTPUT THE Network 
            // for(int p = 1; p < 3; p++){
            //     for ( int e = 1; e < network[p].size() ; e++){
            //         for(int w = 0; w < network[p-1].size() ; w++){
            //             if(w < network[p-1].size() -1){
            //                 reportfile <<  setprecision(3) << fixed << network[p][e].weights[w] << ' '; 
            //             }
            //             else{
            //                 cout << "we here"; 
            //                 reportfile <<  setprecision(3) << fixed << network[p][e].weights[w]; 
            //             }
            //         }
            //         cout << endl;
            //     }
            // }
        }


    int NN::loadWeightsToNode(int layer, int index, vector<double> weightsPrevious) {
        network[layer][index].weights.resize(weightsPrevious.size());
        if(network[layer-1].size() != weightsPrevious.size()){
            return -1;
        }
        for(int i = 0; i < network[layer][index].weights.size(); i++){
            network[layer][index].weights[i] = weightsPrevious[i];
        }
        return 0;
        }

    bool space(char c){
        return isspace(c);
    }
    bool not_space(char c){
        return !isspace(c); 
    }
    vector<double> NN::split(const string& str){
        typedef string::const_iterator iter;
        vector<double> ret;
        iter i = str.begin();
        while (i != str.end())
        {
            // ignore leading blanks
            i = find_if(i, str.end(), not_space);
            // find end of next word
            iter j = find_if(i, str.end(), space);
            // copy the characters in [i, j)
            if (i != str.end())
                ret.push_back(std::stod(std::string(i, j)));
                i = j;
            }
            return ret; 
        }
    