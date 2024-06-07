% MIT License
%
% Copyright (c) 2024 Roman Szewczyk
%
% Permission is hereby granted, free of charge, to any person obtaining a copy
% of this software and associated documentation files (the "Software"), to deal
% in the Software without restriction, including without limitation the rights
% to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
% copies of the Software, and to permit persons to whom the Software is
% furnished to do so, subject to the following conditions:
%
% The above copyright notice and this permission notice shall be included in all
% copies or substantial portions of the Software.
%
% THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
% IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
% FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
% AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
% LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
% OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
% SOFTWARE.
%
%
% Simple Linear Regression for one variable according to:
% https://en.wikipedia.org/wiki/Simple_linear_regression
%

clear all
clc

% Data for the linear regression
% in form: y = a + bx

x = [1.47 1.50 1.52 1.55 1.57 1.60 1.63 1.65 1.68 1.70 1.73 1.75 1.78 1.80 1.83]';
y = [52.21 53.12 54.48 55.84 57.20 58.57 59.93 61.29 63.11 64.47 66.28 68.10 69.92 72.19 74.46]';

n = numel(x);

if numel(y)~= n
  fprintf('Error: wrong size of x and y \n');
  return
end
%

Sx  = sum(x);
Sxx = sum(x.*x);
Sy  = sum(y);
Syy = sum(y.*y);
Sxy = sum(x.*y);

% form: y = a + bx

b = (n.*Sxy - Sx.*Sy) ./ (n.*Sxx - Sx.^2);
a = Sy./n - Sx.*b./n;

se2 = 1./(n.*(n-2)).*(n.*Syy-Sy.^2-b.^2.*(n.*Sxx-Sx.^2));
sb2 = n.*se2./(n.*Sxx-Sx.^2);
sa2 = sb2.*Sxx./n;

% for the 95% confidence interval
% https://en.wikipedia.org/wiki/Student%27s_t-distribution#Confidence_intervals

n_student = [1	2	3	4	5	6	7	8	9	10	11	12	13	14	15	16	17	18	19	20 ...
            21	22	23	24	25	26	27	28	29	30	40	50	60	80	100	120]';

t_student = [12.706	4.303	3.182	2.776	2.571	2.447	2.365	2.306	2.262	2.228	...
             2.201 2.179	2.160	2.145	2.131	2.120	2.110	2.101	2.093	2.086	...
             2.080	2.074	2.069	2.064	2.060	2.056	2.052	2.048	2.045	2.042	...
             2.021	2.009	2.000	1.990	1.984	1.980]';

% consider t-Student distribution if n<60
if n<60
  t = interp1(n_student,t_student,n,'spline');
else
  t = 2;
end

fprintf('Result function for the 95%% confidence interval:\n(%1.5f +/- %1.5f) + (%1.5f +/- %1.5f)*x \n', ...
         a,t.*sqrt(sa2),b,t.*sqrt(sb2));

% https://en.wikipedia.org/wiki/Coefficient_of_determination
SSres = sum((y - (a+b.*x)).^2);
SStot = sum((y-mean(y)).^2);
R2 = 1-SSres./SStot;

fprintf('R2 (R-squared) determination coefficient:\n%1.5f\n\n', R2);

figure(1)
hold on;
for i = 1:100
  plot(x,a+randn(1,1).*sqrt(sa2)+(b+randn(1,1).*sqrt(sb2)).*x,'-r','LineWidth',1);
end
%
plot(x,y,'ok','LineWidth',2,x,a+b.*x,'-k','LineWidth',2);
hold off;
xlabel('x');
ylabel('y');
grid;



