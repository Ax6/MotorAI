function decoded = logDecode(parameter_range, value)
    max = log10(parameter_range(:, 2));
    min = log10(parameter_range(:, 1));
    decoded = 10.^((value .* (max - min)) + min);
end