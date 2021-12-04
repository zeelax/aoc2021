NR==1 {number_count=split($1, numbers, ","); current_number=numbers[1]; next}
  ((NR-3) % 6)==0 {
    board_count++
    board_sum_unmarked = 0
    winner = 0
    for (j=1; j<=5; j++) {
        for (i=1; i<=5; i++) {
            if ($i == current_number) {
                n = "x"
                is[i]++;
                js[j]++;
            } else {
                n = $i
                if ($i == "x") {
                    is[i]++;
                    js[j]++;
                } else {
                    board_sum_unmarked+=$i;
                }
            }
            
            if (is[i] == 5 || js[j] == 5) {winner = 1}
            board[board_count, i, j] = n
        };
        getline
    }
    if (winner == 1) {
        print board_sum_unmarked*current_number
        exit
    }
    delete is
    delete js
}

END {
    if (winner == 1) {exit} else {
        for (n=2; n<=number_count; n++) {(n==number_count) ? np=numbers[n] : np=numbers[n] ","; krab=krab np}
        krab = krab "\n"
        for (board_index=1; board_index<=board_count; board_index++) {
            krab = krab "\n"
            for (j=1; j<=5; j++) {
                for (i=1; i<=5; i++) {
                    krab = krab board[board_index, i, j] " "
                }
                krab = krab "\n"
            }
        }
        print krab | "awk -f 1.awk"
    }    
}