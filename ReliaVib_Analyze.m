%% ReliaVib - Batch analyzer for smartphone vibration recordings
% Author: Gianluigi Riccardi
% Analyzes the .mat files saved by ReliaVib_Acquire.m and produces, for each
% measurement point, a time-domain plot and a single-sided amplitude spectrum.
%
% Notes on the method
%   Smartphone sensors do not sample at a perfectly constant rate, so the
%   signal is first resampled on a uniform time grid. The mean value is then
%   removed: the magnitude of the acceleration vector contains gravity
%   (about 9.81 m/s^2), which would otherwise dominate the spectrum at 0 Hz.
%   The usable frequency range is limited to Fs/2 (Nyquist frequency); with a
%   typical smartphone rate of about 100 Hz this means components up to 50 Hz.

clear; clc;

files = dir('ReliaVib_P*.mat');
if isempty(files)
    error('No ReliaVib_P*.mat files found in the current folder. Run ReliaVib_Acquire.m first.');
end

for i = 1:numel(files)
    filename = files(i).name;
    disp(['Loading file: ' filename]);
    S = load(filename);   % saved by ReliaVib_Acquire.m: data, timestamps, code, location, vib

    t = S.timestamps(:);
    a = S.data;
    vib = sqrt(a(:,1).^2 + a(:,2).^2 + a(:,3).^2);

    % Uniform resampling at the median sampling rate
    Fs = 1 / median(diff(t));
    tu = (t(1):1/Fs:t(end))';
    vu = interp1(t, vib, tu, 'linear');
    vu = vu - mean(vu);           % remove gravity / DC component
    n  = numel(vu);

    % Time domain
    fig1 = figure('Visible', 'on');
    plot(tu, vu, 'b');
    grid on;
    title(['Vibration at ' S.location ' (time domain, mean removed)']);
    xlabel('Time (s)');
    ylabel('Acceleration (m/s^2)');
    [peakVal, idx] = max(abs(vu));
    hold on;
    plot(tu(idx), vu(idx), 'ro', 'MarkerSize', 8, 'LineWidth', 2);
    text(tu(idx), vu(idx), '  max peak', 'Color', 'red', 'FontWeight', 'bold');
    saveas(fig1, ['ReliaVib_' S.code '_TimeDomain.png']);
    close(fig1);

    % Single-sided amplitude spectrum
    Y  = abs(fft(vu)) / n;
    nh = floor(n/2) + 1;
    A  = Y(1:nh);
    A(2:end-1) = 2 * A(2:end-1);
    f  = (0:nh-1)' * Fs / n;

    fig2 = figure('Visible', 'on');
    plot(f, A, 'r');
    grid on;
    title(['Amplitude spectrum at ' S.location]);
    xlabel('Frequency (Hz)');
    ylabel('Amplitude (m/s^2)');
    xlim([0 Fs/2]);
    saveas(fig2, ['ReliaVib_' S.code '_Spectrum.png']);
    close(fig2);

    [~, k] = max(A(2:end));
    fprintf('[%s] Fs = %.1f Hz, max |a| = %.2f m/s^2 at %.2f s, dominant frequency %.2f Hz\n', ...
        S.code, Fs, peakVal, tu(idx) - tu(1), f(k+1));
end

disp('All files analyzed. Plots saved as PNG in the current folder.');
