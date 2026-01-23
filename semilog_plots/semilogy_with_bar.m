function h = semilogy_with_bar(x, y, sy, varargin)
% SEMILOGY_WITH_BAR Semilog plot (log y-axis) with symmetric error bars (Octave compatible)
%
% The MIT License (MIT)
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
% Usage:
%   h = semilogy_with_bar(x, y, sy)
%   h = semilogy_with_bar(x, y, sy, 'PropertyName', PropertyValue, ...)
%
% Inputs:
%   x  - x-axis data (vector)
%   y  - y-axis data (vector)
%   sy - symmetric error bar values (vector)
%   varargin - optional property-value pairs for line customization
%              Supported: 'color', 'marker', 'linestyle', 'linewidth', 'markersize'
%
% Output:
%   h - handle to the errorbar plot object
%
% Example:
%   x = 1:20;
%   y = 10.^(x/10);
%   sy = 0.1 * y;
%   h = semilogy_with_bar(x, y, sy, 'color', 'r', 'marker', 's');
%
% See also: plot_with_bar, semilogx_with_bar, loglog_with_bar

    % Ensure inputs are row vectors
    x = x(:)';
    y = y(:)';
    sy = sy(:)';
    
    % Default properties
    props.color = 'b';
    props.marker = 'o';
    props.linestyle = '-';
    props.linewidth = 1.0;
    props.markersize = 6;
    
    % Parse optional property-value pairs
    if ~isempty(varargin)
        for i = 1:2:length(varargin)
            propname = lower(varargin{i});
            if i+1 <= length(varargin)
                props.(propname) = varargin{i+1};
            end
        end
    end
    
    % Create errorbar plot (Octave syntax: errorbar(x, y, err))
    h = errorbar(x, y, sy);
    
    % Set properties using set() function (Octave compatible)
    set(h, 'linestyle', props.linestyle);
    set(h, 'color', props.color);
    set(h, 'marker', props.marker);
    set(h, 'linewidth', props.linewidth);
    set(h, 'markersize', props.markersize);
    
    % Set y-axis to logarithmic scale
    set(gca, 'YScale', 'log');
    
end
