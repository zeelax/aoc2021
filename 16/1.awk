#!/usr/bin/env -S awk -f

BEGIN {
	types["value"] = "100"
}
{message=$1}
END {
	print message
	i = 1

	# read version
	version = substr(message, i, 3)
	i+=3
	# read type ID
	type_id = substr(message, i, 3)
	i+=3
	print i

    # check type ID
	if (type_id == types["value"]) {
		# got a value
		# keep reading packages until see a 0 prefix
		while (substr(message, i, 1) == "1") {
			print substr(message, i+1, 4)
			i+=5
		}
		# read value prefixed with 0
		print substr(message, i+1, 4)
		i+=5
		# keep reading trailing zeroes
		while (substr(message, i, 1) == "0") {
			i++
		}
	} else {
		# got an operator
		# read length type ID
		length_type_id = substr(message, i, 1)
		print length_type_id
	}
}