#ifndef NN_STAT_H
#define NN_STAT_H

class stat {
public:
    int A = 0;
    int B = 0;
    int C = 0;
    int D = 0;

    double getAccuracy() {
        return (1.0) * ((double) (A + D) / (double) (A + B + C + D));
    }

    double getPrecision() {
        return (double) (1.0) *  ((double) A / (double) (A+B));
    }

    double getRecall(){
        return (double) (1.0) *  ((double) A / (double) (A+C));
    };

    double getF1(){
        double y = (2 * (double) getPrecision() * (double) getRecall())/ (double) (getPrecision() + (double) getRecall());
        if(std::isnan(y)){
            return 0;
        }
        return y;
    };
};


#endif