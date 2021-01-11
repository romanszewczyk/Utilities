function Tabl=TextDataLoad(filename,n_start,verbouse);
%
% MIT License
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
% Function load data from text file
% 
% Input:
% filename - name of the text file
% n_start - skip n_start initial lines (table header)
%

if verbouse 
  fprintf('*** Processing %s file... ***\n',filename);
end


filename_t=[filename '.temp'];

fid_r=fopen(filename,'r');
fid_w=fopen(filename_t,'w');


n=1;

while (!feof(fid_r))
  
  t=fgetl(fid_r);
  
  if n>n_start
    
     t = strrep (t, ',', '.');
    
     if (!feof(fid_r))
        fprintf(fid_w,'%s\n',t);
     else
        fprintf(fid_w,'%s',t);
     end
  
  end
  
  n=n+1;
  
end
%
  
fclose(fid_r);
fclose(fid_w);  


if verbouse 
  fprintf('Total %i lines processed \n',n-1);
end

Tabl = load(filename_t,'-ascii');

if verbouse 
  fprintf('Total %i x %i values acquired. \n',size(Tabl,1),size(Tabl,2));
end

delete(filename_t);

if verbouse 
  fprintf('Temporary file %s deleted. \n',filename_t);
end

if verbouse 
  fprintf('*** Everything done. ***\n\n');
end


end
