function r2 = R2calc(B_meas, B_model, H)
    % CALCULATE_RSQUARED Calculates the Coefficient of Determination (R^2)
    % for magnetic induction values in a hysteresis loop.
    %
    % SYNTAX:
    %   r2 = calculate_rsquared(B_meas, B_model)
    %   r2 = calculate_rsquared(B_meas, B_model, H)
    %
    % INPUTS:
    %   B_meas  - Vector of experimental/measured induction values [Tesla]
    %   B_model - Vector of induction values predicted by the model [Tesla]
    %   H       - (Optional) Vector of magnetic field strength values [A/m]
    %             If provided, R^2 is calculated only for the first quadrant
    %             where both B >= 0 and H >= 0
    %
    % OUTPUT:
    %   r2      - Coefficient of determination (R-squared value)
    %             Range: (-inf, 1], where 1 indicates perfect fit
    %
    % DESCRIPTION:
    %   The R-squared (R^2) metric quantifies how well a mathematical model
    %   captures the behavior of a magnetic material's B-H hysteresis loop.
    %
    % METHOD OVERVIEW:
    %   R^2 is defined as: R^2 = 1 - (SS_res / SS_tot)
    %
    %   where:
    %   - SS_tot (Total Sum of Squares) represents the total variance in
    %     the measured data relative to its mean. For a symmetric major
    %     hysteresis loop, the mean B is typically near zero.
    %
    %   - SS_res (Residual Sum of Squares) represents the variance that
    %     the model fails to explain. It is the sum of squared differences
    %     between measured and modeled B values at corresponding H points.
    %
    % EXAMPLES:
    %   % Full loop analysis
    %   r2_full = calculate_rsquared(B_measured, B_modeled);
    %
    %   % First quadrant only
    %   r2_q1 = calculate_rsquared(B_measured, B_modeled, H_field);
    %
    % NOTES:
    %   - All input vectors must have the same length
    %   - The vectors should represent corresponding points (same H values)
    %


    % =====================================================================
    % INPUT VALIDATION
    % =====================================================================

    % Check minimum number of arguments
    if nargin < 2
        error('calculate_rsquared:TooFewInputs', ...
              'At least two inputs (B_meas, B_model) are required.');
    end

    % Ensure inputs are column vectors for consistent matrix operations
    B_meas = B_meas(:);
    B_model = B_model(:);

    % Check that B_meas and B_model have the same length
    if length(B_meas) ~= length(B_model)
        error('calculate_rsquared:LengthMismatch', ...
              'B_meas and B_model must have the same length. B_meas: %d, B_model: %d', ...
              length(B_meas), length(B_model));
    end

    % If H is provided (3-argument call), perform first quadrant analysis
    if nargin == 3
        % Convert H to column vector
        H = H(:);

        % Verify that H has the same length as B vectors
        if length(H) ~= length(B_meas)
            error('calculate_rsquared:LengthMismatch', ...
                  'When H is provided, all vectors must have the same length. H: %d, B: %d', ...
                  length(H), length(B_meas));
        end

        % Filter data for first quadrant: B >= 0 AND H >= 0
        % This selects only points in the upper-right region of the B-H plane
        quadrant_mask = (B_meas >= 0) & (H >= 0);

        % Apply the mask to extract first quadrant data
        B_meas = B_meas(quadrant_mask);
        B_model = B_model(quadrant_mask);

        % Check if any data points remain after filtering
        if isempty(B_meas)
            warning('calculate_rsquared:NoDataInQuadrant', ...
                    'No data points found in the first quadrant (B >= 0, H >= 0).');
            r2 = NaN;
            return;
        end
    end

    % Check for minimum data requirement
    if length(B_meas) < 2
        warning('calculate_rsquared:InsufficientData', ...
                'At least 2 data points are required to calculate R^2.');
        r2 = NaN;
        return;
    end

    % =====================================================================
    % R-SQUARED CALCULATION
    % =====================================================================

    % Step 1: Calculate the arithmetic mean of the measured data
    % ----------
    % For a symmetric major hysteresis loop centered at the origin,
    % this value is typically close to zero because the loop has equal
    % positive and negative B values. For asymmetric loops or partial
    % data, the mean may be significantly different from zero.
    mean_B_meas = mean(B_meas);

    % Step 2: Calculate the Total Sum of Squares (SS_tot)
    % ----------
    % SS_tot quantifies the total variance in the experimental data.
    % It represents how much the measured B values deviate from their mean.
    %
    % Physical interpretation for hysteresis:
    % - Large SS_tot indicates wide excursion of B values (high saturation)
    % - Small SS_tot indicates narrow range of B values (low saturation)
    %
    % Formula: SS_tot = sum((B_i - mean(B))^2)
    ss_tot = sum((B_meas - mean_B_meas).^2);

    % Step 3: Calculate the Residual Sum of Squares (SS_res)
    % ----------
    % SS_res quantifies the "unexplained" variance - the portion of
    % variation that the model fails to capture. Each term (B_meas - B_model)^2
    % represents the squared vertical distance between a measured point and
    % the corresponding model prediction.
    %
    % Physical interpretation for hysteresis:
    % - Small SS_res means model closely follows measured loop shape
    % - Large SS_res means model poorly represents coercivity, remanence,
    %   or saturation behavior
    %
    % Formula: SS_res = sum((B_i - B_model_i)^2)
    ss_res = sum((B_meas - B_model).^2);

    % Step 4: Calculate the R-squared coefficient
    % ----------
    % R^2 represents the proportion of variance in the measured data that
    % is successfully explained by the model.
    %
    % Formula: R^2 = 1 - (SS_res / SS_tot)
    %
    % This can be rewritten as:
    % R^2 = (SS_tot - SS_res) / SS_tot = SS_explained / SS_tot
    %
    % where SS_explained is the variance captured by the model.

    if ss_tot == 0
        % Special case: all measured values are identical
        % This could occur if:
        % - Only one unique B value exists in the data
        % - The material shows no magnetic response (flat line at B = 0)
        %
        % In this case, R^2 is undefined. We return 0 if the model also
        % predicts the constant value perfectly, otherwise negative.
        if ss_res == 0
            r2 = 1;  % Perfect prediction of constant value
        else
            r2 = -inf;  % Model varies while data is constant
        end
    else
        % Normal case: calculate R^2
        r2 = 1 - (ss_res / ss_tot);
    end

end
