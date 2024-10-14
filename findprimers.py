import streamlit as st
st.title("Primer designer")
seq=st.text_input("Gene Sequence").lower()
fsite=st.text_input("Forward res site Sequence").lower()
rsite=st.text_input("Reverse res Sequence").lower()
if len(seq)!=0 and len(fsite)!=0 and len(rsite)!=0:
    seq=fsite+seq+rsite
    lenrsite=len(rsite)
    fprimers=[]
    rprimers=[]
    pprimers=[]
    plen=33
    def gc(seq):
        g=seq.count("g")
        c=seq.count("c")
        return (g+c)/len(seq)*100
    def mt(seq):
        g=seq.count("g")
        c=seq.count("c")
        return (64.9+41*(g+c-16.4)/len(seq))
    def rcomp(seq):
        seq=seq[::-1]
        cseq=""
        for b in seq:
            if b=="g":
                cseq+="c"
            elif b=="c":
                cseq+="g"
            elif b=="a":
                cseq+="t"
            else:
                cseq+="a"
        return cseq
    i=18
    while i<plen:
        if seq[i-1]=="g" or seq[i-1]=="c":
            tempseq=seq[:i]
            fprimers.append(tempseq)
        i+=1
    i=18
    while i<plen:
        if seq[-i]=="g" or seq[-i]=="c":
            tempseq=seq[-i:]
            tempseq=rcomp(tempseq)
            rprimers.append(tempseq)
        i+=1
    for fp in fprimers:
        for rp in rprimers:
            fpgc=gc(fp)
            rpgc=gc(rp)
            if (fpgc>=40 and fpgc<=60) and (rpgc>=40 and rpgc<=60):
                fpmt=mt(fp)
                rpmt=mt(rp)
                if (fpmt>=50 and fpmt<=60) and (rpmt>=50 and rpmt<=60):
                    delta=abs(float(fpmt-rpmt))
                    if delta<=1:
                        rp=rsite+rp[lenrsite:]
                        primersstr=f"{fp}:{round(fpgc,3)}:{round(fpmt,3)}:{len(fp)}:{rp}:{round(rpgc,3)}:{round(rpmt,3)}:{len(rp)}:{round(delta,3)}"
                        pprimers.append(primersstr)
    sorted_pprimers = sorted(pprimers, key=lambda item: max(int(item.split(':')[3]), int(item.split(':')[7])))
    for p in sorted_pprimers:
        pf=p.split(":")
        fpp=""
        fpp+=(f"forward primer:{pf[0].upper()}:{pf[1]}:{pf[2]}:{pf[3]}")
        fpp+=(f"\nreverse primer:{pf[4].upper()}:{pf[5]}:{pf[6]}:{pf[7]}")
        fpp+=(f"\ndelta:{pf[-1]}")
        st.text(fpp)
