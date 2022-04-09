%% B spline
clc;clear;close all;

degree = 3;

X = [1 1 2 3 4 5 6 7];
Y = [1 3 1 5 1 4 0 5];


n  = length(X);
% num_vector = linspace(0,1,n+degree+1)';
num_vector = [0,0,0,0,1,2,3,4,5,5,5,5]';

num_points = 100;
rx = zeros(num_points,1);
ry = zeros(num_points,1);
stored_basis_function  = zeros(num_points,1);

for i = 1:n
    u_store = linspace(num_vector(1),num_vector(end),num_points);
    for j =1:num_points
        stored_basis_function(j) = basis_function(i,degree,num_vector,u_store(j));
    end
    rx = rx+ X(i).*stored_basis_function;
    ry = ry +Y(i).*stored_basis_function;

end

rx(1) = X(1);
ry(1) = Y(1);
%% Plot
figure(1)
plot(X,Y,'-k','LineWidth',1);
grid on; hold on;
plot(rx,ry,'-r','LineWidth',1);





%% Useful function

function ret = basis_function(i,p,n_vector,u)
    if p==0
        if u>n_vector(i) && u<=n_vector(i+1)
            ret =1;
            return;
        else 
            ret =0;
            return;
        end

    else
         len1 = n_vector(i+p) - n_vector(i);
         len2 = n_vector(i+p+1)-n_vector(i+1);

         if len1 ==0
            disp('len 1 is 0')
            a1 = 0;
         else
            a1 = (u-n_vector(i))/len1;
         end

         if len2 ==0
             disp('len 2 is 0');
             a2 =0;
         else
             a2 = (n_vector(i+p+1)-u)/len2;
         end
         ret = a1*basis_function(i,p-1,n_vector,u) + a2*basis_function(i+1,p-1,n_vector,u);
         return;
    end

end