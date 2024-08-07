% MIT License
%
% Copyright (c) 2020 Roman Szewczyk
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

x=-4:0.01:4;

mu=0;
s=1;

gauss_distribution= @(x,mu,s) 1./(s.*(2.*pi).^0.5).*exp(-1./2.*((x-mu)./s).^2);

y=gauss_distribution(x, mu, s);

plot(x,y,'-k','linewidth',4);
set(gca,'fontsize',24);
ylim([0 0.6]);
xticks(-4:1:4);
yticks(0:0.1:0.6);
xlabel('{\it x}');
ylabel('{\it p(x)   for \sigma=1, \mu=0}');
% yticklabels({'0' '20 000' '40 000' '60 000' '80 000' '100 000'})  % use if necessary
grid;

