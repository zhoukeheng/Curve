#include<iostream>
#include<vector>
#include<math.h>

int factorial(int n){
    if(n==0){
        return 1;
    }
    else{
        return n*factorial(n-1);
    }
}

double recursive_bezier(const std::vector<double>&control_point,
                        double t){
        if(control_point.size()<2){
            return 0.0;
        }
        int n = control_point.size()-1;
        double point = control_point[0]*std::pow(1-t,n);
        for(auto i=1;i<=n;++i){
            point += control_point[i]*(factorial(n)/(factorial(i)*factorial(n-i)))
                    *std::pow(t, i) * std::pow(1 - t, n - i);
        }
        return point;
    }

int main(int argc, char const *argv[])
{
    int num =10;
    double step = 1.0/num;
    double t;
    std::vector<double> control_points = {2,0,0};
    std::vector<double> curve_value;
    for(int i=0;i<num+1;++i){
        t = i*step;
        curve_value.push_back(recursive_bezier(control_points,t));
    }

    for(int i =0;i<curve_value.size();++i){
        std::cout << curve_value[i] << std::endl;
    }
    return 0;
}
