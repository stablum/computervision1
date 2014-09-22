function ret = gaussianDerVec(G, sigma)
	x = -floor(size(G,2)/2):1:+floor(size(G,2)/2);
	const = -1/(sigma*sigma);
	ret = (const * x) .* G;
end