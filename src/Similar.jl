module Similar

	export Tanimoto,
		Dice

	Tanimoto(X::Array{Bool}, Y::Array{Bool}) = sum(X .& Y) / sum(X .| Y)
	Dice(X::Array{Bool}, Y::Array{Bool}) = (2 * sum(X .& Y)) / ( sum(X) + sum(Y) )

end
