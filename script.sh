#!/bin/bash

# Function to validate input
function valid_input(){
  case "$1" in
    Auction|Bid )
      # Valid view input
      echo "stage 1"
      return 0
      ;;
    MID|HIGH|LOW)
      # Valid scale input
      echo "Stage 2"
      return 0
      ;;
    INGESTOR|JOINER|WRANGLER|VALIDATOR)
	echo "stage 3"
	return 0
	;;
    [0-9])
	echo "stage 4"
	return 0
	;;
    *)
      return 1
      ;;
  esac
}


read -p "Select any option from this for view [Auction, Bid]: " view
while ! valid_input "$view"; do
  echo "Invalid input. Please enter either 'Auction' or 'Bid'."
  read -p "Select any option from this for view [Auction, Bid]: " view
done


read -p "Select any option from this for Scale [MID, HIGH, LOW]: " scale
while ! valid_input "$scale"; do
  echo "Invalid input. Please enter either 'MID', 'HIGH', or 'LOW'."
  read -p "Select any option from this for Scale [MID, HIGH, LOW]: " scale
done

read -p "Enter a number between 0-9: " COUNT
while ! valid_input "$COUNT"; do
  echo "Invalid input."
  read -p "Select any Number between 0-9" COUNT
done

read -p "Select any option from this for Component Name [INGESTOR, JOINER, WRANGLER,  VALIDATOR]: " component
while ! valid_input "$component"; do
  echo "Invalid input. Please enter either [INGESTOR, JOINER, WRANGLER,  VALIDATOR] "
  read -p "Select any option from this for Component Name [INGESTOR, JOINER, WRANGLER,  VALIDATOR]:" scale
done

if [ "$view" == "Auction" ]; then
    VIEW_END="vdopia"
elif [ "$view" == "Bid" ]; then
    VIEW_END="vdopia-bid"
fi

echo "$VIEW_END"

LINE="$view ; $scale; $component; ETL ; $VIEW_END= $COUNT"

echo "$LINE"

sed -i "/^.* ; $scale ; $component ; ETL ;.*/c\\$LINE" sig.conf
echo "Configuration updated successfully."
