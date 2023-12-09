function [hours, minutes, seconds] = f2hms(float_value)
    % Extract hours from integer part
    hours = floor(float_value / 10000);

    % Extract remaining minutes and seconds
    minutes_and_seconds = float_value - (hours * 10000);

    % Extract minutes
    minutes = floor(minutes_and_seconds / 100);

    % Extract seconds
    seconds = minutes_and_seconds - (minutes * 100);
end