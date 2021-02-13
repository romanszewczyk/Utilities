function R2 = R2calc(x1,x2)
%
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
%
%
% Function calculates R-squared value (coefficient of determination) 
% 
% Input:
% x1, x1 - vectors with data
%
% Calculations accordingly to:
% https://en.wikipedia.org/wiki/Coefficient_of_determination
%
%

if size(x1)~=size(x2)
  fprintf('\n Error R2calc: vectors should have the same length. \n');
  R2=NaN;
  exit
end

if min(size(x1))~=1
  fprintf('\n Error R2calc: x1 and x2 should be vectors. \n');
  R2=NaN;
  exit
end

R2_ = corrcoef(x1,x2);
R2 = R2_(1,2).^2;

end 
