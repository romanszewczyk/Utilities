function Tabl=RemovePolishChars(filename,verbouse);
%
% MIT License
%
% Copyright (c) 2023 Roman Szewczyk
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
% Function removes polish characters from the text file
%
% Input:
% filename - name of the text file
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

      % remove polish characters

      t=strrep(t,'ę','e');
      t=strrep(t,'Ę','e');

      t=strrep(t,'ó','o');
      t=strrep(t,'Ó','O');

      t=strrep(t,'ą','a');
      t=strrep(t,'Ą','Ą');

      t=strrep(t,'ś','s');
      t=strrep(t,'Ś','Ś');

      t=strrep(t,'ł','l');
      t=strrep(t,'Ł','L');

      t=strrep(t,'ż','z');
      t=strrep(t,'Ż','Ż');
      t=strrep(t,'ź','z');
      t=strrep(t,'Ź','Z');

      t=strrep(t,'ć','c');
      t=strrep(t,'Ć','C');

      t=strrep(t,'ń','n');
      t=strrep(t,'Ń','N');

      if (!feof(fid_r))
         fprintf(fid_w,'%s\n',t);
      else
         fprintf(fid_w,'%s',t);
      end

      n=n+1;

end
%

fclose(fid_r);
fclose(fid_w);

if verbouse
  fprintf('Total %i lines processed \n',n-1);
end

delete(filename);
rename (filename_t, filename)

if verbouse
  fprintf('Old file %s deleted. New file created. \n',filename);
end

if verbouse
  fprintf('*** Everything done. ***\n\n');
end


end
