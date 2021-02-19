module Similar

	export Tanimoto,
		Dice,
		Cosine,
		Euclidean,
		Manhattan,
		Soergel

	"""
	"""
	function Tanimoto(X::AbstractVector{T}, Y::AbstractVector{T}) where {T<:Bool}
		return sum(X .& Y) / sum(X .| Y)
	end
	
	function Tanimoto(X::AbstractVector{T}, Y::AbstractVector{T}) where {T<:Number}
		a = sum(X .^ 2)
		b = sum(Y .^ 2)
		c = sum(X .* Y)

		return c/(a+b-c)
	end
	
	function Tanimoto(M::AbstractMatrix{T}, N::AbstractMatrix{T}) where {T<:Number}
		@assert size(M,2) == size(N,2)

		Mobjects, Mfeatures = size(M)
		Nobjects, Nfeatures = size(N)
		S = zeros(Mobjects, Nobjects)

		for i in 1:Mobjects
			for j in 1:Nobjects
				S[i,j] = Tanimoto(M[i,:], N[j,:])
			end
		end

		return S
	end
	
	function Tanimoto(M::AbstractMatrix{T}) where {T<:Number}
		Mobjects, Mfeatures = size(M)
		S = zeros(Mobjects, Mobjects)

		for i in 1:Mobjects
			for j in 1:Mobjects
				S[i,j] = Tanimoto(M[i,:], M[j,:])
			end
		end

		return S
	end
	
	Dice(X::Array{Bool}, Y::Array{Bool})       = (2 * sum(X .& Y)) / (sum(X) + sum(Y))
	Dice(X::Array{Number}, Y::Array{Number})   = (2 * sum(X .* Y)) / (sum(X)^2 + sum(Y)^2)

	Cosine(X::Array{Bool}, Y::Array{Bool})     = sum(X .& Y) / (sum(X) + sum(Y))^0.5
	Cosine(X::Array{Number}, Y::Array{Number}) = sum(X .* Y) / (sum(X)^2 * sum(Y)^2)^0.5
	
	Euclidean(X::Array{Bool}, Y::Array{Bool})     = (sum(X) + sum(Y) - 2 * sum(X .| Y))^0.5
	Euclidean(X::Array{Number}, Y::Array{Number}) = (sum(X .- Y)^2)^0.5
	
	Manhattan(X::Array{Bool}, Y::Array{Bool})     = sum(X) + sum(Y) - 2 * sum(X .| Y)
	Manhattan(X::Array{Number}, Y::Array{Number}) = sum(abs.(X .- Y))
	
	Soergel(X::Array{Bool}, Y::Array{Bool})     = sum(X .& Y) / (sum(X) + sum(Y))^0.5
	Soergel(X::Array{Number}, Y::Array{Number}) = sum(X .* Y) / (sum(X)^2 * sum(Y)^2)^0.5

end
