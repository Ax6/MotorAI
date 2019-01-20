function encoded = logEncode(parameter_range, value)
    max = log10(parameter_range(:, 2));
    min = log10(parameter_range(:, 1));
    encoded = (log10(value) - min) ./ (max - min);
end
