function encoded = logEncode(parameter_range, value)
    max_ = parameter_range(:, 2);
    min_ = parameter_range(:, 1);
    max = log10(max_);
    min = log10(min_);
    
    gcond = value > max_;
    scond = value < min_;
    if any(gcond)
        value(gcond) = max_(gcond);
    elseif any(scond)
        value(scond) = min_(scond);
    end
    
    encoded = (log10(value) - min) ./ (max - min);
end
