function G = gaussian(sigma)
	domain = -ceil(3*sigma):1:+ceil(3*sigma);
	const1 = (1 / sqrt(sigma * pi) );
    sigmasquare = sigma*sigma;
	const2 = -1/(2*(sigmasquare));
	G = const1*exp(const2*(domain .^ 2));
	fix_divisor = sum(G);
	G = G ./ fix_divisor;
end