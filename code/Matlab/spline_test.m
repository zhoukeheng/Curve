%% 
clc;clear;close all;

X = [1 2 4 5];
Y = [2 1 4 3];

coefficient = spline_generate(X,Y);

%% Plot

point_num = 20;
point_total = [];
interval = size(coefficient,1);

for i = 1 : interval
    temp_x = linspace(X(i),X(i+1),point_num);
    for j = 1:point_num-1
        temp_y = coefficient(i,1) + coefficient(i,2)*(temp_x(j)-X(i)) +...
                        coefficient(i,3)*(temp_x(j)-X(i))^2 +  coefficient(i,4)*(temp_x(j)-X(i))^3;
        point_total = [ point_total; [temp_x(j) temp_y]];
    end
end

point_total = [point_total; [X(end) Y(end)]];

figure(1)

plot(X,Y,'-or');
hold on; grid on;
plot(point_total(:,1), point_total(:,2),'-b','LineWidth',1);
legend("Initial point", "interpreted point");

%% Useful function

function index_collection = spline_generate(x,y)
    len = length(x);
    index_collection = zeros(len-1,4);
    dx = zeros(len-1,1);
    dy = zeros(len-1,1);

    for i = 1:len-1
        index_collection(i,1) = y(i);
        dx(i) = x(i+1) - x(i);
        dy(i) = y(i+1) - y(i);
    end

    A = zeros(len,len);
    b = zeros(len,1);

    A(1,1) = 1; A(len,len) = 1;
    b(1) = 0; b(len)=0;

    for i = 2:len-1
        A(i,i-1) = dx(i-1);
        A(i,i) = 2*dx(i-1) + 2*dx(i);
        A(i,i+1) = dx(i);
        b(i) = 3*(dy(i)/dx(i) - dy(i-1)/dx(i-1));
    end
    C = inv(A)*b;
    index_collection(:,3) = C(1:end-1);

    for i = 1:len-1
        index_collection(i,4) = (C(i+1)-C(i))/3/dx(i);
        index_collection(i,2) = dy(i)/dx(i) - dx(i)/3*(2*C(i)+C(i+1));
    end
end