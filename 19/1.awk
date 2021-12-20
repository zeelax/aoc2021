#!/usr/bin/env -S awk -f

function abs(v) {v += 0; return v < 0 ? -v : v}

function transform(c, v,  r, a) {
    split(c, a, ",")

    r = a[coords[v,1]]*sign[v,1] "," a[coords[v,2]]*sign[v,2] "," a[coords[v,3]]*sign[v,3]

    return r
}

function calculate_offset(c1, c2,  a, b, c, i, r) {
    split(c1, a, ",")
    split(c2, b, ",")
    for (i=1; i<=3; i++) c[i] = a[i]-b[i]
    r = c[1] "," c[2] "," c[3]

    return r
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
    coords[20] = "-z,-x,-y"

    coords[17,1] = 1; coords[17,2] = 3; coords[17,3] = 2
    coords[18,1] = 3; coords[18,2] = 1; coords[18,3] = 2
    coords[19,1] = 1; coords[19,2] = 3; coords[19,3] = 2
    coords[20,1] = 3; coords[20,2] = 1; coords[20,3] = 2

    sign[17,1] =  1; sign[17,2] = -1; sign[17,3] =  1
    sign[18,1] =  1; sign[18,2] =  1; sign[18,3] =  1
    sign[19,1] = -1; sign[19,2] =  1; sign[19,3] =  1
    sign[20,1] = -1; sign[20,2] = -1; sign[20,3] = -1

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
    #b = 0
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

    # find scanners with overlaping detecting regions
    i = 0
    for (s1=0; s1<scanner_count-1; s1++) {
        for (s2=s1+1; s2<=scanner_count; s2++) {
            for(b1=1; b1<=scanners[s1,0]; b1++) {
                for(b2=1; b2<=scanners[s2,0]; b2++) {
                    c = 0;
                    for(d1=1; d1<=scanners[s1,b1,"d",0]; d1++) {
                        for (d2=1; d2<=scanners[s2,b2,"d",0]; d2++) {
                            if (scanners[s1,b1,"d",d1] == scanners[s2,b2,"d",d2]) {
                                c++
                                #print "krab", s1, s2, b1, b2
                            }
                            #print scanners[s1,b1,"d",d1], scanners[s2,b2,"d",d2]
                        }
                    }
                    if (c>=12) {
                        #print "ololo", s1, s2, b1, b2
                        scanner_overlap = 1
                        beacons[s1,s2,++i] = b1 " " b2
                    }
                    # print c
                }
            }
            #print "krabiwe"
            if (scanner_overlap) {
                overlaps[s1,++overlaps[s1,0]] = s2
                scanner_overlap = 0
                i = 0
            }
        }
        #print "krabiwe"
    }

    for (s1=0; s1<scanner_count; s1++) {
        if (overlaps[s1,0]) {
            #print overlaps[s1,0]
            for (s=1; s<=overlaps[s1,0]; s++) {
                print s1 " overlaps with " overlaps[s1,s]
                t = 0
                while (t<24 && c != 12) {
                    t++
                    c = 0
                    #print t
                    for (b=1; b<=12; b++) {
                        #print beacons[s1,overlaps[s1,s],b]
                        split(beacons[s1,overlaps[s1,s],b], a, " ")
                        #print calculate_offset(scanners[s1,a[1]], transform(scanners[overlaps[s1,s],a[2]], t))
                        e[calculate_offset(scanners[s1,a[1]], transform(scanners[overlaps[s1,s],a[2]], t))]++
                    }
                    if (length(e) == 1) scanners[overlaps[s1,s],"t"] = t
                    delete e
                }
                #print s1, overlaps[s1,s], t 
            }
        }
    }

    # for (i in overlaps) {
    #     print i, overlaps[i]
    # }

    #print beacons[0,1,5]

    #print transform("1,2,3", 1)

    print transform("68,-1246,-43", 7)
    print calculate_offset("160,-1134,-23",transform("68,-1246,-43",7))
}
