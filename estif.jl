module estif
#import DSP
import cohenclass
import extif
import polywv

function ifestxvwd(z,ynorm,dx,niter)
    tfrn=cohenclass.tfrwv(z,NaN,NaN,1)
    indfn=extif.maxif(tfrn)
    for it=1:niter        
        zhat=exp(-im*cumsum(indfn)*ynorm*dx)'
        zc=[z;zhat]
        tfrn=cohenclass.tfrwv(zc,NaN,NaN,1)
        indfn=extif.maxif(abs(tfrn))
    end
    return indfn
end

function ifestxpvwd(z,ynorm,dx,niter)
    tfrn=cohenclass.tfrpwv(z,NaN,NaN,NaN,1)
    indfn=extif.maxif(tfrn)
    for it=1:niter
        zhat=exp(-im*cumsum(indfn*ynorm*dx))'
        zc=[z;zhat]
        tfrn=cohenclass.tfrpwv(zc,NaN,NaN,NaN,1)
        indfn=extif.maxif(abs(tfrn))
    end
    return indfn
end

function ifestxp4vwd(z,ynorm,dx,niter)

    tfrn=polywv.tfr4powv(z,NaN,NaN,1)
    indfn=extif.maxif(tfrn)
    for it=1:niter        
        zhat=exp(-im*cumsum(indfn)*ynorm*dx)'
        zc=[z;zhat]
        tfrn=polywv.tfr4powv(zc,NaN,NaN,1)
        indfn=extif.maxif(abs(tfrn))
    end
    return indfn
end

end