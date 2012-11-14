h = waitbar(0,'Please wait...');
steps = 10000;
for step = 1:steps
    % computations take place here
    waitbar(step / steps)
end
close(h) 