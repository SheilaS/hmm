
mu =0
sigma = sqrt(1)
x = -10 : 0.1 : 10;
pdfNormal = normpdf(x, mu, sigma);
plot(x, pdfNormal);

pdfY=normpdf(x,