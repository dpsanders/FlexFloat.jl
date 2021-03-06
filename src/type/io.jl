const PlusMinus = "±"
const Exactly   = "⌁"
const Inexactly = "~"
const OpenedOpened = "⍿"
const ClosedOpened = "⫯"
const OpenedClosed = "⫰"
const ClosedClosed = "∣"

#                        ClCl          ClOp            OpCl      OpOp
const Postfixes = ( ClosedClosed, ClosedOpened, OpenedClosed, OpenedOpened );
@inline postfixes(loIsOpen::Bool, hiIsOpen::Bool) =
      Postfixes[ one(Int8)+(reinterpret(Int8,loIsOpen)<<1)+hiIsOpen ]

# select characters corresponding to boundries as specified (lo,hi)
#   true for Open, false for Closed
#                     ClCl      ClOp        OpCl      OpOp
# const Delimiters = [ ("▪","▪"), ("▪","▫"), ("▫","▪"), ("▫","▫") ];
const Delimiters = [ ( "⟨" , "⟩" ) , ( "⟨" , "⟫" ) ,  ( "⟪" , "⟩" ), ( "⟪" , "⟫" )  ];
@inline delimiters(loIsOpen::Bool, hiIsOpen::Bool) =
      Delimiters[ one(Int8)+(reinterpret(Int8,loIsOpen)<<1)+hiIsOpen ]


function show{S<:Sculpt, Q<:Qualia, C<:Clay}(io::IO, x::Flex{S,Q,C})
    tiesym = (Q==INEXACT) ? Inexactly : Exactly
    loDelim,hiDelim = delimiters(boundries(x)...)
    s = (x.lo != x.hi) ? string(loDelim, x.lo, tiesym, x.hi, hiDelim) : string(loDelim, x.lo, tiesym, hiDelim)
    print(io, s)
end

function showcompact{S<:Sculpt, Q<:Qualia, C<:Clay}(io::IO, x::Flex{S,Q,C})
    tiesym = (Q==INEXACT) ? Inexactly : Exactly
    loDelim,hiDelim = delimiters(boundries(x)...)
    lo = @sprintf("%7.5g", x.lo); lo = strip(lo)
    hi = @sprintf("%7.5g", x.hi); hi = strip(hi)
    s = (x.lo != x.hi) ? string(loDelim, lo, tiesym, hi, hiDelim) : string(lo, tiesym)
    print(io, s)
end

function showmidrad{S<:Sculpt, Q<:Qualia, C<:Clay}(io::IO, x::Flex{S,Q,C})
    tiesym = (Q==INEXACT) ? Inexactly : Exactly
    md = @sprintf("%7.5g", mid(x)); md = strip(md)
    rd = @sprintf("%7.5g", rad(x)); rd = strip(rd)
    s = string(md, PlusMinus, rd)
    print(io, s)
end

showmidrad{S<:Sculpt, Q<:Qualia, C<:Clay}(x::Flex{S,Q,C}) = showmidrad(STDOUT,x)

function showmidpointradius{S<:Sculpt, Q<:Qualia, C<:Clay}(io::IO, x::Flex{S,Q,C})
    tiesym = (Q==INEXACT) ? Inexactly : Exactly
    md = mid(x)
    rd = rad(x)
    s  = string(md, PlusMinus, rd)
    print(io, s)
end

showmidpointradius{S<:Sculpt, Q<:Qualia, C<:Clay}(x::Flex{S,Q,C}) = showmidpointradius(STDOUT,x)

