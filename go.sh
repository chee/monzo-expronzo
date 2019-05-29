#!/bin/bash
pot_id=pot_00009idHc715Uf9KcBiUMb
access_token=eyJhbGciOiJFUzI1NiIsInR5cCI6IkpXVCJ9.eyJlYiI6IkpiMnhrdzVWNUh0WE1XMUd4bCtRIiwianRpIjoiYWNjdG9rXzAwMDA5akl2Z0RabjBjdERMOWtCeUciLCJ0eXAiOiJhdCIsInYiOiI1In0.3tZ2velWEi714dr5P2eleGG5BM6gMiCCjCyae4gg977KcBOcD1Y2F-YdjqocsKOOSHLEK2clMmI-eMstkCOEvg
account_id=acc_00009OeBcb40RrGoHJQAwD
dedupe_id=$RANDOM-lol
current_pot_value=$(http "https://api.monzo.com/pots" "Authorization: Bearer $access_token" | jq ".pots[] | select(.id==\"$pot_id\") | .balance")
echo "there's currently $current_pot_value in the amex pot"
current_balance=$(($(node index.js) * 100))
echo "the amex balance is $current_balance"
increase=$((current_balance - current_pot_value))
echo "that's an increase of $increase pennies"

if [ $increase -lt 1 ]; then
	echo "that's less than a penny, so im doin nothin"
	exit
fi

http --form PUT "https://api.monzo.com/pots/$pot_id/deposit" \
	"Authorization: Bearer $access_token" \
	"source_account_id=$account_id" \
	"amount=$increase" \
	"dedupe_id=$dedupe_id"

echo "transaction complete!!"
current_pot_value=$(http "https://api.monzo.com/pots" "Authorization: Bearer $access_token" | jq ".pots[] | select(.id==\"$pot_id\") | .balance")
echo "there's now $current_pot_value in the pot ^_^"
