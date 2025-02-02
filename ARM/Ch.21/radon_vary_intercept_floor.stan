data {
  int<lower=0> J;
  int<lower=0> N;
  array[N] int<lower=1, upper=J> county;
  vector[N] u;
  vector[N] x;
  vector[N] y;
}
parameters {
  vector[J] a;
  vector[2] b;
  real mu_a;
  real<lower=0, upper=100> sigma_a;
  real<lower=0, upper=100> sigma_y;
}
transformed parameters {
  vector[N] y_hat;
  
  for (i in 1 : N) {
    y_hat[i] = a[county[i]] + u[i] * b[1] + x[i] * b[2];
  }
}
model {
  mu_a ~ normal(0, 1);
  a ~ normal(mu_a, sigma_a);
  b ~ normal(0, 1);
  y ~ normal(y_hat, sigma_y);
}
