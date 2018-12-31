# Run in octave; put in ~/local/octavepath

function [tau,tau2,T,rho,sigAA,epsAA,sigAB,epsAB,sigBB,epsBB] = kobandprms( m, sigAAp, epsAAp, Tr )
    nm_to_m = 1.0e-09;
    kJ_to_J = 1.0e+03;
    s_to_ps = 1.0e+12;
    kb = 1.38064852e-23 * 6.0221409e23; # kg m^2 / s^2 / K * 1/mol = J / mol K

    # Post-conversion parameters
    # in units of kg, m, and s
    sigAA  = sigAAp * nm_to_m; # m
    epsAA  = epsAAp * kJ_to_J; # J/mol
    
    # Temperature
    T = Tr * epsAA / kb;

    # Set the density to the right reduced value
    rhor = 1.2;
    rho = rhor / ( sigAA / nm_to_m )**3;

    # Store ratios of each variable
    # relative to the corresponding
    # AA Lennard-Jones values
    sigABr = 0.80;
    sigBBr = 0.88;
    epsABr = 1.50;
    epsBBr = 0.50;

    # Calculation of actual sig
    # and eps
    sigAB  = sigABr * sigAA;
    epsAB  = epsABr * epsAA;
    sigBB  = sigBBr * sigAA;
    epsBB  = epsBBr * epsAA;

    # The reduced time unit
    taup = sqrt( m * sigAA**2 / 48 / epsAA );
    taup2 = sqrt( m * sigAA**2 / epsAA );
    tau  = taup * s_to_ps;
    tau2 = taup2 * s_to_ps;

    return;
end

