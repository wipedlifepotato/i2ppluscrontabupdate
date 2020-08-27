#!/bin/bash
website=https://i2pplus.com/
i2pupdatezip=i2pupdate.zip
i2pupdatetorrent=i2pupdate.zip.torrent
i2pdir=/home/user/.i2p
i2psnarkdir=/home/user/.i2p/i2psnark
getI2PUpdate(){
	echo "download ${website}/${i2pupdatezip}"
	wget "${website}/${i2pupdatezip}" -O tmp.zip
	echo "download ${website}/${i2pupdatezip}"
	wget "${website}/${i2pupdatetorrent}" -O tmp.torrent
}

checkLastIs(){
	if ! test -e old.zip || ! test -e old.torrent;then
		mv tmp.zip old.zip
		mv tmp.torrent old.torrent
		return 0
	fi;
	md5old_zip=`md5sum old.zip`
	md5old_torrent=`md5sum old.torrent`	
	if [[ "$md5old_zip" == "`md5sum tmp.zip`" ]]; then
			return 0
	else
			return 1
	fi;

}
getI2PUpdate
if checkLastIs;then
	echo "install"
	mv tmp.zip old.zip &2> /dev/null
	mv tmp.torrent old.torrent &2> /dev/null

	cp old.zip $i2pdir/i2pupdate.zip
	cp old.torrent $i2psnarkdir/i2pupdate.zip.`date +%s`.torrent
fi;
