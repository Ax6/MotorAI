function decoded = logDecode(parameter_range, value)
    max_ = parameter_range(:, 2);
    min_ = parameter_range(:, 1);
    max = log10(max_);
    min = log10(min_);
    
    decoded = 10.^((value .* (max - min)) + min);
    
    gcond = decoded > max_;
    scond = decoded < min_;
    if any(gcond)
        decoded(gcond) = max_(gcond);
    elseif any(scond)
        decoded(scond) = min_(scond);
    end
end