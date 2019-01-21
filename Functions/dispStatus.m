function dispStatus(message, percentage)
    if percentage > 1
          for j=0:(log10(percentage-1) + strlength(message) + 3)
              fprintf('\b'); % delete previous counter display
          end
    end
    fprintf(strcat(message, ": %d%%"), percentage);
    if percentage == 100
        fprintf('\n');
    end
end