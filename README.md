# SimpleProbabilitySets.jl
A collection of ambiguity sets, or sets of probability distributions. 

## Installation
This application is built for Julia 0.6. If not already installed, the application can be cloned using

```julia
Pkg.clone("https://github.com/ajkeith/SimpleProbabilitySets.jl")
```

## Usage

`SimpleProbabilitySets.jl` currently includes discrete P-boxes and discrete interval probability sets.

Discrete interval-based probability sets contain all probability distributions such that the probability of each component belongs to a pre-defined interval. The intervals can be defined componentwise. Note that `plower` and `pupper` are a set of lower and upper interval bounds, not probability distributions. 

```julia
using SimpleProbabilitySets

plower = [0.1, 0.2, 0.5]
pupper = [0.4, 0.4, 0.7]
uncset1 = PInterval(plower, pupper)
```

The discrete interval-based probability set can also be defined using a nominal distribution and a set interval half-width. 
 
```julia
using SimpleProbabilitySets

dnominal = [0.1, 0.2, 0.5]
halfwidth = 0.05
uncset2 = PInterval(dnominal, halfwidth)
```

Use the [Distributions.jl](https://github.com/JuliaStats/Distributions.jl) package to build a P-box from an upper and lower distribution. A discrete P-box containts all probability ditrubtions whose CDF belongs to a set of CDFs defined by an "upper" and "lower" CDF.

```julia 
using SimpleProbabilitySets
using Distributions

dlower = Categorical([0.1, 0.2, 0.7])
dupper = Categorical([0.4, 0.4, 0.2])
uncset3 = PBox(dlower, dupper)
```
