#!/bin/bash

set -e

#echo "patch auto complete"
#wget https://st.suckless.org/patches/autocomplete/st-autocomplete-20220110-234714-st-0.8.4-testrelease.diff
#
#patch -i st-autocomplete-20220110-234714-st-0.8.4-testrelease.diff
#
#echo "patch scroll"
#wget https://st.suckless.org/patches/scrollback/st-scrollback-20210507-4536f46.diff
#wget https://st.suckless.org/patches/scrollback/st-scrollback-mouse-altscreen-20200416-5703aa0.diff
#wget https://st.suckless.org/patches/scrollback/st-scrollback-mouse-increment-0.8.2.diff
#
#patch -i st-scrollback-20210507-4536f46.diff
#patch -i st-scrollback-mouse-altscreen-20200416-5703aa0.diff
#patch -i st-scrollback-mouse-increment-0.8.2.diff

# echo "patch clipboard"
# wget https://st.suckless.org/patches/clipboard/st-clipboard-20180309-c5ba9c0.diff
# patch -i st-clipboard-20180309-c5ba9c0.diff

#wget https://st.suckless.org/patches/externalpipe/st-externalpipe-0.8.4.diff
#patch -i st-externalpipe-0.8.4.diff
##
#wget https://st.suckless.org/patches/externalpipe/st-externalpipe-eternal-0.8.3.diff
#patch -i st-externalpipe-eternal-0.8.3.diff
##
# wget https://st.suckless.org/patches/rightclickpaste/st-rightclickpaste-0.8.2.diff
# patch -i st-rightclickpaste-0.8.2.diff

# wget https://st.suckless.org/patches/alpha/st-alpha-0.8.2.diff
# patch -i st-alpha-0.8.2.diff

#wget https://st.suckless.org/patches/anysize/st-anysize-0.8.4.diff
#patch -i st-anysize-0.8.4.diff

make clean; sudo make install
