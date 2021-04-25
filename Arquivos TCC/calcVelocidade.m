function c = calcVelocidade(temperatura, salinidade, profundidade)
  c = 1448.96 + 4.591 * temperatura - 0.05304 * temperatura^2;
  c += 2.374 * 10^(-4) * temperatura^3 + 1.340 * (salinidade - 35);
  c += 0.0163 * profundidade + 1.675 * 10^(-7) * profundidade^2;
  c -= 0.01025 * temperatura * (salinidade - 35);
  c -= 7.139 * 10^(-13) * temperatura * profundidade^3;
endfunction
