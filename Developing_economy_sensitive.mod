// Developing economy highly sensitive to inflation
var y, c, pi, r, a, k;       // Endogenous variables
varexo e_a, e_m;             // Exogenous shocks

parameters beta, sigma, phi_pi, phi_y, alpha, rho_a, rho_m, delta;

// Calibrated parameters for a developing economy
beta = 0.9;                  // Very low patience
sigma = 2;                   // Very high intertemporal elasticity
phi_pi = 1.1;                // Weak inflation response
phi_y = 0.2;                 // Minimal response to output
alpha = 0.5;                 // High capital share
rho_a = 0.8;                 // Low persistence of tech shocks
rho_m = 0.95;                // Extremely persistent monetary shocks
delta = 0.05;                // Very high depreciation rate

// Model equations
model;
    y = c(+1) - (1/sigma)*(r - pi(+1));                 // IS curve
    pi = beta * pi(+1) + phi_y * (y - y(-1)) + e_m;    // Phillips curve
    r = phi_pi * pi + phi_y * y + e_a;                 // Taylor rule
    y = alpha * k(-1) + (1 - alpha) * a;              // Production function
    k = (1 - delta) * k(-1) + c;                      // Capital accumulation
    a = rho_a * a(-1) + e_a;                          // Tech shock
end;

// Initial values
initval;
    y = 1;
    c = 0.8;
    pi = 0.1;
    r = 0.1;
    k = 5;
    a = 0;
    e_a = 0;
    e_m = 0;
end;

// Shocks
shocks;
    var e_a = 0.03^2;          // Highly volatile tech shocks
    var e_m = 0.05^2;          // Persistent and volatile monetary shocks
end;

stoch_simul(order=1, irf=20, periods=200, drop=50);
