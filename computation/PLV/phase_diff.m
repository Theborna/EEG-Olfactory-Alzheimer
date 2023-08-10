function phaseDiff = phase_diff(signal1, signal2)
    analytic1 = hilbert(signal1);
    analytic2 = hilbert(signal2);
    phase1 = angle(analytic1);
    phase2 = angle(analytic2);
    phaseDiff = phase1 - phase2;
end

