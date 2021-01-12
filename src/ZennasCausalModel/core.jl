module CausalCore

using Distributions: Distribution
using Statistics
export ExogenousVariable, EndogenousVariable, intervene, randomsample, prob, cond

abstract type Variable end

"An exogenous variable with `dist` as prior distribution"
struct ExogenousVariable{D <: Distribution} <: Variable
  name::Symbol
  dist::D
end

Base.show(io::IO, u::ExogenousVariable) = Base.print(io, "$(u.name) ~ $(u.dist)")

"""
Endogenous variable `f(args)` where a ∈ args is:
constant, exogenous or endogenous variable
"""
struct EndogenousVariable{F, ARGS} <: Variable
  func::F 
  args::ARGS
end


Base.show(io::IO, v::EndogenousVariable) = Base.print(io, "$(v.func)($(v.args...))")

# Treat constants as constant functions, i.e. f(x) = c
apply(constant, u) = ..

# u(u_)
apply(u::ExogenousVariable, u_) = ..

"`v(u)` -- apply `v` to context `u`"
apply(v::EndogenousVariable, u_) = ..


# f(x) = apply(f, x)
(v::Variable)(u) = apply(v, u) # Look up this syntax if you do not understand it!

intervene(U::ExogenousVariable, X, x) = U

"Produce a new endogenousu variable 'v'' that is interved such that X is x"
function intervene(V::EndogenousVariable, X, x)
  ..
end

## Sampling
struct Context
  vals::Dict{Symbol, Any}
end

"apply some endogenous variable to some context to produce a value"
function apply(u::ExogenousVariable, u_::Context)
  ..
end

"Sample estimate of probability using `n` samples"
prob(v; n = 1000000) = ..

"Conditional Endogenous Variable `A | B`"
struct CondEndogenousVariable{A, B} <: Variable
  a::A    # Arbitrary endogenous variable
  b::B    # Boolean valued endogenous variable
end

"`a | b` -- `a` given that `b` is true"
cond(a, b) = CondEndogenousVariable(a, b)

"Error to be thrown when `v(u)` violates conditions`"
struct UnsatisfiedCondition <: Exception
end

# Should throw an UnsatisfiedCondition Exception if condition is not satisfied
function apply(v::CondEndogenousVariable, u)
  ..
end

"Produce a sample from from `v`"
function randomsample(v::Variable)
end

end