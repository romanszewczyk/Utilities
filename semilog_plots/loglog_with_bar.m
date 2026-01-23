function h = loglog_with_bar(x, y, sy, varargin)
% LOGLOG_WITH_BAR Log-log plot with symmetric error bars (Octave compatible)
%
% Usage:
%   h = loglog_with_bar(x, y, sy)
%   h = loglog_with_bar(x, y, sy, 'PropertyName', PropertyValue, ...)
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
%   x = logspace(0, 3, 20);
%   y = x.^2;
%   sy = 0.1 * y;
%   h = loglog_with_bar(x, y, sy, 'color', 'r', 'marker', 's');
%
% See also: plot_with_bar, semilogx_with_bar, semilogy_with_bar

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
    
    % Set both axes to logarithmic scale
    set(gca, 'XScale', 'log');
    set(gca, 'YScale', 'log');
    
end
