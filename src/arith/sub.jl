@inline function (-){S<:Sculpt,C<:Clay}(a::Flex{S,C})
   Flex{negate(S), C}(-a.hi, -a.lo)
end

for T in (:ClCl, :OpOp)
   @eval begin
       function (-){C<:Clay}(a::Flex{$T,C}, b::Flex{$T,C})
           lo = (-)(a.lo, b.hi, RoundDown)
           hi = (-)(a.hi, b.lo, RoundUp)
           Flex{$T,C}(lo,hi)
       end
   end       
end

function (-){S<:Sculpt, T<:Sculpt, C<:Clay}(a::Flex{S,C}, b::Flex{T,C})
    aLoIsOpen, aHiIsOpen = boundries(S)
    bLoIsOpen, bHiIsOpen = boundries(T)
    cType = boundries(aLoIsOpen|bLoIsOpen, aHiIsOpen|bHiIsOpen)
    
    lo = (-)(a.lo, b.hi, RoundDown)
    hi = (-)(a.hi, b.lo, RoundUp)
       
    cType(lo,hi)
end