for i in 86 108 128 172; do
    "/c/Program Files/Inkscape/inkscape.exe" -z -e "${i}x$i/harbour-airmeteo.png" -w "$i" -h "$i" icon-airmeteo.svg
done