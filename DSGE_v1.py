import numpy as np
import matplotlib.pyplot as plt

beta = 0.99
kappa = 0.1
phi_pi_taylor = 1.5
phi_y_taylor = 0.5
phi_pi_strict = 3.0
rho_u = 0.3
rho_a = 0.9
sigma = 1
n_periods = 50

np.random.seed(42)
eps_u = np.random.normal(0, 0.01, n_periods)
eps_a = np.random.normal(0, 0.01, n_periods)

pi_taylor = np.zeros(n_periods)
pi_strict = np.zeros(n_periods)
y_gap_taylor = np.zeros(n_periods)
y_gap_strict = np.zeros(n_periods)
i_taylor = np.zeros(n_periods)
i_strict = np.zeros(n_periods)
r_nat = np.zeros(n_periods)
u = np.zeros(n_periods)
a = np.zeros(n_periods)

for t in range(1, n_periods):
    u[t] = rho_u * u[t - 1] + eps_u[t]
    a[t] = rho_a * a[t - 1] + eps_a[t]
    r_nat[t] = sigma * (a[t] - a[t - 1])
    pi_taylor[t] = beta * pi_taylor[t - 1] + kappa * y_gap_taylor[t - 1] + u[t]
    pi_strict[t] = beta * pi_strict[t - 1] + kappa * y_gap_strict[t - 1] + u[t]
    y_gap_taylor[t] = y_gap_taylor[t - 1] - (1 / sigma) * (i_taylor[t - 1] - pi_taylor[t - 1] - r_nat[t])
    y_gap_strict[t] = y_gap_strict[t - 1] - (1 / sigma) * (i_strict[t - 1] - pi_strict[t - 1] - r_nat[t])
    i_taylor[t] = phi_pi_taylor * pi_taylor[t] + phi_y_taylor * y_gap_taylor[t]
    i_strict[t] = phi_pi_strict * pi_strict[t]

plt.figure(figsize=(14, 10))

plt.subplot(2, 2, 1)
plt.plot(pi_taylor, label="Taylor Rule ($\pi$)", color="blue")
plt.plot(pi_strict, label="Strict Inflation Targeting ($\pi$)", color="orange")
plt.axhline(0, color="red", linestyle="--", alpha=0.7)
plt.title("Inflation Comparison")
plt.xlabel("Time Period")
plt.ylabel("Inflation")
plt.legend()
plt.grid()

plt.subplot(2, 2, 2)
plt.plot(y_gap_taylor, label="Taylor Rule ($y_{gap}$)", color="green")
plt.plot(y_gap_strict, label="Strict Inflation Targeting ($y_{gap}$)", color="brown")
plt.axhline(0, color="red", linestyle="--", alpha=0.7)
plt.title("Output Gap Comparison")
plt.xlabel("Time Period")
plt.ylabel("Output Gap")
plt.legend()
plt.grid()

plt.subplot(2, 2, 3)
plt.plot(i_taylor, label="Taylor Rule ($i$)", color="purple")
plt.plot(i_strict, label="Strict Inflation Targeting ($i$)", color="cyan")
plt.axhline(0, color="red", linestyle="--", alpha=0.7)
plt.title("Nominal Interest Rate Comparison")
plt.xlabel("Time Period")
plt.ylabel("Interest Rate")
plt.legend()
plt.grid()

plt.subplot(2, 2, 4)
plt.plot(u, label="Cost-Push Shock ($u$)", color="orange")
plt.plot(a, label="Technology Shock ($a$)", color="brown", alpha=0.7)
plt.axhline(0, color="red", linestyle="--", alpha=0.7)
plt.title("Shocks ($u$ and $a$)")
plt.xlabel("Time Period")
plt.ylabel("Shock Value")
plt.legend()
plt.grid()

plt.tight_layout()
plt.show()
