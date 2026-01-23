function h = semilogy_with_bar(x, y, sy, varargin)
% SEMILOGY_WITH_BAR Semilog plot (log y-axis) with symmetric error bars (Octave compatible)
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
