// Emerging economy with persistent inflation
var y, c, pi, r, a, k;       // Endogenous variables
varexo e_a, e_m;             // Exogenous shocks

parameters beta, sigma, phi_pi, phi_y, alpha, rho_a, rho_m, delta;

// Calibrated parameters for an emerging economy
beta = 0.95;                 // Lower patience
sigma = 1.5;                 // Higher intertemporal elasticity
phi_pi = 1.2;                // Weak response to inflation
phi_y = 0.3;                 // Low response to output
alpha = 0.4;                 // Higher capital share
rho_a = 0.85;                // Less persistent tech shocks
rho_m = 0.9;                 // High persistence of monetary shocks
delta = 0.04;                // Faster capital depreciation

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
    c = 1;
    pi = 0;
    r = 0.05;
    k = 8;
    a = 0;
    e_a = 0;
    e_m = 0;
end;

// Shocks
shocks;
    var e_a = 0.02^2;          // More volatile tech shocks
    var e_m = 0.03^2;          // High volatility of monetary shocks
end;

stoch_simul(order=1, irf=20, periods=200, drop=50);
