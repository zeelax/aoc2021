NR==1 {number_count=split($1, numbers, ","); current_number=numbers[1]; next}
NR==2 {last_winner_number=$1; last_winner_sum=$2; winner_board_count=split($3, winner_board_list, ","); next}
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
        known_winner = 0
        for (i in winner_board_list) { if (winner_board_list[i] == board_count) {known_winner++}}
        if (known_winner == 0) {
            winner_board_count++
            winner_board_list[winner_board_count] = board_count
            last_winner_sum = board_sum_unmarked
            last_winner_number = current_number
        }
    }
    delete is
    delete js
}

END {
    if (number_count == 0) {print last_winner_sum*last_winner_number; exit} else {
        for (n=2; n<=number_count; n++) {(n==number_count) ? np=numbers[n] : np=numbers[n] ","; krab=krab np}
        krab = krab "\n" last_winner_number " " last_winner_sum " "
        for (w=1; w<=winner_board_count; w++) {(w==winner_board_count) ? wp=winner_board_list[w] : wp=winner_board_list[w] ","; krab=krab wp}
        for (board_index=1; board_index<=board_count; board_index++) {
            krab = krab "\n"
            for (j=1; j<=5; j++) {
                for (i=1; i<=5; i++) {
                    krab = krab board[board_index, i, j] " "
                }
                krab = krab "\n"
            }
        }
        print krab | "awk -f 2.awk"
    }    
}