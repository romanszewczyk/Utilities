function res=NonLinFilt(H,n_win,t,r,verbouse)
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
% Function nonlinear filtering 
% 
% Input:
% H - vector with input data
% n_win - sie of window
% t - treshold
% r - number of repetitions
%


if verbouse
  fprintf('*** Nonlinear filtering ***\n');
  fprintf('filtering %i elements\n',numel(H));
  fprintf('window: %i, t=%1.2f, r=%i\n',n_win, t, r);
end


H_arch=H;

% n_win=30;
% t=0.5;
for ir=1:r
  
for i=0:floor(numel(H)./n_win)-1
  
  if i<floor(numel(H)./n_win)-1
      win=H(i.*n_win+1:(i+1).*n_win);
  else
      win=H(i.*n_win+1:end);
  end
  
  x=1:numel(win);
  p=polyfit(x',win,2);
  
  y=p(1).*x.^2+p(2).*x+p(3);
  
  d=std(abs(win-y));
  
  win2=win;
  x2=x;
  
  for j=1:numel(win)
    if (abs(win(j)-y(j))>t.*d)
      
      if ((j>1) && (j<numel(win)))     
      win2(j)=(win2(j-1)+win2(j+1))./2;
      elseif j==1
      win2(1)=win2(2)-(win2(3)-win2(2));
      else
      win2(end)=win2(end-1)+(win2(end-1)-win2(end-2));
      end
            
    end
  end
  
  p2=polyfit(x2',win2,2);
  y2=p(1).*x.^2+p(2).*x+p(3);
  
  for j=1:numel(win)
    if (abs(win(j)-y(j))>t.*d)
      win(j)=y2(j);
    end
  end  
  
  
  if i<floor(numel(H)./n_win)-1
      H(i.*n_win+1:(i+1).*n_win)=win;
  else
      H(i.*n_win+1:end)=win;
  end
  
end  
%
end

H2=zeros(floor(numel(H)./n_win),1);

for i=0:floor(numel(H)./n_win)-1
  
  if i<floor(numel(H)./n_win)-1
      win=H(i.*n_win+1:(i+1).*n_win);
  else
      win=H(i.*n_win+1:end);
  end
  
  x=1:numel(win);
  p=polyfit(x',win,1);
  
  y=p(1).*x+p(2);
  
  H2(i+1)=y(1);
  
end 
%

res=H2;

if verbouse
  fprintf('*** Everything done. ***\n\n');
end

end