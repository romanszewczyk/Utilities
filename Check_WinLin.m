function WinLin=Check_WinLin(verbouse)
% The MIT License (MIT)
%
% Copyright (c) 2021 Roman Szewczyk
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
% DESCRIPTION:
% Check if this is Windows or Linux operating system
%
% USAGE:
% Check_WinLin(verbouse)
%
% verbouse: 0 - quiet mode, 1 - show information
%
% return:
% 0 - Windows
% 1 - Linux
%

t=uname();

if t.release(1)=='W'
  WinLin=0;
  if verbouse 
    fprintf('Windows-type system \n\n');
  end
  
else
  WinLin=1;
  if verbouse
    fprintf('Linux-type system \n\n');
  end
  
end           % identify operation system

end
