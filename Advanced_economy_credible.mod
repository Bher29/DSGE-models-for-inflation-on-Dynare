// Advanced economy with credible central bank
var y, c, pi, r, a, k;       // Endogenous variables
varexo e_a, e_m;             // Exogenous shocks

parameters beta, sigma, phi_pi, phi_y, alpha, rho_a, rho_m, delta;

// Calibrated parameters for an advanced economy
beta = 0.99;                 // High patience
sigma = 1;                   // Standard intertemporal elasticity
phi_pi = 2.0;                // Strong response to inflation
phi_y = 0.5;                 // Moderate response to output
alpha = 0.33;                // Standard capital share
rho_a = 0.9;                 // Persistent tech shocks
rho_m = 0.3;                 // Low persistence of monetary shocks
delta = 0.025;               // Standard capital depreciation

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
    r = 0.03;
    k = 10;
    a = 0;
    e_a = 0;
    e_m = 0;
end;

// Shocks
shocks;
    var e_a = 0.01^2;          // Tech shock variance
    var e_m = 0.005^2;         // Monetary shock variance
end;

stoch_simul(order=1, irf=20, periods=200, drop=50);
