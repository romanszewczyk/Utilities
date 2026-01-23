% test_with_bar_functions.m
% Test script for plot_with_bar, semilogx_with_bar, semilogy_with_bar, loglog_with_bar
%
% Run this script to verify all functions work correctly in Octave

clear all
close all
clc

% Generate test data
x = linspace(1, 100, 20);
y = sqrt(x) + randn(size(x)) * 0.5;
sy = 0.3 * ones(size(x));

% Test 1: plot_with_bar
figure(1)
h1 = plot_with_bar(x, y, sy, 'color', 'b', 'marker', 'o', 'linewidth', 1.5);
grid on;
xlabel('x');
ylabel('y');
title('Test: plot\_with\_bar');

% Test 2: semilogx_with_bar
figure(2)
h2 = semilogx_with_bar(x, y, x.*sy, 'color', 'r', 'marker', 's', 'linewidth', 1.5);
grid on;
xlabel('x (log scale)');
ylabel('y');
title('Test: semilogx\_with\_bar');

% Test 3: semilogy_with_bar
figure(3)
y_exp = exp(x/20);
sy_exp = 0.1 * y_exp;
h3 = semilogy_with_bar(x, y_exp, sy_exp, 'color', 'g', 'marker', '^', 'linewidth', 1.5);
grid on;
xlabel('x');
ylabel('y (log scale)');
title('Test: semilogy\_with\_bar');

% Test 4: loglog_with_bar
figure(4)
x_log = logspace(0, 2, 15);
y_log = x_log.^1.5;
sy_log = 0.1 * y_log;
h4 = loglog_with_bar(x_log, y_log, sy_log, 'color', 'm', 'marker', 'd', 'linewidth', 1.5);
grid on;
xlabel('x (log scale)');
ylabel('y (log scale)');
title('Test: loglog\_with\_bar');

% Test 5: Multiple curves on same plot using hold on
figure(5)
hold on;
h5a = semilogx_with_bar(x, y, sy, 'color', 'k', 'marker', 'o', 'linewidth', 1.5);
h5b = semilogx_with_bar(x, y + 2, sy, 'color', 'r', 'marker', 's', 'linewidth', 1.5);
hold off;
grid on;
xlabel('x (log scale)');
ylabel('y');
legend({'Data 1', 'Data 2'}, 'Location', 'northwest');
title('Test: Multiple curves with semilogx\_with\_bar');

fprintf('All tests completed successfully.\n');
fprintf('Check figures 1-5 for visual verification.\n');
