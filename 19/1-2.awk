#!/usr/bin/env -S awk -f

function abs(v) {v += 0; return v < 0 ? -v : v}

function transform(c, v,  r, a) {
    split(c, a, ",")

    r = a[coords[v,1]]*sign[v,1] "," a[coords[v,2]]*sign[v,2] "," a[coords[v,3]]*sign[v,3]

    return r
}

function calculate_offset(c1, c2, p,  a, b, c, i, r) {
    split(c1, a, ",")
    split(c2, b, ",")
    for (i=1; i<=3; i++) c[i] = (p)? a[i] + b[i] : a[i] - b[i]
    r = c[1] "," c[2] "," c[3]

    return r
}

function check_overlap(s1, s2,  b1, b2, c, d1, d2, i, o, r) {
    for(b1=1; b1<=scanners[s1,0]; b1++) {
        for(b2=1; b2<=scanners[s2,0]; b2++) {
            c = 0;
            for(d1=1; d1<=scanners[s1,b1,"d",0]; d1++) {
                for (d2=1; d2<=scanners[s2,b2,"d",0]; d2++) {
                    if (scanners[s1,b1,"d",d1] == scanners[s2,b2,"d",d2]) {
                        c++
                    }
                }
            }
            if (c>=12) {
                o++
                beacons[s1,s2,++i] = b1 " " b2
            }
        }
    }

    return o >= 12
}


BEGIN{
    FS=" "
    #
    coords[1] =  "x,y,z"
    coords[2] =  "-y,x,z"
    coords[3] =  "-x,-y,z"
    coords[4] =  "y,-x,z"

    coords[1,1] = 1; coords[1,2] = 2; coords[1,3] = 3
    coords[2,1] = 2; coords[2,2] = 1; coords[2,3] = 3
    coords[3,1] = 1; coords[3,2] = 2; coords[3,3] = 3
    coords[4,1] = 2; coords[4,2] = 1; coords[4,3] = 3

    sign[1,1] =  1; sign[1,2] =  1; sign[1,3] = 1
    sign[2,1] = -1; sign[2,2] =  1; sign[2,3] = 1
    sign[3,1] = -1; sign[3,2] = -1; sign[3,3] = 1
    sign[4,1] =  1; sign[4,2] = -1; sign[4,3] = 1


    coords[5] =  "x,-y,-z"
    coords[6] =  "-y,-x,-z"
    coords[7] =  "-x,y,-z"
    coords[8] =  "y,x,-z"

    coords[5,1] = 1; coords[5,2] = 2; coords[5,3] = 3
    coords[6,1] = 2; coords[6,2] = 1; coords[6,3] = 3
    coords[7,1] = 1; coords[7,2] = 2; coords[7,3] = 3
    coords[8,1] = 2; coords[8,2] = 1; coords[8,3] = 3

    sign[5,1] =  1; sign[5,2] = -1; sign[5,3] = -1
    sign[6,1] = -1; sign[6,2] = -1; sign[6,3] = -1
    sign[7,1] = -1; sign[7,2] =  1; sign[7,3] = -1
    sign[8,1] =  1; sign[8,2] =  1; sign[8,3] = -1


    # about 
    coords[9] =  "-z,y,x"
    coords[10] = "-y,-z,x"
    coords[11] = "z,-y,x"
    coords[12] = "y,z,x"

    coords[9,1]  = 3; coords[9,2]  = 2; coords[9,3]  = 1
    coords[10,1] = 2; coords[10,2] = 3; coords[10,3] = 1
    coords[11,1] = 3; coords[11,2] = 2; coords[11,3] = 1
    coords[12,1] = 2; coords[12,2] = 3; coords[12,3] = 1

    sign[9,1]  = -1; sign[9,2]  =  1; sign[9,3]  = 1
    sign[10,1] = -1; sign[10,2] = -1; sign[10,3] = 1
    sign[11,1] =  1; sign[11,2] = -1; sign[11,3] = 1
    sign[12,1] =  1; sign[12,2] =  1; sign[12,3] = 1

    coords[13] = "-z,-y,-x"
    coords[14] = "y,-z,-x"
    coords[15] = "z,y,-x"
    coords[16] = "-y,z,-x"

    coords[13,1] = 3; coords[13,2] = 2; coords[13,3] = 1
    coords[14,1] = 2; coords[14,2] = 3; coords[14,3] = 1
    coords[15,1] = 3; coords[15,2] = 2; coords[15,3] = 1
    coords[16,1] = 2; coords[16,2] = 3; coords[16,3] = 1

    sign[13,1] = -1; sign[13,2] = -1; sign[13,3] = -1
    sign[14,1] =  1; sign[14,2] = -1; sign[14,3] = -1
    sign[15,1] =  1; sign[15,2] =  1; sign[15,3] = -1
    sign[16,1] = -1; sign[16,2] =  1; sign[16,3] = -1


    coords[17] = "x,-z,y"
    coords[18] = "z,x,y"
    coords[19] = "-x,z,y"
    coords[20] = "-z,-x,y"

    coords[17,1] = 1; coords[17,2] = 3; coords[17,3] = 2
    coords[18,1] = 3; coords[18,2] = 1; coords[18,3] = 2
    coords[19,1] = 1; coords[19,2] = 3; coords[19,3] = 2
    coords[20,1] = 3; coords[20,2] = 1; coords[20,3] = 2

    sign[17,1] =  1; sign[17,2] = -1; sign[17,3] =  1
    sign[18,1] =  1; sign[18,2] =  1; sign[18,3] =  1
    sign[19,1] = -1; sign[19,2] =  1; sign[19,3] =  1
    sign[20,1] = -1; sign[20,2] = -1; sign[20,3] =  1

    coords[21] = "-x,-z,-y"
    coords[22] = "z,-x,-y"
    coords[23] = "x,z,-y"
    coords[24] = "-z,x,-y"

    coords[21,1] = 1; coords[21,2] = 3; coords[21,3] = 2
    coords[22,1] = 3; coords[22,2] = 1; coords[22,3] = 2
    coords[23,1] = 1; coords[23,2] = 3; coords[23,3] = 2
    coords[24,1] = 3; coords[24,2] = 1; coords[24,3] = 2

    sign[21,1] = -1; sign[21,2] = -1; sign[21,3] = -1
    sign[22,1] =  1; sign[22,2] = -1; sign[22,3] = -1
    sign[23,1] =  1; sign[23,2] =  1; sign[23,3] = -1
    sign[24,1] = -1; sign[24,2] =  1; sign[24,3] = -1


}
!$1 {next}
$1=="---" {
    s = $3
    scanner_count++
}
$1!="---" && $1 {
    scanners[s,0]++
    scanners[s,scanners[s,0]] = $1
}

END {
    # calculate manhattan distances among beacons of each scanner
    for (s=0; s<scanner_count; s++) {
        for (b1=1; b1<=scanners[s,0]; b1++) {
            for (b2=1; b2<=scanners[s,0]; b2++) {
                #if (b1==b2) continue
                split(scanners[s,b1], c1, ",")
                split(scanners[s,b2], c2, ",")
                d = 0
                for (i in c1) {
                    d += abs(c1[i] - c2[i])
                }
                scanners[s,b1,"d",0]++
                scanners[s,b1,"d",scanners[s,b1,"d",0]] = d
            }
        }
    }

    i = 0
    queue[0] = 1
    beacons[0] = 1


    # we already know this for scanner 0
    scanners[0,"l"] = "0,0,0"
    scanners[0,"t"] = 1

    while (length(queue)) {
        for (s1 in queue) {
            seen[s1] = 1
            for (s2=0; s2<=scanner_count-1; s2++) {
                if (s1==s2) continue
                if (check_overlap(s1,s2) && !seen[s2]) {
                    print s2 " as seen by " s1
                    seen_by[s2] = s1
                    queue[s2] = 1

                    t = 0
                    while (t<24 && c != 12) {
                        t++
                        c = 0
                        for (b=1; b<=12; b++) {
                            split(beacons[s1,s2,b], a, " ")
                            l = calculate_offset(scanners[s1,a[1]], transform(scanners[s2,a[2]], t))
                            e[l] = 1
                        }
                        if (length(e) == 1) {
                            scanners[s2,"t"] = t
                            s = s1
                            while (scanners[seen_by[s],"t"]) {
                                l = transform(l, scanners[s,"t"])
                                s = seen_by[s]
                            }
                            scanners[s2,"l"] = calculate_offset(scanners[s1,"l"], l, 1)
                        }
                        delete e
                    }
                }
            }
            seen[s1] = 1
            delete queue[s1]
        }
    }

    for (s=0; s<scanner_count; s++) {
        for (b=1; b<=scanners[s,0]; b++) {
            p = s
            l = scanners[s,b]
            while (scanners[seen_by[p],"t"]) {
                l = transform(l, scanners[p,"t"])
                p = seen_by[p]
            }
            res[calculate_offset(scanners[s,"l"], l, 1)] = 1
        }
    }

    for (s1=0; s1<scanner_count-1; s1++) {
        for (s2=s1+1; s2<=scanner_count; s2++) {
            split(scanners[s1,"l"], c1, ",")
            split(scanners[s2,"l"], c2, ",")
            d = 0
            for (i in c1) {
                d += abs(c1[i] - c2[i])
            }
            if (d>max) max = d
        }
    }

    print length(res)
    print max
}
