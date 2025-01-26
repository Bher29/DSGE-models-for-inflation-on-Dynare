//This very simple DSGE model aims to analyze macroeconomic dynamics in response to technological and monetary shocks.
// It takes into account the interactions between production, consumption, inflation, interest rates and capital.
var y, c, pi, r, a, k;       // 6  endogenous variables
varexo e_a, e_m;             // 2 exogenous shocks

parameters beta, sigma, phi_pi, phi_y, alpha, rho_a, rho_m, delta;

// Calibrated parameters
beta = 0.99;
sigma = 1;
phi_pi = 1.5;
phi_y = 0.5;
alpha = 0.33;
rho_a = 0.95;
rho_m = 0.8;
delta = 0.025;

// Equations
model;
    y = c(+1) - (1/sigma)*(r - pi(+1));                 // IS
    pi = beta * pi(+1) + phi_y * (y - y(-1)) + e_m;    // Phillips
    r = phi_pi * pi + phi_y * y + e_a;                 // Taylor
    y = alpha * k(-1) + (1 - alpha) * a;              // Production
    k = (1 - delta) * k(-1) + c;                      // Capital
    a = rho_a * a(-1) + e_a;                          // Tech shock
end;

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

shocks;
    var e_a = 0.01^2;
    var e_m = 0.01^2;
end;

stoch_simul(order=1, irf=20, periods=200, drop=50);
