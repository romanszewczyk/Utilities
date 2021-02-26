function result=ChkPkg(PkgName)

% The MIT License (MIT)
%
% Copyright (c) 2016, 2017, 2021 Roman Szewczyk
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
% Check if 'name' package is installed. Load 'name' if installed, but not loaded
% 
% AUTHOR: Roman Szewczyk, rszewczyk@onet.pl
%
% USAGE:
% ChkPkg('odepkg');
% 

t=ver;

if strcmp(t(1).Name,'Octave')==0
   fprintf('\n\n*** ChkPkg only valid for Octave ***\n\n');
   result=1;
   return;
   end

inst_pkg = pkg ('list');

[i,j]=size(inst_pkg);

pkg_inst=0;
pkg_loaded=0;

for i=1:j
    if strcmp(inst_pkg{1,i}.name,PkgName)==1
       pkg_inst=1;
       if inst_pkg{1,i}.loaded==1;
          pkg_loaded=1;
       end
    end
end

if pkg_inst==0
   fprintf('\n*** ERROR: ');
   fprintf(PkgName);
   fprintf(' must be installed.\nTry: pkg install -forge %s\n\n',PkgName);
   result=0;
   return;
else
   fprintf(PkgName);
   fprintf(' installed...ok.');
end
   
if pkg_loaded==0
   fprintf('\nWARNING: ');
   fprintf(PkgName);
   fprintf(' is installed but not loaded.\n');
   pkg('load',PkgName);
   fprintf('Problem solved: ');
   fprintf(PkgName);
   fprintf(' is loaded now.\n\n');
   else
   fprintf('\n');
   fprintf(PkgName);
   fprintf(' loaded...ok.\n\n');
end

result=1;

end